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
@property (nonatomic, strong) UISwitch * switchButton;

@end

@implementation ProfileCell

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
    self.valueTextField.font = kFont(14);
    self.valueTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
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
            self.selectBlock(self.valueTextField);
        }
    }];
    [self.contentView addSubview:self.detailButton];
    
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kCommonMargin);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    self.valueTextField = [[UITextField alloc] init];
    self.valueTextField.font = kFont(14);
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
    self.switchButton = switchButton;
    
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
    
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:cellData[kProfilePlaceholder] attributes:@{NSFontAttributeName : kFont(14)}] ;
    self.valueTextField.attributedPlaceholder = attributedString;
    self.valueTextField.text = cellData[kProfileValue];
    self.switchButton.on = [cellData[kProfileValue] boolValue];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    ProfileType type = [_cellData[kProfileType] integerValue];
    if (type == ProfileTypeSelect) {
        if (self.selectBlock) {
            self.selectBlock(textField);
        }
        return NO;
    }
    return YES;
}

- (void)textFieldValueChanged:(NSNotification *)notification
{
    UITextField * textField = notification.object;
    if (textField != self.valueTextField) {
        return;
    }
    NSInteger limitCount = [self.cellData[kProfileLimitCount] integerValue];
    if (textField.text.length > limitCount) {
        textField.text = [textField.text substringToIndex:limitCount];
    }
    if (self.textChangedBlock) {
        self.textChangedBlock(self.cellData[kProfileKey], textField.text);
    }
}

- (void)switchStatusChanged:(UISwitch *)switchButton
{
    if (self.switchStatusChangedBlock) {
        self.switchStatusChangedBlock(switchButton.on);
    }
}

@end
