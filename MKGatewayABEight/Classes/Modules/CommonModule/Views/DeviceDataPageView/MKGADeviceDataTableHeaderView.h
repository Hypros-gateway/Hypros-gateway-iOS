//
//  MKGADeviceDataTableHeaderView.h
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/7/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGADeviceDataTableHeaderViewModel : NSObject

@property (nonatomic, copy)NSString *scanTime;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)NSInteger totalNum;

@end

@protocol MKGADeviceDataTableHeaderViewDelegate <NSObject>

- (void)ga_updateLoadButtonAction;

- (void)ga_scannerStatusChanged:(BOOL)isOn;

- (void)ga_scannerTimeChanged:(NSString *)time;

- (void)ga_saveButtonAction;

@end

@interface MKGADeviceDataTableHeaderView : UIView

@property (nonatomic, weak)id <MKGADeviceDataTableHeaderViewDelegate>delegate;

@property (nonatomic, strong)MKGADeviceDataTableHeaderViewModel *dataModel;

@end

NS_ASSUME_NONNULL_END
