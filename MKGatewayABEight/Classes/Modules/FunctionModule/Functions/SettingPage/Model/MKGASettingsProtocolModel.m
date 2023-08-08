//
//  MKGASettingsProtocolModel.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGASettingsProtocolModel.h"

#import "MKGAMQTTInterface.h"

#import "MKGAMQTTConfigDefines.h"

@interface MKGAIndicatorLightStatusModel : NSObject<ga_indicatorLightStatusProtocol>

@property (nonatomic, assign)BOOL ble_advertising;

@property (nonatomic, assign)BOOL ble_connected;

@property (nonatomic, assign)BOOL wifi_connecting;

@property (nonatomic, assign)BOOL wifi_connected;

@end

@implementation MKGAIndicatorLightStatusModel
@end

@implementation MKGASettingsProtocolModel

#pragma mark - MKGAMQTTSettingForDevicePageProtocol
- (void)ga_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_readDeviceMQTTServerInfoWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

#pragma mark - MKGALEDSettingPageProtocol
- (void)ga_readIndicatorLightStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_readIndicatorLightStatusWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

- (void)ga_configIndicatorLightStatus:(BOOL)ble_advertising
                        ble_connected:(BOOL)ble_connected
                    server_connecting:(BOOL)server_connecting
                     server_connected:(BOOL)server_connected
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    MKGAIndicatorLightStatusModel *dataModel = [[MKGAIndicatorLightStatusModel alloc] init];
    dataModel.ble_advertising = ble_advertising;
    dataModel.ble_connected = ble_connected;
    dataModel.wifi_connecting = server_connecting;
    dataModel.wifi_connected = server_connected;
    
    [MKGAMQTTInterface ga_configIndicatorLightStatus:dataModel
                                              deviceID:deviceID
                                            macAddress:macAddress
                                                 topic:topic
                                              sucBlock:sucBlock
                                           failedBlock:failedBlock];
}

#pragma mark - MKGADataReportPageProtocol
- (void)ga_readDataReportingTimeoutWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_readDataReportingTimeoutWithDeviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

- (void)ga_configDataReportingTimeout:(NSInteger)interval
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_configDataReportingTimeout:interval
                                              deviceID:deviceID
                                            macAddress:macAddress
                                                 topic:topic
                                              sucBlock:sucBlock
                                           failedBlock:failedBlock];
}

#pragma mark - MKGANetworkStatusPageProtocol
- (void)ga_readNetworkStatusReportingIntervalWithDeviceID:(NSString *)deviceID
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_readNetworkStatusReportingIntervalWithDeviceID:deviceID
                                                                macAddress:macAddress
                                                                     topic:topic
                                                                  sucBlock:sucBlock
                                                               failedBlock:failedBlock];
}

- (void)ga_configNetworkStatusReportingInterval:(NSInteger)interval
                                       deviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_configNetworkStatusReportingInterval:interval
                                                        deviceID:deviceID
                                                      macAddress:macAddress
                                                           topic:topic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

#pragma mark - MKGAConnectionSettingPageProtocol
- (void)ga_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_readConnectionTimeoutWithDeviceID:deviceID
                                                   macAddress:macAddress
                                                        topic:topic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)ga_configConnectionTimeout:(NSInteger)interval
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGAMQTTInterface ga_configConnectionTimeout:interval
                                           deviceID:deviceID
                                         macAddress:macAddress
                                              topic:topic
                                           sucBlock:sucBlock
                                        failedBlock:failedBlock];
}

@end
