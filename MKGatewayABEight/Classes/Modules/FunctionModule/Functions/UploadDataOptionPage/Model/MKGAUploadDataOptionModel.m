//
//  MKGAUploadDataOptionModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/2.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAUploadDataOptionModel.h"

#import "MKMacroDefines.h"

#import "MKGADeviceModeManager.h"

#import "MKGAMQTTInterface.h"

@interface MKGAUploadDataOptionModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGAUploadDataOptionModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readUploadDataOption]) {
            [self operationFailedBlockWithMsg:@"Read Upload Data option Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configUploadDataOption]) {
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

#pragma mark - interface
- (BOOL)readUploadDataOption {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_readUploadDataOptionWithDeviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timestamp = ([returnData[@"data"][@"timestamp"] integerValue] == 1);
        self.deviceType = ([returnData[@"data"][@"type"] integerValue] == 1);
        self.rssi = ([returnData[@"data"][@"rssi"] integerValue] == 1);
        self.rawData_advertising = ([returnData[@"data"][@"adv"] integerValue] == 1);
        self.rawData_response = ([returnData[@"data"][@"rsp"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUploadDataOption {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_configUploadDataOption:self deviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"uploadParams"
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
        _readQueue = dispatch_queue_create("uploadQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
