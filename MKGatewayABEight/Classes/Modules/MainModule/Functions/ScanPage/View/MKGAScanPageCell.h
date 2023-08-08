//
//  MKGAScanPageCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKGAScanPageModel;
@interface MKGAScanPageCell : MKBaseCell

@property (nonatomic, strong)MKGAScanPageModel *dataModel;

+ (MKGAScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
