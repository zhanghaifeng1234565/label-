//
//  YMUIPlaceholderTextView.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUIPlaceholderTextView.h"

@implementation YMUIPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
#pragma mark -- 调用 drawRect 方法
- (void)textChange
{
    [self setNeedsDisplay]; // 可以重新调用 drawRect 方法
}
#pragma mark -- 绘制占位文字
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:self.placeholderFont];
    dic[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:CGRectMake(4, 8, self.bounds.size.width, self.bounds.size.height) withAttributes:dic];
}
#pragma mark -- 设置索引的位置和大小
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    
    originalRect.size.height = self.font.lineHeight + 2;
    originalRect.size.width = 1.5;
    
    return originalRect;
}

@end
