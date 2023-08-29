//
//  MKGATaskAdopter.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGATaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKGAOperationID.h"
#import "CBPeripheral+MKGAAdd.h"

NSString *const mk_ga_totalNumKey = @"mk_ga_totalNumKey";
NSString *const mk_ga_totalIndexKey = @"mk_ga_totalIndexKey";
NSString *const mk_ga_contentKey = @"mk_ga_contentKey";

@implementation MKGATaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_ga_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_ga_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_ga_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - Private method

+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    
    if ([[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ee"]) {
        //多帧数据
        return [self parseMultiData:readData];
    }
    
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    if ([[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ed"]) {
        //单帧数据
        if ([flag isEqualToString:@"00"]) {
            //读取
            return [self parseCustomReadData:content cmd:cmd data:readData];
        }
        if ([flag isEqualToString:@"01"]) {
            return [self parseCustomConfigData:content cmd:cmd];
        }
    }
    
    return @{};
}

+ (NSDictionary *)parseMultiData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringFromIndex:8];
    if ([flag isEqualToString:@"00"]) {
        return [self parseMultiPackageReadData:readData cmd:[readString substringWithRange:NSMakeRange(4, 2)]];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseMultiPackageData:content cmd:[readString substringWithRange:NSMakeRange(4, 2)]];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_ga_taskOperationID operationID = mk_ga_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    if ([cmd isEqualToString:@"02"]) {
        //读取WIFI SSID
        NSString *ssid = @"";
        if (data.length > 4) {
            NSData *ssidData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            ssid = [[NSString alloc] initWithData:ssidData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"ssid":(MKValidStr(ssid) ? ssid : @""),
        };
        operationID = mk_ga_taskReadWIFISSIDOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //读取WIFI password
        NSString *password = @"";
        if (data.length > 4) {
            NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_ga_taskReadWIFIPasswordOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //读取MTQQ服务器通信加密方式
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"mode":mode};
        operationID = mk_ga_taskReadConnectModeOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //读取MQTT服务器域名
        NSString *host = @"";
        if (data.length > 4) {
            NSData *hostData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            host = [[NSString alloc] initWithData:hostData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"host":(MKValidStr(host) ? host : @""),
        };
        operationID = mk_ga_taskReadServerHostOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //读取MQTT服务器端口
        NSString *port = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"port":port};
        operationID = mk_ga_taskReadServerPortOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //读取MQTT Clean Session
        BOOL clean = ([content isEqualToString:@"01"]);
        resultDic = @{@"clean":@(clean)};
        operationID = mk_ga_taskReadServerCleanSessionOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //读取MQTT KeepAlive
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"interval":interval};
        operationID = mk_ga_taskReadServerKeepAliveOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //读取MQTT Qos
        NSString *qos = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"qos":qos};
        operationID = mk_ga_taskReadServerQosOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //读取ClientID
        NSString *clientID = @"";
        if (data.length > 4) {
            NSData *clientIDData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            clientID = [[NSString alloc] initWithData:clientIDData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"clientID":(MKValidStr(clientID) ? clientID : @""),
        };
        operationID = mk_ga_taskReadClientIDOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //读取DeviceID
        NSString *deviceID = @"";
        if (data.length > 4) {
            NSData *deviceIDData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            deviceID = [[NSString alloc] initWithData:deviceIDData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"deviceID":(MKValidStr(deviceID) ? deviceID : @""),
        };
        operationID = mk_ga_taskReadDeviceIDOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //读取Subscribe topic
        NSString *topic = @"";
        if (data.length > 4) {
            NSData *topicData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            topic = [[NSString alloc] initWithData:topicData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"topic":(MKValidStr(topic) ? topic : @""),
        };
        operationID = mk_ga_taskReadSubscibeTopicOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取Publish topic
        NSString *topic = @"";
        if (data.length > 4) {
            NSData *topicData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            topic = [[NSString alloc] initWithData:topicData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"topic":(MKValidStr(topic) ? topic : @""),
        };
        operationID = mk_ga_taskReadPublishTopicOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取NTP服务器域名
        NSString *host = @"";
        if (data.length > 4) {
            NSData *hostData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            host = [[NSString alloc] initWithData:hostData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"host":(MKValidStr(host) ? host : @""),
        };
        operationID = mk_ga_taskReadNTPServerHostOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取MAC
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_ga_taskReadDeviceMacAddressOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //读取deviceName
        NSString *deviceName = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, data.length - 4)] encoding:NSUTF8StringEncoding];
        resultDic = @{@"deviceName":deviceName};
        operationID = mk_ga_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //读取device type
        NSString *deviceType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"deviceType":deviceType};
        operationID = mk_ga_taskReadDeviceTypeOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_ga_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //读取区域参数
        NSString *domain = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"domain":domain};
        operationID = mk_ga_taskReadChannelOperation;
    }
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_ga_taskOperationID operationID = mk_ga_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    if ([cmd isEqualToString:@"01"]) {
        //退出配置模式
        operationID = mk_ga_taskExitConfigModeOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //配置WIFI SSID
        operationID = mk_ga_taskConfigWIFISSIDOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //配置WIFI password
        operationID = mk_ga_taskConfigWIFIPasswordOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //配置MTQQ服务器通信加密方式
        operationID = mk_ga_taskConfigConnectModeOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //配置MQTT服务器域名
        operationID = mk_ga_taskConfigServerHostOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //配置MQTT服务器端口
        operationID = mk_ga_taskConfigServerPortOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //配置MQTT Clean Session
        operationID = mk_ga_taskConfigServerCleanSessionOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //配置MQTT KeepAlive
        operationID = mk_ga_taskConfigServerKeepAliveOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //配置MQTT Qos
        operationID = mk_ga_taskConfigServerQosOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //配置ClientID
        operationID = mk_ga_taskConfigClientIDOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //配置WIFI password
        operationID = mk_ga_taskConfigDeviceIDOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //配置Subscribe topic
        operationID = mk_ga_taskConfigSubscibeTopicOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //配置Publish topic
        operationID = mk_ga_taskConfigPublishTopicOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置NTP服务器域名
        operationID = mk_ga_taskConfigNTPServerHostOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //配置时区
        operationID = mk_ga_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //配置MK107D Pro的区域参数
        operationID = mk_ga_taskConfigChannelOperation;
    }
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}

