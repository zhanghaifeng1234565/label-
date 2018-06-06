//
//  UIImage+Tools.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

/**
 生成一张图片

 @param color 颜色值
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 设置图片的透明度

 @param alpha 透明度
 @return 图片
 */
- (UIImage *)imageByScrollAlpha:(CGFloat)alpha;
@end
