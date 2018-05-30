//
//  YMUISearchBar.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUISearchBar.h"

@interface YMUISearchBar ()<UITextFieldDelegate>
/** placeholder 和icon 和 间隙的整体宽度 */
@property (nonatomic, assign) CGFloat placeholderWidth;
@end

// icon宽度
static CGFloat const searchIconW = 20.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;
// 占位文字的字体大小
static CGFloat const placeHolderFont = 14.0;

@implementation YMUISearchBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置背景图片
    UIImage *backImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [self setBackgroundImage:backImage];
    if (self.baseBackgroundImage) {
        [self setBackgroundImage:self.baseBackgroundImage];
    }
    
    for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            // 重设field的frame
            field.delegate = self;
            field.borderStyle = UITextBorderStyleNone;
            
            field.frame = CGRectMake(self.leftMargin, self.topMargin, self.frame.size.width-self.leftMargin*2, self.frame.size.height-2*self.topMargin);
            
            if (self.tfLeftView) {
                field.leftView = self.tfLeftView;
            }
            
            if (self.clearImage) {
                UIButton *button = [field valueForKey:@"_clearButton"];
                [button setImage:[UIImage imageNamed:self.clearImage] forState:UIControlStateNormal];
            }
            
            field.layer.masksToBounds = YES;
            if (self.tfCornerRadius) {
                field.layer.cornerRadius = self.tfCornerRadius;
            } else {
                field.layer.cornerRadius = 4.0f;
            }
            
            if (self.backgroundColor) {
                [field setBackgroundColor:[UIColor colorWithHexString:self.backgroundColor]];
            } else {
                [field setBackgroundColor:[UIColor colorWithHexString:@"#eeeeee"]];
            }
            
            if (self.textColor) {
                field.textColor = [UIColor colorWithHexString:self.textColor];
            } else {
                field.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
            }
            
            if (self.textFont) {
                field.font = [UIFont systemFontOfSize:self.textFont];
            } else {
                field.font = [UIFont systemFontOfSize:14];
            }
            
            // 设置占位文字字体颜色
            if (self.placeholderColor) {
                [field setValue:[UIColor colorWithHexString:self.placeholderColor] forKeyPath:@"_placeholderLabel.textColor"];
            } else {
                [field setValue:[UIColor colorWithHexString:@"#a8a8a8"] forKeyPath:@"_placeholderLabel.textColor"];
            }
            
            if (self.placeholderFont) {
                [field setValue:[UIFont systemFontOfSize:self.placeholderFont] forKeyPath:@"_placeholderLabel.font"];
            } else {
                [field setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
            }
            
            if (@available(iOS 11.0, *)) {
                // 先默认居中placeholder
                [self setPositionAdjustment:UIOffsetMake((field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
    }
}
#pragma mark -- 搜索按钮点击调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.ymUISearchBarSearchBtnActionBlock) {
        self.ymUISearchBarSearchBtnActionBlock(textField.text);
    }
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -- 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
#pragma mark -- 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
#pragma mark -- getter
- (CGFloat)placeholderWidth
{
    if (!_placeholderWidth) {
        
        CGFloat tempFont = placeHolderFont;
        if (self.placeholderFont) {
            tempFont = self.placeholderFont;
        }
        CGFloat tempMargin = iconSpacing;
        self.searchTextPositionAdjustment = UIOffsetMake(10, 0);
        if (self.iconSpacing) {
            tempMargin = self.iconSpacing;
            self.searchTextPositionAdjustment = UIOffsetMake(self.iconSpacing, 0);
        }
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:tempFont]} context:nil].size;
        _placeholderWidth = size.width + tempMargin + searchIconW;
    }
    return _placeholderWidth;
}
@end
