//
//  MKGADeviceDataController.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGADeviceDataController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"

#import "MKGAMQTTManager.h"
#import "MKGAMQTTInterface.h"

#import "MKGADeviceModeManager.h"
#import "MKGADeviceModel.h"

#import "MKGADeviceDataTableHeaderView.h"
#import "MKGADeviceDataPageCell.h"

#import "MKGASettingController.h"
#import "MKGAUploadOptionController.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKGADeviceDataController ()<UITableViewDelegate,
UITableViewDataSource,
MKGADeviceDataTableHeaderViewDelegate>

@property (nonatomic, strong)MKGADeviceDataTableHeaderView *headerView;

@property (nonatomic, strong)MKGADeviceDataTableHeaderViewModel *headerModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation MKGADeviceDataController

- (void)dealloc {
    NSLog(@"MKGADeviceDataController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
    [MKGAMQTTManager singleDealloc];
    [MKGADeviceModeManager sharedDealloc];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
    [self runloopObserver];
    [self addNotifications];
}

#pragma mark - super method
- (void)rightButtonMethod {
    MKGASettingController *vc = [[MKGASettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGADeviceDataPageCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGADeviceDataPageCell *cell = [MKGADeviceDataPageCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - MKGADeviceDataTableHeaderViewDelegate
- (void)ga_updateLoadButtonAction {
    MKGAUploadOptionController *vc = [[MKGAUploadOptionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ga_scannerStatusChanged:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGAMQTTInterface ga_configScanSwitchStatus:isOn
                                          scanTime:[self.headerModel.scanTime integerValue]
                                          deviceID:[MKGADeviceModeManager shared].deviceID
                                        macAddress:[MKGADeviceModeManager shared].macAddress
                                             topic:[MKGADeviceModeManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = isOn;
        [self updateStatus];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)ga_scannerTimeChanged:(NSString *)time {
    self.headerModel.scanTime = time;
}

- (void)ga_saveButtonAction {
    if (!ValidStr(self.headerModel.scanTime) || [self.headerModel.scanTime integerValue] < 10 || [self.headerModel.scanTime integerValue] > 65535) {
        [self.view showCentralToast:@"Scan time 10~65535"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGAMQTTInterface ga_configScanSwitchStatus:self.headerModel.isOn
                                          scanTime:[self.headerModel.scanTime integerValue]
                                          deviceID:[MKGADeviceModeManager shared].deviceID
                                        macAddress:[MKGADeviceModeManager shared].macAddress
                                             topic:[MKGADeviceModeManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - note
- (void)receiveDeviceDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"device_id"]) || ![[MKGADeviceModeManager shared].deviceID isEqualToString:user[@"device_info"][@"device_id"]]) {
        return;
    }
    NSArray *tempList = user[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        NSString *jsonString = [self convertToJsonData:dic];
        if (ValidStr(jsonString)) {
            MKGADeviceDataPageCellModel *cellModel = [[MKGADeviceDataPageCellModel alloc] init];
            cellModel.msg = jsonString;
            if (self.dataList.count == 0) {
                [self.dataList addObject:cellModel];
            }else {
                [self.dataList insertObject:cellModel atIndex:0];
            }
        }
    }
    [self needRefreshList];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if(!policyData && error){
        return @"";
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return policyStr;
}


- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![[MKGADeviceModeManager shared].macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    self.defaultTitle = user[@"deviceName"];
}

- (void)receiveDeviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"deviceID"]) || ![[MKGADeviceModeManager shared].deviceID isEqualToString:user[@"deviceID"]]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view showCentralToast:@"Device is off-line!"];
    [self popToViewControllerWithClassName:@"MKGADeviceListController"];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGAMQTTInterface ga_readScanSwitchPramsWithDeviceID:[MKGADeviceModeManager shared].deviceID
                                                 macAddress:[MKGADeviceModeManager shared].macAddress
                                                      topic:[MKGADeviceModeManager shared].subscribedTopic
                                                   sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = ([returnData[@"data"][@"scan_switch"] integerValue] == 1);
        self.headerModel.scanTime = [NSString stringWithFormat:@"%ld",(long)[returnData[@"data"][@"scan_time"] integerValue]];
        self.headerView.dataModel = self.headerModel;
        [self updateStatus];
    }
                                                failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method

/// 当扫描状态发生改变的时候，需要动态刷新UI，如果打开则添加扫描数据监听，如果关闭，则移除扫描数据监听
- (void)updateStatus {
    [self.dataList removeAllObjects];
    self.headerModel.totalNum = self.dataList.count;
    [self.headerView setDataModel:self.headerModel];
    [self.tableView reloadData];
    if (self.headerModel.isOn) {
        //打开
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeviceDatas:)
                                                     name:MKGAReceiveDeviceDatasNotification
                                                   object:nil];
        return;
    }
    //关闭状态
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MKGAReceiveDeviceDatasNotification
                                                  object:nil];
}

#pragma mark - 定时刷新

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                self.headerModel.totalNum = self.dataList.count;
                self.headerView.dataModel = self.headerModel;
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_ga_deviceNameChangedNotification"
                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveDeviceOffline:)
//                                                 name:MKGADeviceModelOfflineNotification
//                                               object:nil];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKGADeviceModeManager shared].deviceName;
    [self.rightButton setImage:LOADICON(@"MKGatewayABEight", @"MKGADeviceDataController", @"ga_moreIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKGADeviceDataTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKGADeviceDataTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 180.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (MKGADeviceDataTableHeaderViewModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [[MKGADeviceDataTableHeaderViewModel alloc] init];
    }
    return _headerModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
