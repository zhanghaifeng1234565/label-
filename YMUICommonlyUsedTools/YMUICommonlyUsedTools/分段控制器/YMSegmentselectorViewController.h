//
//  YMSegmentselectorViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMSegmentselectorViewController : UIViewController

/** 标题栏高度 */
@property (nonatomic, assign) CGFloat tagHeight;
/**  定义ScorllCtrl的contenoffset 创建的时候偏移量   */
@property (nonatomic, assign) NSInteger ScorllviewIndex;
/**  定义滑块背景色  默认绿 */
@property (nonatomic, copy) UIColor *sliderBackColor;
/**  定义标题栏背景色   */
@property (nonatomic, copy) UIColor *titleScrollviewBackColor;
/**   btn。即标签 未选中正常颜色  */
@property (nonatomic, copy) UIColor *btnNormolColor;
/**  btn 即标签 选中时颜色   */
@property (nonatomic, copy) UIColor *btnSlectColor;
/** 标签字体大小 */
@property (nonatomic, assign) CGFloat btnFont;


/**
 初始化分段控制器

 @param segmentArr 装有自控制器的数组
 @return 分段控制器
 */
- (instancetype)initWithSegmentVcArr:(NSArray *)segmentArr;
@end
