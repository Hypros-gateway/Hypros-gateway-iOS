//
//  MKGAMQTTSettingForDevicePageProtocol.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/12.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGAMQTTSettingForDevicePageProtocol <NSObject>

/// Read the MQTT server information of the device.
/// @param deviceID deviceID,1-32 Characters
/// @param macAddress Mac address of the device
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)ga_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
