//
//  MKGAFilterByAdvNameModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAFilterByAdvNameModel.h"

#import "MKMacroDefines.h"

#import "MKGADeviceModeManager.h"

#import "MKGAMQTTInterface.h"

@interface MKGAFilterByAdvNameModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGAFilterByAdvNameModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataList = @[];
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterByName]) {
            [self operationFailedBlockWithMsg:@"Read Datas Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithNameList:(NSArray <NSString *>*)nameList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configFilterByName:nameList]) {
            [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)readFilterByName {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_readFilterByAdvNameWithDeviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.preciseMatch = ([returnData[@"data"][@"precise"] integerValue] == 1);
        self.reverseFilter = ([returnData[@"data"][@"reverse"] integerValue] == 1);
        if (ValidArray(returnData[@"data"][@"rule"])) {
            self.dataList = returnData[@"data"][@"rule"];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByName:(NSArray <NSString *>*)nameList {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_configFilterByADVName:nameList preciseMatch:self.preciseMatch reverseFilter:self.reverseFilter deviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"filterNameParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("filterNameQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
