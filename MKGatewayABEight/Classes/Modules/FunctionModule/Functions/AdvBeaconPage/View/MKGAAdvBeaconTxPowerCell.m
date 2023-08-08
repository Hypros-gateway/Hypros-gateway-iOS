//
//  MKGAAdvBeaconTxPowerCell.m
//  MKGatewayABEight_Example
//
//  Created by aa on 2023/8/7.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKGAAdvBeaconTxPowerCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

#import "MKSlider.h"

@implementation MKGAAdvBeaconTxPowerCellModel
@end

@interface MKGAAdvBeaconTxPowerCell ()

@property (nonatomic, strong)UILabel *rssiMsgLabel;

@property (nonatomic, strong)MKSlider *rssiSlider;

@property (nonatomic, strong)UILabel *rssiValueLabel;

@property (nonatomic, strong)UILabel *txPowerMsgLabel;

@property (nonatomic, strong)MKSlider *txPowerSlider;

@property (nonatomic, strong)UILabel *txPowerValueLabel;

@property (nonatomic, strong)UIView *lineView1;

@property (nonatomic, strong)UIView *lineView2;

@end

@implementation MKGAAdvBeaconTxPowerCell

+ (MKGAAdvBeaconTxPowerCell *)initCellWithTableView:(UITableView *)tableView {
    MKGAAdvBeaconTxPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGAAdvBeaconTxPowerCellIdenty"];
    if (!cell) {
        cell = [[MKGAAdvBeaconTxPowerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGAAdvBeaconTxPowerCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rssiMsgLabel];
        [self.contentView addSubview:self.rssiSlider];
        [self.contentView addSubview:self.rssiValueLabel];
        [self.contentView addSubview:self.txPowerMsgLabel];
        [self.contentView addSubview:self.txPowerSlider];
        [self.contentView addSubview:self.txPowerValueLabel];
        [self.contentView addSubview:self.lineView1];
        [self.contentView addSubview:self.lineView2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.rssiMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.top.mas_equalTo(10.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.rssiSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.rssiValueLabel.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.rssiMsgLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(10.f);
    }];
    [self.rssiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.rssiSlider.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.rssiSlider.mas_bottom).mas_offset(15.f);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
    [self.txPowerMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.txPowerSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.txPowerValueLabel.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.txPowerMsgLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(10.f);
    }];
    [self.txPowerValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.txPowerSlider.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
}

#pragma mark - event method
- (void)rssiSliderValueChanged {
    NSString *value = [NSString stringWithFormat:@"%.f",self.rssiSlider.value];
    if ([value isEqualToString:@"-0"]) {
        value = @"0";
    }
    self.rssiValueLabel.text = [value stringByAppendingString:@"dBm"];
    if ([self.delegate respondsToSelector:@selector(mk_advBeaconTxPowerCell_measurePowerValueChanged:)]) {
        [self.delegate mk_advBeaconTxPowerCell_measurePowerValueChanged:value];
    }
}

- (void)txPowerSliderValueChanged {
    NSString *value = [NSString stringWithFormat:@"%.f",self.txPowerSlider.value];
    if ([value isEqualToString:@"-0"]) {
        value = @"0";
    }
    self.txPowerValueLabel.text = [self txPowerValueText:[value integerValue]];
    if ([self.delegate respondsToSelector:@selector(mk_advBeaconTxPowerCell_txPowerValueChanged:)]) {
        [self.delegate mk_advBeaconTxPowerCell_txPowerValueChanged:(NSInteger)[value integerValue]];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGAAdvBeaconTxPowerCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGAAdvBeaconTxPowerCellModel.class]) {
        return;
    }
    self.rssiSlider.value = _dataModel.measurePower;
    self.rssiValueLabel.text = [NSString stringWithFormat:@"%.fdBm",_dataModel.measurePower];
    self.txPowerSlider.value = _dataModel.txPower;
    self.txPowerValueLabel.text = [self txPowerValueText:_dataModel.txPower];
}

#pragma mark - private method
- (NSString *)txPowerValueText:(NSInteger)sliderValue{
    if (sliderValue == 0) {
        return @"-40dBm";
    }
    if (sliderValue == 1){
        return @"-20dBm";
    }
    if (sliderValue == 2){
        return @"-8dBm";
    }
    if (sliderValue == 3){
        return @"-4dBm";
    }
    if (sliderValue == 4){
        return @"0dBm";
    }
    if (sliderValue == 5){
        return @"4dBm";
    }
    if (sliderValue == 6){
        return @"8dBm";
    }
    
    return @"0dBm";
}

#pragma mark - getter
- (UILabel *)rssiMsgLabel {
    if (!_rssiMsgLabel) {
        _rssiMsgLabel = [[UILabel alloc] init];
        _rssiMsgLabel.textAlignment = NSTextAlignmentLeft;
        _rssiMsgLabel.attributedText = [MKCustomUIAdopter attributedString:@[@"RSSI@1m",@"   (-100dBm ~ 0dBm)"] fonts:@[MKFont(15.f),MKFont(13.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(223, 223, 223)]];
    }
    return _rssiMsgLabel;
}

- (MKSlider *)rssiSlider {
    if (!_rssiSlider) {
        _rssiSlider = [[MKSlider alloc] init];
        _rssiSlider.maximumValue = 0;
        _rssiSlider.minimumValue = -100;
        _rssiSlider.value = -40;
        [_rssiSlider addTarget:self
                        action:@selector(rssiSliderValueChanged)
              forControlEvents:UIControlEventValueChanged];
    }
    return _rssiSlider;
}

- (UILabel *)rssiValueLabel {
    if (!_rssiValueLabel) {
        _rssiValueLabel = [[UILabel alloc] init];
        _rssiValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _rssiValueLabel.textAlignment = NSTextAlignmentLeft;
        _rssiValueLabel.font = MKFont(11.f);
        _rssiValueLabel.text = @"-40dBm";
    }
    return _rssiValueLabel;
}

- (UILabel *)txPowerMsgLabel {
    if (!_txPowerMsgLabel) {
        _txPowerMsgLabel = [[UILabel alloc] init];
        _txPowerMsgLabel.textAlignment = NSTextAlignmentLeft;
        _txPowerMsgLabel.attributedText = [MKCustomUIAdopter attributedString:@[@"Tx Power",@"   (-40,-20,-8,-4,0,+4,+8)"] fonts:@[MKFont(15.f),MKFont(13.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(223, 223, 223)]];
    }
    return _txPowerMsgLabel;
}

- (MKSlider *)txPowerSlider {
    if (!_txPowerSlider) {
        _txPowerSlider = [[MKSlider alloc] init];
        _txPowerSlider.maximumValue = 6.f;
        _txPowerSlider.minimumValue = 0.f;
        _txPowerSlider.value = 0.f;
        [_txPowerSlider addTarget:self
                           action:@selector(txPowerSliderValueChanged)
                 forControlEvents:UIControlEventValueChanged];
    }
    return _txPowerSlider;
}

- (UILabel *)txPowerValueLabel {
    if (!_txPowerValueLabel) {
        _txPowerValueLabel = [[UILabel alloc] init];
        _txPowerValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _txPowerValueLabel.textAlignment = NSTextAlignmentLeft;
        _txPowerValueLabel.font = MKFont(11.f);
        _txPowerValueLabel.text = @"-12dBm";
    }
    return _txPowerValueLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView1;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView2;
}

@end
