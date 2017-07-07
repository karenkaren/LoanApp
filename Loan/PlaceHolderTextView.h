//
//  PlaceHolderTextView.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@property (nonatomic, assign) CGPoint placeHolderLabelOrigion;

-(void)textChanged:(NSNotification*)notification;

@end
