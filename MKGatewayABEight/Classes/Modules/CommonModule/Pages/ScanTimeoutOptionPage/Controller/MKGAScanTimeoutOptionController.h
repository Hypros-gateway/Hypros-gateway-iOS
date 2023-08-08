//
//  MKGAScanTimeoutOptionController.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/8/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGABaseViewController.h"

#import "MKGAScanTimeoutOptionPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGAScanTimeoutOptionController : MKGABaseViewController

@property (nonatomic, strong)id <MKGAScanTimeoutOptionPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
