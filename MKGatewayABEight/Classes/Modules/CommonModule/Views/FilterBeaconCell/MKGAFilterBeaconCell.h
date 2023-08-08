//
//  MKGAFilterBeaconCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKGAFilterBeaconCellDelegate <NSObject>

- (void)mk_ga_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_ga_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKGAFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKGAFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKGAFilterBeaconCellDelegate>delegate;

+ (MKGAFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
