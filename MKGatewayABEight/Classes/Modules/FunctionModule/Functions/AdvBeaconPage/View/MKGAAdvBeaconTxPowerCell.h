//
//  MKGAAdvBeaconTxPowerCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2023/8/7.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_ga_deviceTxPower) {
    mk_ga_deviceTxPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_ga_deviceTxPowerNeg20dBm,   //-20dBm
    mk_ga_deviceTxPowerNeg8dBm,    //-8dBm
    mk_ga_deviceTxPowerNeg4dBm,    //-4dBm
    mk_ga_deviceTxPower0dBm,       //0dBm
    mk_ga_deviceTxPower4dBm,       //4dBm
    mk_ga_deviceTxPower8dBm,       //8dBm
};

@interface MKGAAdvBeaconTxPowerCellModel : NSObject

@property (nonatomic, assign)float measurePower;

@property (nonatomic, assign)mk_ga_deviceTxPower txPower;

@end

@protocol MKGAAdvBeaconTxPowerCellDelegate <NSObject>

- (void)mk_advBeaconTxPowerCell_measurePowerValueChanged:(NSString *)measurePower;

- (void)mk_advBeaconTxPowerCell_txPowerValueChanged:(mk_ga_deviceTxPower)txPower;

@end

@interface MKGAAdvBeaconTxPowerCell : MKBaseCell

@property (nonatomic, strong)MKGAAdvBeaconTxPowerCellModel *dataModel;

@property (nonatomic, weak)id <MKGAAdvBeaconTxPowerCellDelegate>delegate;

+ (MKGAAdvBeaconTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
