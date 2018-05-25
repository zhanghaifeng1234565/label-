//
//  YMUISearchBar.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YMUISearchBarSearchBtnActionBlock)(NSString *text);
@interface YMUISearchBar : UISearchBar

/** 搜索按钮点击回到 */
@property (nonatomic, copy) YMUISearchBarSearchBtnActionBlock ymUISearchBarSearchBtnActionBlock;

@end
