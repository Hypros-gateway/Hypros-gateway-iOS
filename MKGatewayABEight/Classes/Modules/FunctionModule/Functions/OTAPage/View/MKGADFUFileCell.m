//
//  MKGADFUFileCell.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKGADFUFileCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKTextField.h"

@implementation MKGADFUFileCellModel
@end

@interface MKGADFUFileCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *rightButton;

@property (nonatomic, strong)MKTextField *fileNameTextField;

@end

@implementation MKGADFUFileCell

+ (MKGADFUFileCell *)initCellWithTableView:(UITableView *)tableView {
    MKGADFUFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGADFUFileCellIdenty"];
    if (!cell) {
        cell = [[MKGADFUFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGADFUFileCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.fileNameTextField];
        [self.contentView addSubview:self.rightButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.fileNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.rightButton.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(40.f);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.fileNameTextField.mas_centerY);
        make.height.mas_equalTo(40.f);
    }];
}

#pragma mark - event method
- (void)rightButtonPressed {
    if ([self.delegate respondsToSelector:@selector(ga_dfuFileButtonPressed:)]) {
        [self.delegate ga_dfuFileButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGADFUFileCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGADFUFileCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.fileNameTextField.text = SafeStr(_dataModel.fileName);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (MKTextField *)fileNameTextField {
    if (!_fileNameTextField) {
        _fileNameTextField = [[MKTextField alloc] initWithTextFieldType:mk_normal];
        _fileNameTextField.textColor = DEFAULT_TEXT_COLOR;
        _fileNameTextField.textAlignment = NSTextAlignmentLeft;
        _fileNameTextField.font = MKFont(14.f);
        _fileNameTextField.enabled = NO;
        
        _fileNameTextField.layer.masksToBounds = YES;
        _fileNameTextField.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        _fileNameTextField.layer.cornerRadius = 5.f;
        _fileNameTextField.layer.borderWidth = CUTTING_LINE_HEIGHT;
    }
    return _fileNameTextField;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:LOADICON(@"MKGatewayABEight", @"MKGADFUFileCell", @"ga_slaveFirmwareSelectIcon.png") forState:UIControlStateNormal];
        [_rightButton addTarget:self
                         action:@selector(rightButtonPressed)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
