//
//  CTMediator+MKGAAdd.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/11.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CTMediator+MKGAAdd.h"

#import "MKGatewayABModuleKey.h"

#import "MKGADeviceModel.h"

@implementation CTMediator (MKGAAdd)

- (UIViewController *)CTMediator_MKGatewayABEight_DeviceDataPage:(NSInteger)deviceType {
    if (deviceType == 4 || deviceType == 5) {
        //HYPROS-107-Gateway-Plug、HYPROS-Mini-Gateway
        return [self Action_MKGatewayABEightModule_ViewControllerWithTarget:kTarget_MKGatewayABEight_module
                                                                     action:kAction_MKGatewayABEight_deviceDataPage
                                                                     params:@{}];
    }
    return [[UIViewController alloc] init];
}

/// 蓝牙配置MQTT服务器信息页面
/// @param deviceType 设备类型
/*
    deviceType = 4 : HYPROS-107-Gateway-Plug
    deviceType = 5 : HYPROS-Mini-Gateway
 */
- (UIViewController *)CTMediator_MKGatewayABEight_ServerForDevicePage:(NSInteger)deviceType {
    
    if (deviceType == 4 || deviceType == 5) {
        //HYPROS-107-Gateway-Plug、HYPROS-Mini-Gateway
        return [self Action_MKGatewayABEightModule_ViewControllerWithTarget:kTarget_MKGatewayABEight_module
                                                                     action:kAction_MKGatewayABEight_serverForDevicePage
                                                                     params:@{@"deviceType":@(deviceType)}];
    }
    
    return [[UIViewController alloc] init];
}

#pragma mark - private method
- (UIViewController *)Action_MKGatewayABEightModule_ViewControllerWithTarget:(NSString *)targetName
                                                                  action:(NSString *)actionName
                                                                  params:(NSDictionary *)params{
    UIViewController *viewController = [self performTarget:targetName
                                                    action:actionName
                                                    params:params
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
