//
//  YMUICommonUsedTools.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUICommonUsedTools.h"
#import "YMUIPlaceholderTextView.h"

@implementation YMUICommonUsedTools

#pragma mark -- 公共方法
#pragma mark -- 配置 视图 的属性【背景颜色】【圆角大小】【边线颜色】
+ (void)configPropertyWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
{
    view.backgroundColor = backgroundColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}
#pragma mark -- 配置任意圆角的方法
+ (void)configArbitraryCornerRadiusView:(UIView *)view cornerRadius:(CGFloat)cornerRadius withType:(ArbitraryCornerRadiusViewType)type
{
    UIBezierPath *maskPath = [[UIBezierPath alloc] init];
    switch (type) {
        case ArbitraryCornerRadiusViewTypeDefault:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        default:
            break;
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
#pragma mark -- label 相关
#pragma mark -- 配置 label 的属性【字体】【颜色】【对齐方式】【显示行数】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment numberOfLine:(CGFloat)numberOfLine
{
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLine;
}
#pragma mark -- 配置 label 的属性【行间距】【要显示的最大宽度】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = size.height+1>font*2 ? lineSpace:0;
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    label.attributedText = attributedString;
}
#pragma mark -- 计算带有行间距的 label 的高度
+ (CGFloat)getHeightWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth
{
    CGFloat labelHeight = 0.0f;
    CGSize originSize = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = originSize.height+1>font*2 ? lineSpace:0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                          NSParagraphStyleAttributeName:paraStyle
                          ,NSBaselineOffsetAttributeName:NSBaselineOffsetAttributeName};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    labelHeight = size.height+1;
    return labelHeight;
}
#pragma mark -- 计算文字单行显示的宽度
+ (CGFloat)getWidthWithLabel:(UILabel *)label font:(CGFloat)font
{
    // 当文字单行显示的时候 label 的高度
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.width+1;
}
#pragma mark -- button 相关
#pragma mark -- 配置按钮的 【显示文字】 【字体颜色】 【字体大小】
+ (void)configPropertyWithButton:(UIButton *)button title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(CGFloat)font
{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
}
#pragma mark -- 配置按钮的背景图片
+ (void)configPropertyWithButton:(UIButton *)button normalBackgroundImage:(NSString *)normalBackgroundImage highlightBackgroundImage:(NSString *)highlightBackgroundImage
{
    [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightBackgroundImage] forState:UIControlStateHighlighted];
}
#pragma mark -- textField 相关
+ (void)configPropertyWithTextField:(UITextField *)textField textFont:(CGFloat)textFont textColor:(UIColor *)textColor textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment
{
    textField.font = [UIFont systemFontOfSize:textFont];
    textField.textColor = textColor;
    textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textPlaceHolderFont],NSForegroundColorAttributeName:textPlaceHolderTextColor}];
    textField.textAlignment = textAlignment;
}
#pragma mark -- textView 相关
+ (void)configPropertyWithTextView:(YMUIPlaceholderTextView *)textView textFont:(CGFloat)textFont textColor:(UIColor *)textColor lineSpace:(CGFloat)lineSpace textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment
{
    textView.font = [UIFont systemFontOfSize:textFont];
    textView.textColor = textColor;
    textView.textAlignment = textAlignment;
    textView.placeholder = placeHolder;
    textView.placeholderColor = textPlaceHolderTextColor;
    textView.placeholderFont = textPlaceHolderFont;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSParagraphStyleAttributeName:paragraphStyle};
}
@end
