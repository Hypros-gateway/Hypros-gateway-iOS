//
//  MKGAInterface.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************
/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast name of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************Custom protocol read************************************************

/// Read SSID of WIFI.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readWIFISSIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read password of WIFI.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readWIFIPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the device tcp communication encryption method.
/*
 @{
 @"mode":@"0"
 }
 @"0":TCP
 @"1":SSL.Do not verify the server certificate.
 @"2":SSL.Verify the server's certificate.
 @"3":SSL.Two-way authentication
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the domain name of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the port number of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read clean session status of the  MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Keep Alive of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Qos of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Client ID of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Device ID.Alibaba Cloud server needs this parameter to distinguish different messages.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readDeviceIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the subscription topic of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the publishing theme of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read NTP server domain name.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current time zone to the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readDeviceMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device type.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readDeviceTypeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read 2.4G&5G channel by selecting your domain, channels will be matched according to the domain.
/*
 Channel：0~ 21，default:9。
 0: Argentina,Mexico
 1: Australia,New Zealand
 2: Bahrain、Egypt、Israel、India
 3: Bolivia、Chile、China、El Salvador
 4: Canada
 5: Europe
 6: Indonesia
 7: Japan
 8: Jordan
 9: Korea、US
 10: Latin America-1
 11: Latin America-2
 12: Latin America-3
 13: Lebanon
 14: Malaysia
 15: Qatar
 16: Russia
 17: Singapore
 18: Taiwan
 19: Tunisia
 20: Venezuela
 21: Worldwide (Global)
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readChannelWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read User Name of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Password of the MQTT server.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ga_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
