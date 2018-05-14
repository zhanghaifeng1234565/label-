//
//  YMPayInputView.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 输入完成回调 */
typedef void(^YMPayInputSuccessBlock)(NSString *pswStr);

@interface YMPayInputView : UIView

/** 支付成功回调 */
@property (nonatomic, copy) YMPayInputSuccessBlock inputSuccessBlock;

/** 初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame passwordCount:(NSInteger)passwordCount;

/** 密码字符串 */
@property (nonatomic, copy) NSString *pswStr;

@end
