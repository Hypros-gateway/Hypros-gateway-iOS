//
//  MKGADeviceModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGADeviceModel.h"

#import "MKMacroDefines.h"

#import "MKGAMQTTServerManager.h"

NSString *const MKGADeviceModelOfflineNotification = @"MKGADeviceModelOfflineNotification";

@interface MKGADeviceModel ()

/**
 超过40s没有接收到信息，则认为离线
 */
@property (nonatomic, strong)dispatch_source_t receiveTimer;

@property (nonatomic, assign)NSInteger receiveTimerCount;

@property (nonatomic, assign)BOOL offline;

@end

@implementation MKGADeviceModel

- (void)dealloc{
    NSLog(@"MKGADeviceModel销毁");
}

#pragma mark - public method

- (void)startStateMonitoringTimer{
    if (self.onLineState == MKGADeviceModelStateOffline) {
        return;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.receiveTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.receiveTimerCount = 0;
    dispatch_source_set_timer(self.receiveTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.receiveTimer, ^{
        @strongify(self);
        if (self.receiveTimerCount >= 62.f) {
            //接受数据超时
            dispatch_cancel(self.receiveTimer);
            self.receiveTimerCount = 0;
            self.onLineState = MKGADeviceModelStateOffline;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:MKGADeviceModelOfflineNotification
                                                                    object:nil
                                                                  userInfo:@{@"deviceID":self.deviceID}];
                if ([self.delegate respondsToSelector:@selector(ga_deviceOfflineWithDeviceID:)]) {
                    [self.delegate ga_deviceOfflineWithDeviceID:self.deviceID];
                }
            });
            return ;
        }
        self.receiveTimerCount ++;
    });
    dispatch_resume(self.receiveTimer);
}

- (void)resetTimerCounter{
    if (self.onLineState == MKGADeviceModelStateOffline) {
        //已经离线，重新开启定时器监测
        [self startStateMonitoringTimer];
        return;
    }
    self.receiveTimerCount = 0;
}

/**
 取消定时器
 */
- (void)cancel{
    self.receiveTimerCount = 0;
    self.offline = NO;
    if (self.receiveTimer) {
        dispatch_cancel(self.receiveTimer);
    }
}

- (NSString *)currentSubscribedTopic {
    if (ValidStr([MKGAMQTTServerManager shared].serverParams.publishTopic)) {
        return [MKGAMQTTServerManager shared].serverParams.publishTopic;
    }
    return self.subscribedTopic;
}

- (NSString *)currentPublishedTopic {
    if (ValidStr([MKGAMQTTServerManager shared].serverParams.subscribeTopic)) {
        return [MKGAMQTTServerManager shared].serverParams.subscribeTopic;
    }
    return self.publishedTopic;
}

@end
