//
//  YMWKWebViewViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "BaseViewController.h"

@interface YMWKWebViewViewController : BaseViewController

/** url 网址 */
@property (nonatomic, copy) NSString *webViewUrl;
/* 进度条颜色设置 */
@property (nonatomic, copy) NSString *webViewBarTintColor;
/* 可以自定义进度条 */
@property (nonatomic, retain) UIView *progressView;

@end
