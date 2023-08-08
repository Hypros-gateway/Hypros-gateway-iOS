//
//  MKGADeviceDataPageCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGADeviceDataPageCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

- (CGFloat)fetchCellHeight;

@end

@interface MKGADeviceDataPageCell : MKBaseCell

+ (MKGADeviceDataPageCell *)initCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)MKGADeviceDataPageCellModel *dataModel;

@end

NS_ASSUME_NONNULL_END
