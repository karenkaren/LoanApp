//
//  ProfileCell.m
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProfileCell.h"
#

@interface ProfileCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextField * valueTextField;
@property (nonatomic, strong) UIButton * detailButton;

@end

@implementation ProfileCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self addAllSubviews];
//    }
//    return self;
//}

- (instancetype)initWithProfileType:(ProfileType)type reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        switch (type) {
            case ProfileTypeInput:
                [self addAllInputSubviews];
                break;
            case ProfileTypeSelect:
                [self addAllSelectSubviews];
                break;
            case ProfileTypeSwitch:
                [self addAllSwitchSubviews];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)addTitleLabel{
    
    self.titleLabel = [UILabel createLabelWithText:@"" font:kFont(14) color:kTextColor];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kCommonMargin);
        make.top.height.equalTo(self);
        make.width.equalTo(@80);
    }];
}

- (void)addAllInputSubviews
{
    [self addTitleLabel];
    
    self.valueTextField = [[UITextField alloc] init];
    self.valueTextField.delegate = self;
    [self.contentView addSubview:self.valueTextField];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.height.equalTo(self.titleLabel);
        make.width.equalTo(self).offset(-kCommonMargin - 80);
    }];
}

- (void)addAllSelectSubviews
{
    [self addTitleLabel];
    
    self.detailButton = [UIButton createButtonWithIconName:@"icon_arrow" block:^(UIButton *button) {
        if (self.selectBlock) {
            self.selectBlock();
        }
    }];
    [self.contentView addSubview:self.detailButton];
    
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kCommonMargin);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    self.valueTextField = [[UITextField alloc] init];
    self.valueTextField.delegate = self;
    [self.contentView addSubview:self.valueTextField];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.height.equalTo(self.titleLabel);
        make.right.equalTo(self.detailButton.mas_left);
    }];
}

- (void)addAllSwitchSubviews
{
    [self addTitleLabel];
    
    UISwitch * switchButton = [[UISwitch alloc] init];
    [switchButton addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:switchButton];
    
    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self);
        make.height.equalTo(self).offset(-10);
        make.width.equalTo(switchButton.mas_height).multipliedBy(2);
    }];
}

- (void)setCellData:(NSDictionary *)cellData
{
    _cellData = cellData;
    self.titleLabel.text = cellData[kProfileTitle];
    self.valueTextField.placeholder = cellData[kProfilePlaceholder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    ProfileType type = [_cellData[kProfileType] integerValue];
    if (type == ProfileTypeSelect) {
        if (self.selectBlock) {
            self.selectBlock();
        }
        return NO;
    }
    return YES;
}

- (void)switchStatusChanged:(UISwitch *)switchButton
{
    if (self.switchStatusChangedBlock) {
        self.switchStatusChangedBlock(switchButton.on);
    }
}

@end
