//
//  MKGAAdvBeaconModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2023/8/7.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKGAAdvBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGADeviceModeManager.h"

#import "MKGAMQTTInterface.h"

@interface MKGAAdvBeaconParamsModel : NSObject<ga_advBeaconParamsProtocol>

/// 0~65535
@property (nonatomic, assign)NSInteger major;

/// 0~65535
@property (nonatomic, assign)NSInteger minor;

/// 16 Bytes.
@property (nonatomic, copy)NSString *uuid;

/// 1~100(Unit:100ms)
@property (nonatomic, assign)NSInteger advInterval;

/*
 0：-40dbm
 1：-20dbm
 2：-8dbm
 3：-4dbm
 4：0dbm
 5：4dbm
 6：8dbm
 */
@property (nonatomic, assign)NSInteger txPower;

/// -100dBm~0dBm.
@property (nonatomic, assign)NSInteger rssi;

@end

@implementation MKGAAdvBeaconParamsModel
@end

@interface MKGAAdvBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGAAdvBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAdvStatus]) {
            [self operationFailedBlockWithMsg:@"Read Adv Status Error" block:failedBlock];
            return;
        }
        if (![self readAdvParams]) {
            [self operationFailedBlockWithMsg:@"Read Adv Params Error" block:failedBlock];
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
        NSString *msg = [self validMsg];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configAdvStatus]) {
            [self operationFailedBlockWithMsg:@"Config Adv Status Error" block:failedBlock];
            return;
        }
        if (![self configAdvParams]) {
            [self operationFailedBlockWithMsg:@"Config Adv Params Error" block:failedBlock];
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
- (BOOL)readAdvStatus {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_readAdvBeaconStatusWithDeviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advertise = ([returnData[@"data"][@"ibeacon_enable"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvStatus {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_configAdvBeaconStatus:self.advertise deviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvParams {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_readAdvBeaconParamsWithDeviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.major = [NSString stringWithFormat:@"%@",returnData[@"data"][@"major"]];
        self.minor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"minor"]];
        self.uuid = returnData[@"data"][@"uuid"];
        self.rssi = [returnData[@"data"][@"rssi_1m"] integerValue];
        self.txPower = [self loadTxPower:[returnData[@"data"][@"tx_power"] integerValue]];
        self.advInterval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"adv_interval"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvParams {
    __block BOOL success = NO;
    
    MKGAAdvBeaconParamsModel *model = [[MKGAAdvBeaconParamsModel alloc] init];
    model.major = [self.major integerValue];
    model.minor = [self.minor integerValue];
    model.uuid = self.uuid;
    model.advInterval = [self.advInterval integerValue];
    model.txPower = self.txPower;
    model.rssi = self.rssi;
    
    [MKGAMQTTInterface ga_configAdvBeaconParams:model deviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"advBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)validMsg {
    if (!self.advertise) {
        return @"";
    }
    if (!ValidStr(self.major) || [self.major integerValue] < 0 || [self.major integerValue] > 65535) {
        return @"Major error";
    }
    if (!ValidStr(self.minor) || [self.minor integerValue] < 0 || [self.minor integerValue] > 65535) {
        return @"Minor error";
    }
    if (!ValidStr(self.uuid) || self.uuid.length != 32 || ![self.uuid regularExpressions:isHexadecimal]) {
        return @"UUID error";
    }
    if (!ValidStr(self.advInterval) || [self.advInterval integerValue] < 1 || [self.advInterval integerValue] > 100) {
        return @"Adv Interval error";
    }
    if (self.rssi < -100 || self.rssi > 0) {
        return @"Rssi error";
    }
    return @"";
}

- (NSInteger)loadTxPower:(NSInteger)txPower {
    if (txPower == -40) {
        return 0;
    }
    if (txPower == -20) {
        return 1;
    }
    if (txPower == -8) {
        return 2;
    }
    if (txPower == -4) {
        return 3;
    }
    if (txPower == 0) {
        return 4;
    }
    if (txPower == 4) {
        return 5;
    }
    if (txPower == 8) {
        return 6;
    }
    return 0;
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
        _readQueue = dispatch_queue_create("advBeaconQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
