//
//  MKGASlaveFileSelectController.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKGASlaveFileSelectControllerDelegate <NSObject>

- (void)ga_slaveFileSelected:(NSString *)fileName;

@end

@interface MKGASlaveFileSelectController : MKGABaseViewController

@property (nonatomic, weak)id <MKGASlaveFileSelectControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
