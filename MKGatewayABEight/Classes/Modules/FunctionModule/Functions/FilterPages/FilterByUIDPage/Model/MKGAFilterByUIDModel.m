//
//  MKGAFilterByUIDModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/30.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAFilterByUIDModel.h"

#import "MKMacroDefines.h"

#import "MKGADeviceModeManager.h"

#import "MKGAMQTTInterface.h"

@interface MKGAFilterByUIDModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;
@end

@implementation MKGAFilterByUIDModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterByUID]) {
            [self operationFailedBlockWithMsg:@"Read Filter UID Error" block:failedBlock];
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
        if (![self configFilterByUID]) {
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
- (BOOL)readFilterByUID {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_readFilterByUIDWithDeviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch"] integerValue] == 1);
        self.instanceID = [returnData[@"data"][@"instance"] lowercaseString];
        self.namespaceID = returnData[@"data"][@"namespace"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByUID {
    __block BOOL success = NO;
    [MKGAMQTTInterface ga_configFilterByUID:self.isOn namespaceID:self.namespaceID instanceID:self.instanceID deviceID:[MKGADeviceModeManager shared].deviceID macAddress:[MKGADeviceModeManager shared].macAddress topic:[MKGADeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterUIDParams"
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
        _readQueue = dispatch_queue_create("filterUIDQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
