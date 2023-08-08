//
//  MKGAFilterCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/11/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKGAFilterCellDelegate <NSObject>

- (void)ga_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKGAFilterCell : MKBaseCell

@property (nonatomic, strong)MKGAFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKGAFilterCellDelegate>delegate;

+ (MKGAFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
