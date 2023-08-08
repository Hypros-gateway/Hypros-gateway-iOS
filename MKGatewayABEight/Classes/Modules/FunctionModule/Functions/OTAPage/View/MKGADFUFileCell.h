//
//  MKGADFUFileCell.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGADFUFileCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKGADFUFileCellDelegate <NSObject>

- (void)ga_dfuFileButtonPressed:(NSInteger)index;

@end

@interface MKGADFUFileCell : MKBaseCell

@property (nonatomic, strong)MKGADFUFileCellModel *dataModel;

@property (nonatomic, weak)id <MKGADFUFileCellDelegate>delegate;

+ (MKGADFUFileCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
