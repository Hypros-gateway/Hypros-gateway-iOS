//
//  MKGAMQTTSettingForDeviceController.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAMQTTSettingForDeviceController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"

#import "MKGADeviceModeManager.h"
#import "MKGADeviceModel.h"

#import "MKGAMQTTSettingForDeviceCell.h"

@interface MKGAMQTTSettingForDeviceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKGAMQTTSettingForDeviceController

- (void)dealloc {
    NSLog(@"MKGAMQTTSettingForDeviceController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGAMQTTSettingForDeviceCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGAMQTTSettingForDeviceCell *cell = [MKGAMQTTSettingForDeviceCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [self.protocol ga_readDeviceMQTTServerInfoWithDeviceID:[MKGADeviceModeManager shared].deviceID
                                                macAddress:[MKGADeviceModeManager shared].macAddress
                                                     topic:[MKGADeviceModeManager shared].subscribedTopic
                                                  sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellDatas:returnData[@"data"]];
    }
                                               failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - updateCellDatas
- (void)updateCellDatas:(NSDictionary *)dic {
    MKGAMQTTSettingForDeviceCellModel *cellModel1 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel1.msg = @"Type";
    cellModel1.rightMsg = ([dic[@"connect_type"] integerValue] == 0) ? @"TCP" : @"SSL";
    [self.dataList addObject:cellModel1];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel2 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel2.msg = @"Host";
    cellModel2.rightMsg = dic[@"host"];
    [self.dataList addObject:cellModel2];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel3 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel3.msg = @"Port";
    cellModel3.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"port"] integerValue]];
    [self.dataList addObject:cellModel3];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel4 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel4.msg = @"Clean session";
    cellModel4.rightMsg = ([dic[@"clean_session"] integerValue] == 1) ? @"YES" : @"NO";
    [self.dataList addObject:cellModel4];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel5 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel5.msg = @"Username";
    cellModel5.rightMsg = dic[@"username"];
    [self.dataList addObject:cellModel5];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel6 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel6.msg = @"Password";
    cellModel6.rightMsg = dic[@"password"];
    [self.dataList addObject:cellModel6];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel7 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel7.msg = @"Qos";
    cellModel7.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"qos"] integerValue]];
    [self.dataList addObject:cellModel7];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel8 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel8.msg = @"Keep Alive";
    cellModel8.rightMsg = [NSString stringWithFormat:@"%ld",(long)[dic[@"keep_alive"] integerValue]];
    [self.dataList addObject:cellModel8];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel9 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel9.msg = @"Published Topic";
    cellModel9.rightMsg = dic[@"publish_topic"];
    [self.dataList addObject:cellModel9];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel10 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel10.msg = @"Subscribed Topic";
    cellModel10.rightMsg = dic[@"subscribe_topic"];
    [self.dataList addObject:cellModel10];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel11 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel11.msg = @"Client ID";
    cellModel11.rightMsg = dic[@"client_id"];
    [self.dataList addObject:cellModel11];
    
    MKGAMQTTSettingForDeviceCellModel *cellModel12 = [[MKGAMQTTSettingForDeviceCellModel alloc] init];
    cellModel12.msg = @"Device ID";
    cellModel12.rightMsg = dic[@"device_id"];
    [self.dataList addObject:cellModel12];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"MQTT settings for Device";
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
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
