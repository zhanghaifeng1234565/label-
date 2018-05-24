//
//  EncodeViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^YMEncodeViewControllerBlcok)(NSString *title);
@interface EncodeViewController : BaseViewController

/** 归档 */
@property (nonatomic, copy) YMEncodeViewControllerBlcok encodeViewControllerBlcok;

@end
