//
//  MKGAMQTTSSLForAppView.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/13.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAMQTTSSLForAppViewModel : NSObject

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

/// P12证书
@property (nonatomic, copy)NSString *clientFileName;

@end

@protocol MKGAMQTTSSLForAppViewDelegate <NSObject>

- (void)ga_mqtt_sslParams_app_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)ga_mqtt_sslParams_app_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)ga_mqtt_sslParams_app_caFilePressed;

/// 用户点击选择了P12证书按钮
- (void)ga_mqtt_sslParams_app_clientFilePressed;

@end

@interface MKGAMQTTSSLForAppView : UIView

@property (nonatomic, strong)MKGAMQTTSSLForAppViewModel *dataModel;

@property (nonatomic, weak)id <MKGAMQTTSSLForAppViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
