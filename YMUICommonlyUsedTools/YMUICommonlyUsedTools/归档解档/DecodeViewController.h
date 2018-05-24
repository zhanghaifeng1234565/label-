//
//  DecodeViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^YMDecodeViewControllerBlcok)(NSString *title);
@interface DecodeViewController : BaseViewController

/** 解档 */
@property (nonatomic, copy) YMDecodeViewControllerBlcok decodeViewControllerBlcok;

@end
