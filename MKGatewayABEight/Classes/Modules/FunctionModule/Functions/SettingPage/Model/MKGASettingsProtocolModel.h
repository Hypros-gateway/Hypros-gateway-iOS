//
//  MKGASettingsProtocolModel.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGAMQTTSettingForDevicePageProtocol.h"
#import "MKGALEDSettingPageProtocol.h"
#import "MKGADataReportPageProtocol.h"
#import "MKGANetworkStatusPageProtocol.h"
#import "MKGAConnectionSettingPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGASettingsProtocolModel : NSObject<MKGAMQTTSettingForDevicePageProtocol,
MKGALEDSettingPageProtocol,
MKGADataReportPageProtocol,
MKGANetworkStatusPageProtocol,
MKGAConnectionSettingPageProtocol>

@end

NS_ASSUME_NONNULL_END
