//
//  BaseViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUINavigationController.h"

@interface BaseViewController : UIViewController<YMUINavigationControllerDelegate>

/** 是否使用自定义返回操作 建议当返回操作多余一个控制器时使用 */
@property (nonatomic, assign, getter=isCustomBack) BOOL customBack;

@end
