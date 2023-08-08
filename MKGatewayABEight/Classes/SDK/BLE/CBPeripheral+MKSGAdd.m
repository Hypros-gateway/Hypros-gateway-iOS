//
//  CBPeripheral+MKGAAdd.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKGAAdd.h"

#import <objc/runtime.h>

static const char *ga_hardwareKey = "ga_hardwareKey";
static const char *ga_firmwareKey = "ga_firmwareKey";

static const char *ga_passwordKey = "ga_passwordKey";
static const char *ga_disconnectTypeKey = "ga_disconnectTypeKey";
static const char *ga_customKey = "ga_customKey";

static const char *ga_passwordNotifySuccessKey = "ga_passwordNotifySuccessKey";
static const char *ga_disconnectTypeNotifySuccessKey = "ga_disconnectTypeNotifySuccessKey";
static const char *ga_customNotifySuccessKey = "ga_customNotifySuccessKey";

@implementation CBPeripheral (MKGAAdd)

- (void)ga_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &ga_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &ga_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &ga_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &ga_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &ga_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)ga_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &ga_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &ga_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &ga_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)ga_connectSuccess {
    if (![objc_getAssociatedObject(self, &ga_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ga_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ga_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.ga_hardware || !self.ga_firmware) {
        return NO;
    }
    if (!self.ga_password || !self.ga_disconnectType || !self.ga_custom) {
        return NO;
    }
    return YES;
}

- (void)ga_setNil {
    objc_setAssociatedObject(self, &ga_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ga_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ga_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ga_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ga_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ga_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ga_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ga_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)ga_hardware {
    return objc_getAssociatedObject(self, &ga_hardwareKey);
}

- (CBCharacteristic *)ga_firmware {
    return objc_getAssociatedObject(self, &ga_firmwareKey);
}

- (CBCharacteristic *)ga_password {
    return objc_getAssociatedObject(self, &ga_passwordKey);
}

- (CBCharacteristic *)ga_disconnectType {
    return objc_getAssociatedObject(self, &ga_disconnectTypeKey);
}

- (CBCharacteristic *)ga_custom {
    return objc_getAssociatedObject(self, &ga_customKey);
}

@end
