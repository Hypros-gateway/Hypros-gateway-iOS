//
//  MKGAUploadDataOptionModel.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/2.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGAMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGAUploadDataOptionModel : NSObject<ga_uploadDataOptionProtocol>

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceType;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL rawData_advertising;

@property (nonatomic, assign)BOOL rawData_response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
