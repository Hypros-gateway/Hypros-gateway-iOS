//
//  MKGAWifiAlertView.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2023/8/7.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAWifiAlertView : UIView

- (void)showWithConfirmBlock:(void (^)(NSString *ssid, NSString *password))confirmBlock;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
