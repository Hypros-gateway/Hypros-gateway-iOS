//
//  MKGASystemTimeCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/3.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGASystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKGASystemTimeCellDelegate <NSObject>

- (void)ga_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKGASystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKGASystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKGASystemTimeCellDelegate>delegate;

+ (MKGASystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
