//
//  MKGAOTADataModel.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Master Firmware
@interface MKGAOTAMasterFirmwareModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKGAOTASlaveFirmware : NSObject

/// 从设备读取回来的从机mac地址
@property (nonatomic, copy)NSString *slaveMacAddress;

@property (nonatomic, copy)NSString *fileName;

@end


@interface MKGAOTACACertificateModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKGAOTASelfSignedModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *caFilePath;

@property (nonatomic, copy)NSString *clientKeyPath;

@property (nonatomic, copy)NSString *clientCertPath;

@end


@interface MKGAOTADataModel : NSObject

/// 当前用户选择的OTA类型.   0:Master Firmware      1:Slave Firmware      2:CA certificate     3:Self signed server certificates
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong, readonly)MKGAOTAMasterFirmwareModel *masterModel;

@property (nonatomic, strong, readonly)MKGAOTASlaveFirmware *slaveModel;

@property (nonatomic, strong, readonly)MKGAOTACACertificateModel *caFileModel;

@property (nonatomic, strong, readonly)MKGAOTASelfSignedModel *signedModel;

- (NSString *)checkParams;

@end

NS_ASSUME_NONNULL_END
