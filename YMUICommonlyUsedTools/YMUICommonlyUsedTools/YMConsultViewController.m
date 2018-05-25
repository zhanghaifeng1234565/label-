//
//  YMConsultViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMConsultViewController.h"
#import "ViewController.h"
#import "YMSegmentselectorViewController.h"

@interface YMConsultViewController ()

/** 分段选择控制器 */
@property (nonatomic, strong) YMSegmentselectorViewController *segmentVc;

@end

@implementation YMConsultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSMutableArray *titleArr = [[NSMutableArray alloc] initWithObjects:@"概述",@"适应症",@"用法用量",@"不良反应",@"注意事项",@"不良反应",@"注意事项",@"不良反应",@"注意事项", nil];
    
    NSMutableArray *segmentArr = [NSMutableArray array]; //装控制器
    
    NSInteger i = 0 ;
    for (NSString *titile in titleArr) {
        ViewController *vc = [[ViewController alloc] init];
        vc.title = titile ;
        vc.navStr = [NSString stringWithFormat:@"%zd", i];
        [segmentArr addObject:vc];
        i++ ;
    }
    
    YMSegmentselectorViewController *segmentVc = [[YMSegmentselectorViewController alloc] initWithSegmentVcArr:segmentArr];;
    segmentVc.view.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    _segmentVc = segmentVc ;
    _segmentVc.view.frame=CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    _segmentVc.view.backgroundColor = [UIColor whiteColor];
    _segmentVc.btnFont = 15;
    _segmentVc.tagHeight = 40;
    _segmentVc.sliderBackColor= [UIColor colorWithHexString:@"03abff"];  //滑块默认颜色
    _segmentVc.btnNormolColor = [UIColor colorWithHexString:@"323232"]; //btn正常时的颜色
    _segmentVc.btnSlectColor = [UIColor colorWithHexString:@"03abff"]; //btn选中时的颜色
    _segmentVc.ScorllviewIndex = 0;  //默认第0个控制器
    [self addChildViewController:_segmentVc];  //不可缺少重要
    [self.view addSubview:_segmentVc.view];
}
@end
