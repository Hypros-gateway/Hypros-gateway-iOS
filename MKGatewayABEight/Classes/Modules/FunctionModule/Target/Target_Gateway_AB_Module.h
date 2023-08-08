//
//  Target_Gateway_AB_Module.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_Gateway_AB_Module : NSObject

/// 设备主页面
/// @param params @{}
- (UIViewController *)Action_GatewayABEight_DeviceDataPage:(NSDictionary *)params;

/// 107P、BG-2设备MQTT参数页面
/// @param params @{
///    @"deviceType":@"04"
///}
- (UIViewController *)Action_GatewayABEight_ServerForDevicePage:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
