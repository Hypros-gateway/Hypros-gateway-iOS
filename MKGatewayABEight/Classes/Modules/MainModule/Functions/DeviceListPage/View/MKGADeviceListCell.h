//
//  MKGADeviceListCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/9.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGADeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)ga_cellDeleteButtonPressed:(NSInteger)index;

@end

@class MKGADeviceModel;
@interface MKGADeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKGADeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKGADeviceModel *dataModel;

+ (MKGADeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
