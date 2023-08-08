//
//  MKGAMMQTTManager.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/16.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAMMQTTManager.h"

#import "MKMacroDefines.h"

#import "MKGAMQTTServerManager.h"

NSString *const MKGAMMQTTSessionManagerStateChangedNotification = @"MKGAMMQTTSessionManagerStateChangedNotification";

//相关通知
//设备上报的状态信息
NSString *const MKGAMReceiveDeviceNetStateNotification = @"MKGAMReceiveDeviceNetStateNotification";

static MKGAMMQTTManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKGAMMQTTManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKGAMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKGAMMQTTManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGAMMQTTManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKGAMQTTServerManager shared] removeDataManager:self];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKGAServerManagerProtocol
- (void)ga_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidStr(topic) || !ValidDict(data)) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *deviceID = data[@"device_info"][@"device_id"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGAMReceiveDeviceNetStateNotification
                                                        object:nil
                                                      userInfo:@{@"deviceID":deviceID}];
}

- (void)ga_didChangeState:(MKGAMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGAMMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKGAMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKGAMQTTServerManager shared].serverParams.publishTopic;
}

- (BOOL)needConfigMQTTForApp {
    return !(ValidStr([MKGAMQTTServerManager shared].serverParams.host));
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKGAMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKGAMQTTServerManager shared] unsubscriptions:topicList];
}

- (MKGAMQTTSessionManagerState)state {
    return [MKGAMQTTServerManager shared].state;
}

@end
