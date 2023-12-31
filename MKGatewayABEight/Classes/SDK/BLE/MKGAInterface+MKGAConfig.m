//
//  MKGAInterface+MKGAConfig.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/7.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGAInterface+MKGAConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKGACentralManager.h"
#import "MKGAOperationID.h"
#import "CBPeripheral+MKGAAdd.h"
#import "MKGAOperation.h"

static const NSInteger packDataMaxLen = 150;

#define centralManager [MKGACentralManager shared]
#define peripheral ([MKGACentralManager shared].peripheral)

@implementation MKGAInterface (MKGAConfig)

#pragma mark ****************************************自定义参数配置************************************************

+ (void)ga_exitConfigModeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed01010101";
    [centralManager addTaskWithTaskID:mk_ga_taskExitConfigModeOperation
                       characteristic:peripheral.ga_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)ga_configWIFISSID:(NSString *)ssid
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(ssid) || ssid.length > 32) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:ssid];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:ssid.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0102",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigWIFISSIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configWIFIPassword:(nullable NSString *)password
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (password.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = @"";
    if (MKValidStr(password)) {
        NSString *tempString = [self fetchAsciiCode:password];
        NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:password.length byteLen:1];
        commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0103",lenString,tempString];
    }else {
        //空的
        commandString = @"ed010300";
    }
    
    [self configDataWithTaskID:mk_ga_taskConfigWIFIPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configConnectMode:(mk_ga_connectMode)mode
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *modeString = [self fetchConnectModeString:mode];
    NSString *commandString = [@"ed010401" stringByAppendingString:modeString];
    [self configDataWithTaskID:mk_ga_taskConfigConnectModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerHost:(NSString *)host
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(host) || host.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:host];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0105",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigServerHostOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerPort:(NSInteger)port
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (port < 0 || port > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:port byteLen:2];
    NSString *commandString = [@"ed010602" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ga_taskConfigServerPortOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerCleanSession:(BOOL)clean
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (clean ? @"ed01070101" : @"ed01070100");
    [self configDataWithTaskID:mk_ga_taskConfigServerCleanSessionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerKeepAlive:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 120) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed010801" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ga_taskConfigServerKeepAliveOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerQos:(mk_ga_mqttServerQosMode)mode
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *qosString = [self fetchMqttServerQosMode:mode];
    NSString *commandString = [@"ed010901" stringByAppendingString:qosString];
    [self configDataWithTaskID:mk_ga_taskConfigServerQosOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configClientID:(NSString *)clientID
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(clientID) || clientID.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:clientID];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:clientID.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010a",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigClientIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configDeviceID:(NSString *)deviceID
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceID) || deviceID.length > 32) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:deviceID];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:deviceID.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010b",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigDeviceIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configSubscibeTopic:(NSString *)subscibeTopic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(subscibeTopic) || subscibeTopic.length > 128) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:subscibeTopic];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:subscibeTopic.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010c",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigSubscibeTopicOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configPublishTopic:(NSString *)publishTopic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(publishTopic) || publishTopic.length > 128) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [self fetchAsciiCode:publishTopic];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:publishTopic.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010d",lenString,tempString];
    [self configDataWithTaskID:mk_ga_taskConfigPublishTopicOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configNTPServerHost:(NSString *)host
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (host.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = @"";
    if (MKValidStr(host)) {
        NSString *tempString = [self fetchAsciiCode:host];
        NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:host.length byteLen:1];
        commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010e",lenString,tempString];
    }else {
        //空的
        commandString = @"ed010e00";
    }
    
    [self configDataWithTaskID:mk_ga_taskConfigNTPServerHostOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *zoneValue = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:timeZone];
    NSString *commandString = [@"ed011901" stringByAppendingString:zoneValue];
    [self configDataWithTaskID:mk_ga_taskConfigTimeZoneOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configChannel:(NSInteger)channel
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (channel < 0 || channel > 21) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *channelString = [MKBLEBaseSDKAdopter fetchHexValue:channel byteLen:1];
    NSString *commandString = [@"ed011a01" stringByAppendingString:channelString];
    [self configDataWithTaskID:mk_ga_taskConfigChannelOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ga_configServerUserName:(NSString *)userName
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (userName.length > 256) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!MKValidStr(userName)) {
        //空的
        NSString *commandString = @"ee0101010000";
        [self configDataWithTaskID:mk_ga_taskConfigServerUserNameOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSInteger totalNum = userName.length / packDataMaxLen;
    NSInteger packRemain = userName.length % packDataMaxLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = @"ee0101";
    dispatch_queue_t queue = dispatch_queue_create("configUserNameQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *first = ((i == 0) ? @"01" : @"00");
            NSString *reamin = [MKBLEBaseSDKAdopter fetchHexValue:(totalNum - 1 - i) byteLen:1];
            NSInteger len = packDataMaxLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *asciiChar = [self fetchAsciiCode:[userName substringWithRange:NSMakeRange(i * packDataMaxLen, len)]];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,first,reamin,lenString,asciiChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ga_taskConfigServerUserNameOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ga_configServerPassword:(NSString *)password
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (password.length > 256) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!MKValidStr(password)) {
        //空的
        NSString *commandString = @"ee0102010000";
        [self configDataWithTaskID:mk_ga_taskConfigServerPasswordOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSInteger totalNum = password.length / packDataMaxLen;
    NSInteger packRemain = password.length % packDataMaxLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = @"ee0102";
    dispatch_queue_t queue = dispatch_queue_create("configUserPasswordQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *first = ((i == 0) ? @"01" : @"00");
            NSString *reamin = [MKBLEBaseSDKAdopter fetchHexValue:(totalNum - 1 - i) byteLen:1];
            NSInteger len = packDataMaxLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *asciiChar = [self fetchAsciiCode:[password substringWithRange:NSMakeRange(i * packDataMaxLen, len)]];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,first,reamin,lenString,asciiChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ga_taskConfigServerPasswordOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ga_configCAFile:(NSData *)caFile
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(caFile)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *caStrings = [MKBLEBaseSDKAdopter hexStringFromData:caFile];
    NSInteger totalNum = (caStrings.length / 2) / packDataMaxLen;
    NSInteger packRemain = (caStrings.length / 2) % packDataMaxLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = @"ee0103";
    dispatch_queue_t queue = dispatch_queue_create("configCAFileQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *first = ((i == 0) ? @"01" : @"00");
            NSString *reamin = [MKBLEBaseSDKAdopter fetchHexValue:(totalNum - 1 - i) byteLen:1];
            NSInteger len = packDataMaxLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [caStrings substringWithRange:NSMakeRange(i * 2 * packDataMaxLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,first,reamin,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ga_taskConfigCAFileOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ga_configClientCert:(NSData *)cert
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(cert)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *certStrings = [MKBLEBaseSDKAdopter hexStringFromData:cert];
    NSInteger totalNum = (certStrings.length / 2) / packDataMaxLen;
    NSInteger packRemain = (certStrings.length / 2) % packDataMaxLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = @"ee0104";
    dispatch_queue_t queue = dispatch_queue_create("configCertQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *first = ((i == 0) ? @"01" : @"00");
            NSString *reamin = [MKBLEBaseSDKAdopter fetchHexValue:(totalNum - 1 - i) byteLen:1];
            NSInteger len = packDataMaxLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [certStrings substringWithRange:NSMakeRange(i * 2 * packDataMaxLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,first,reamin,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ga_taskConfigClientCertOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ga_configClientPrivateKey:(NSData *)privateKey
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(privateKey)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *privateKeyStrings = [MKBLEBaseSDKAdopter hexStringFromData:privateKey];
    NSInteger totalNum = (privateKeyStrings.length / 2) / packDataMaxLen;
    NSInteger packRemain = (privateKeyStrings.length / 2) % packDataMaxLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = @"ee0105";
    dispatch_queue_t queue = dispatch_queue_create("configPrivateKeyQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *first = ((i == 0) ? @"01" : @"00");
            NSString *reamin = [MKBLEBaseSDKAdopter fetchHexValue:(totalNum - 1 - i) byteLen:1];
            NSInteger len = packDataMaxLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [privateKeyStrings substringWithRange:NSMakeRange(i * 2 * packDataMaxLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,first,reamin,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ga_taskConfigClientPrivateKeyOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - Private method

+ (void)configDataWithTaskID:(mk_ga_taskOperationID)taskID
                        data:(NSString *)data
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:peripheral.ga_custom commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

+ (BOOL)sendDataToPeripheral:(NSString *)commandString
                      taskID:(mk_ga_taskOperationID)taskID
                   semaphore:(dispatch_semaphore_t)semaphore {
    __block BOOL success = NO;
    [self configDataWithTaskID:taskID data:commandString sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(semaphore);
    } failedBlock:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

+ (NSString *)fetchConnectModeString:(mk_ga_connectMode)mode {
    switch (mode) {
        case mk_ga_connectMode_TCP:
            return @"00";
        case mk_ga_connectMode_CASignedServerCertificate:
            return @"01";
        case mk_ga_connectMode_CACertificate:
            return @"02";
        case mk_ga_connectMode_SelfSignedCertificates:
            return @"03";
    }
}

+ (NSString *)fetchMqttServerQosMode:(mk_ga_mqttServerQosMode)mode {
    switch (mode) {
        case mk_ga_mqttQosLevelAtMostOnce:
            return @"00";
        case mk_ga_mqttQosLevelAtLeastOnce:
            return @"01";
        case mk_ga_mqttQosLevelExactlyOnce:
            return @"02";
    }
}

+ (NSString *)fetchAsciiCode:(NSString *)value {
    if (!MKValidStr(value)) {
        return @"";
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < value.length; i ++) {
        int asciiCode = [value characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    return tempString;
}

@end
