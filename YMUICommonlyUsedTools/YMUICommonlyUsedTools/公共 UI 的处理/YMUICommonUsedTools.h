//
//  YMUICommonUsedTools.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMUIPlaceholderTextView;

@interface YMUICommonUsedTools : NSObject

/**********************  label 相关  *************************/
/**
 配置 label 的属性

 @param label 要配置的 label
 @param font  字体大小
 @param color 字体颜色
 @param textAlignment 文字对齐方式
 */
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment numberOfLine:(CGFloat)numberOfLine;

/**
 配置 label 的圆角颜色

 @param view 要配置的 view
 @param backgroundColor  背景颜色
 @param cornerRadius 圆角大小
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
+ (void)configPropertyWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 配置 label 的行间距

 @param label 要配置的 label
 @param font 要配置的 label 的字体大小
 @param lineSpace  行间距
 @param maxWidth 要展示的最大宽度
 */
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth;

/**
 设置行间距的前提下的 label 高度

 @param label 要获取的 label
 @param font  字体大小
 @param lineSpace 行间距
 @param maxWidth 最大显示宽度
 @return 要展示的 label 的高度
 */
+ (CGFloat)getHeightWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth;

/**
 获取 label 单行显示的时候需要的宽度

 @param label 要获取的 label
 @param font  字体大小
 @return 宽度
 */
+ (CGFloat)getWidthWithLabel:(UILabel *)label font:(CGFloat)font;

/**********************  button 相关  *************************/
/**
 配置按钮的文字

 @param button 要配置的按钮
 @param title 按钮显示的文字
 @param titleColor 文字的颜色
 @param font 文字的大小
 */
+ (void)configPropertyWithButton:(UIButton *)button title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(CGFloat)font;

/**
 配置按钮背景图片

 @param button 要配置的按钮
 @param normalBackgroundImage 普通状态下的按钮背景图片
 @param highlightBackgroundImage 高亮状态下的按钮图片
 */
+ (void)configPropertyWithButton:(UIButton *)button normalBackgroundImage:(NSString *)normalBackgroundImage highlightBackgroundImage:(NSString *)highlightBackgroundImage;

/**********************  textField 相关  *************************/
/**
 配置 textField 输入框

 @param textField 要配置的 textField
 @param textFont 字体大小
 @param textColor 字体颜色
 @param placeHolder 占位文字
 @param textPlaceHolderFont 占位文字大小
 @param textPlaceHolderTextColor 占位文字颜色
 @param textAlignment 字体对齐方式
 */
+ (void)configPropertyWithTextField:(UITextField *)textField textFont:(CGFloat)textFont textColor:(UIColor *)textColor textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment;

/**
 配置带有占位文字包含字体间距的 textView

 @param textView  要配置的 textView
 @param textFont textView 字体大小
 @param textColor textView 字体颜色
 @param lineSpace textView 行间距
 @param placeHolder textView 占位文字
 @param textPlaceHolderFont textView 占位文字大小
 @param textPlaceHolderTextColor textView 占位文字颜色
 @param textAlignment 文字对齐方式
 */
+ (void)configPropertyWithTextView:(YMUIPlaceholderTextView *)textView textFont:(CGFloat)textFont textColor:(UIColor *)textColor lineSpace:(CGFloat)lineSpace textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment;
@end
