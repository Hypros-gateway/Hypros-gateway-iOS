//
//  CBPeripheral+MKGAAdd.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKGAAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ga_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ga_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ga_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ga_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ga_custom;

- (void)ga_updateCharacterWithService:(CBService *)service;

- (void)ga_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)ga_connectSuccess;

- (void)ga_setNil;

@end

NS_ASSUME_NONNULL_END
