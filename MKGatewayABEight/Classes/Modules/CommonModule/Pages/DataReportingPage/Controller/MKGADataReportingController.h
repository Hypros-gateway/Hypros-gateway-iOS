//
//  MKGADataReportingController.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGABaseViewController.h"

#import "MKGADataReportPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGADataReportingController : MKGABaseViewController

@property (nonatomic, strong)id <MKGADataReportPageProtocol>protocol;

@end

NS_ASSUME_NONNULL_END
