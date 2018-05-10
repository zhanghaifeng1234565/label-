//
//  UIControl+ButtonClickLimit.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ButtonClickLimit)

/** 间隔多少秒才能响应事件 */
@property(nonatomic, assign) NSTimeInterval  acceptEventInterval;
/** 是否能执行方法 */
@property(nonatomic, assign) BOOL ignoreEvent;

@end
