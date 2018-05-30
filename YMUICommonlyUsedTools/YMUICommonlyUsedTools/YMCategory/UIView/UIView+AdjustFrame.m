//
//  UIView+AdjustFrame.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIView+AdjustFrame.h"

@implementation UIView (AdjustFrame)

#pragma mark -- getter
- (CGFloat)top
{
    return self.frame.origin.x;
}

- (CGFloat)bottom
{
    return self.frame.origin.x+self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
#pragma mark -- stetter
- (void)setTop:(CGFloat)top
{
    self.frame = CGRectMake(self.x, top, self.width, self.height);
}

- (void)setBottom:(CGFloat)bottom
{
    self.frame = CGRectMake(self.x, self.y, self.width, bottom-self.height);
}

- (void)setLeft:(CGFloat)left
{
    self.frame = CGRectMake(left, self.y, self.width, self.height);
}

- (void)setRight:(CGFloat)right
{
    CGRect tempRect = self.frame;
    tempRect.size.width -= right;
    self.frame = tempRect;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}
@end
