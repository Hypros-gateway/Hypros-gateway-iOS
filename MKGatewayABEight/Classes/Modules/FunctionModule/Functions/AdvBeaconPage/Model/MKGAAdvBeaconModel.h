//
//  MKGAAdvBeaconModel.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2023/8/7.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAAdvBeaconModel : NSObject

@property (nonatomic, assign)BOOL advertise;

@property (nonatomic, copy)NSString *major;

@property (nonatomic, copy)NSString *minor;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, copy)NSString *advInterval;

/*
 0：-40dbm
 1：-20dbm
 2：-8dbm
 3：-4dbm
 4：0dbm
 5：4dbm
 6：8dbm
 */
@property (nonatomic, assign)NSInteger txPower;

@property (nonatomic, assign)NSInteger rssi;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
