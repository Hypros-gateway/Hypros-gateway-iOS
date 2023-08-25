//
//  MKGACentralManager.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKGAOperationID.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_ga_centralConnectStatus) {
    mk_ga_centralConnectStatusUnknow,                                           //未知状态
    mk_ga_centralConnectStatusConnecting,                                       //正在连接
    mk_ga_centralConnectStatusConnected,                                        //连接成功
    mk_ga_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_ga_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_ga_centralManagerStatus) {
    mk_ga_centralManagerStatusUnable,                           //不可用
    mk_ga_centralManagerStatusEnable,                           //可用状态
};

//Notification of device connection status changes.
extern NSString *const mk_ga_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_ga_centralManagerStateChangedNotification;

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. The device has no data communication for ten consecutive minutes, it returns 0x02.
 */
extern NSString *const mk_ga_deviceDisconnectTypeNotification;

@class CBCentralManager,CBPeripheral;

@protocol mk_ga_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_ga_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_ga_startScan;

/// Stops scanning equipment.
- (void)mk_ga_stopScan;

@end

@interface MKGACentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_ga_centralManagerScanDelegate>delegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_ga_centralConnectStatus connectStatus;

+ (MKGACentralManager *)shared;

/// Destroy the MKLoRaTHCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKLoRaTHCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_ga_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Connect device function
/// @param trackerModel Model
/// @param password Device connection password,8 ~ 16 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_ga_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_ga_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
