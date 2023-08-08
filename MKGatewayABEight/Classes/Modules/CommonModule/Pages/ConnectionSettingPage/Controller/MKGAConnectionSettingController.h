//
//  MKGAConnectionSettingController.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/28.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGABaseViewController.h"

#import "MKGAConnectionSettingPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGAConnectionSettingController : MKGABaseViewController

@property (nonatomic, strong)id <MKGAConnectionSettingPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