+ (NSDictionary *)parseMultiPackageReadData:(NSData *)readData cmd:(NSString *)cmd {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(6, 2)];
    NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
    NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(10, 2)];
    if ([index integerValue] >= [totalNum integerValue]) {
        return @{};
    }
    mk_ga_taskOperationID operationID = mk_ga_defaultTaskOperationID;
    
    NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
    NSDictionary *resultDic= @{
        mk_ga_totalNumKey:totalNum,
        mk_ga_totalIndexKey:index,
        mk_ga_contentKey:(subData ? subData : [NSData data]),
    };
    if ([cmd isEqualToString:@"01"]) {
        //读取服务器登录用户名
        operationID = mk_ga_taskReadServerUserNameOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //读取服务器登录密码
        operationID = mk_ga_taskReadServerPasswordOperation;
    }
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseMultiPackageData:(NSString *)content cmd:(NSString *)cmd {
    mk_ga_taskOperationID operationID = mk_ga_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    if ([cmd isEqualToString:@"01"]) {
        //配置服务器登录用户名
        operationID = mk_ga_taskConfigServerUserNameOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //配置服务器登录密码
        operationID = mk_ga_taskConfigServerPasswordOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //配置CA file
        operationID = mk_ga_taskConfigCAFileOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //配置Client certificate file
        operationID = mk_ga_taskConfigClientCertOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //配置Client key file
        operationID = mk_ga_taskConfigClientPrivateKeyOperation;
    }
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_ga_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
