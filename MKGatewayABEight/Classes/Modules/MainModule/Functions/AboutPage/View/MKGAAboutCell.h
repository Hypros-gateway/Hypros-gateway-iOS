//
//  MKGAAboutCell.h
//  ScannerProApp
//
//  Created by aa on 2023/2/21.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGAAboutCellModel : NSObject

@property (nonatomic, copy)NSString *typeMessage;

@property (nonatomic, copy)NSString *value;

@property (nonatomic, copy)NSString *iconName;

@property (nonatomic, assign)BOOL canAdit;

@end

@interface MKGAAboutCell : MKBaseCell

@property (nonatomic, strong)MKGAAboutCellModel *dataModel;

+ (MKGAAboutCell *)initCellWithTableView:(UITableView *)table;

@end

NS_ASSUME_NONNULL_END
