//
//  Target_Gateway_AB_Module.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_Gateway_AB_Module.h"

#import "MKGADeviceDataController.h"

#import "MKGAServerForDeviceController.h"

@implementation Target_Gateway_AB_Module

- (UIViewController *)Action_GatewayABEight_DeviceDataPage:(NSDictionary *)params {
    MKGADeviceDataController *vc = [[MKGADeviceDataController alloc] init];
    return vc;
}

- (UIViewController *)Action_GatewayABEight_ServerForDevicePage:(NSDictionary *)params {
    MKGAServerForDeviceController *vc = [[MKGAServerForDeviceController alloc] init];
    vc.deviceType = [NSString stringWithFormat:@"%@%@",@"0",params[@"deviceType"]];
    return vc;
}
@end
