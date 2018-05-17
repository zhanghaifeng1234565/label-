//
//  YMPayInoutViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YMPayOnoutViewControllerBlock)(NSString *pwdStr);

@interface YMPayInoutViewController : UIViewController

/** 支付回调密码 */
@property (nonatomic, copy) YMPayOnoutViewControllerBlock payOnoutViewControllerBlock;

@end
