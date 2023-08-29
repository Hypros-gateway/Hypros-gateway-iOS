//
//  MKGAInterface.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKGACentralManager.h"
#import "MKGAOperationID.h"
#import "MKGAOperation.h"
#import "CBPeripheral+MKGAAdd.h"

#define centralManager [MKGACentralManager shared]
#define peripheral ([MKGACentralManager shared].peripheral)

@implementation MKGAInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)ga_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ga_taskReadFirmwareOperation
                           characteristic:peripheral.ga_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ga_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ga_taskReadHardwareOperation
                           characteristic:peripheral.ga_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************自定义协议读取************************************************

+ (void)ga_readWIFISSIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000200";
    [centralManager addTaskWithTaskID:mk_ga_taskReadWIFISSIDOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readWIFIPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000300";
    [centralManager addTaskWithTaskID:mk_ga_taskReadWIFIPasswordOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000400";
    [centralManager addTaskWithTaskID:mk_ga_taskReadConnectModeOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000500";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerHostOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000600";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerPortOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000700";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerCleanSessionOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000800";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerKeepAliveOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000900";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerQosOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000a00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadClientIDOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readDeviceIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000b00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadDeviceIDOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000c00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadSubscibeTopicOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000d00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadPublishTopicOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000e00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadNTPServerHostOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readDeviceMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001000";
    [centralManager addTaskWithTaskID:mk_ga_taskReadDeviceMacAddressOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSString *commandString = @"ed001100";
    [centralManager addTaskWithTaskID:mk_ga_taskReadDeviceNameOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readDeviceTypeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001700";
    [centralManager addTaskWithTaskID:mk_ga_taskReadDeviceTypeOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001900";
    [centralManager addTaskWithTaskID:mk_ga_taskReadTimeZoneOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readChannelWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001a00";
    [centralManager addTaskWithTaskID:mk_ga_taskReadChannelOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee000100";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerUserNameOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *usernameData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [usernameData appendData:tempData];
        }
        NSString *username = [[NSString alloc] initWithData:usernameData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"username":(MKValidStr(username) ? username : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

+ (void)ga_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee000200";
    [centralManager addTaskWithTaskID:mk_ga_taskReadServerPasswordOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *passwordData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [passwordData appendData:tempData];
        }
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"password":(MKValidStr(password) ? password : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

@end
