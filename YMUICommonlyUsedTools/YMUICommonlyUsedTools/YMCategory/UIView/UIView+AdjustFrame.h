//
//  UIView+AdjustFrame.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AdjustFrame)

/**************  getter   ******************/
/**
 获取视图顶部位置 top

 @return top
 */
- (CGFloat)top;
/**
 获取视图底部位置 bottom

 @return bottom
 */
- (CGFloat)bottom;
/**
 获取视图左边位置 left

 @return left
 */
- (CGFloat)left;
/**
 获取视图右边位置 right

 @return right
 */
- (CGFloat)right;

/**
 获取视图的起始位置 x

 @return x
 */
- (CGFloat)x;
/**
 获取视图的起始位置 y

 @return y
 */
- (CGFloat)y;
/**
 获取视图的宽度 width

 @return width
 */
- (CGFloat)width;
/**
 获取视图的的高度 height

 @return height
 */
- (CGFloat)height;

/**************  setter   ******************/
/**
 设置视图的顶部位置 top

 @param top top
 */
- (void)setTop:(CGFloat)top;
/**
 设置视图的底部位置  bottom

 @param bottom bottom
 */
- (void)setBottom:(CGFloat)bottom;
/**
 设置视图的左边位置  left

 @param left left
 */
- (void)setLeft:(CGFloat)left;
/**
 设置视图的右边位置  right

 @param right right
 */
- (void)setRight:(CGFloat)right;
/**
 设置视图的起点 x

 @param x x
 */
- (void)setX:(CGFloat)x;
/**
  设置视图的起点 y

 @param y y
 */
- (void)setY:(CGFloat)y;
/**
 设置视图的宽度 width

 @param width width
 */
- (void)setWidth:(CGFloat)width;
/**
 设置视图的高度 height

 @param height height
 */
- (void)setHeight:(CGFloat)height;
@end
