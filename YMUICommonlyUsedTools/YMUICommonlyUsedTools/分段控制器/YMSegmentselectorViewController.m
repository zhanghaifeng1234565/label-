//
//  YMSegmentselectorViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMSegmentselectorViewController.h"
#import "YMSegmentselectorScrollView.h"

@interface YMSegmentselectorViewController ()<UIScrollViewDelegate>

/** 分段指示器个数数组 */
@property (nonatomic, strong) NSArray *segmentArr;
/** 标题 scrollView */
@property (nonatomic, strong) YMSegmentselectorScrollView *titleScrollView;
/** 内容 scrollView */
@property (nonatomic, strong) YMSegmentselectorScrollView *contentScrollView;
/** 下划线 */
@property (nonatomic, strong) UIView *underLineView;
/** 滑块视图 */
@property (nonatomic, strong) UIView *silderView;

@end

@implementation YMSegmentselectorViewController
{
    /** 上一次选中的btn */
    UIButton *_lastBtn;
    /** 总宽度低于屏幕物理宽度时,标题btn宽度 */
    CGFloat _btnwidth;
}
#pragma mark -- lazyLoad
- (UIView *)underLineView
{
    if (_underLineView==nil) {
        _underLineView = [[UIView alloc] init];
        _underLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4f];
    }
    return _underLineView;
}

- (UIView *)silderView
{
    if (_silderView==nil) {
        _silderView = [[UIView alloc] init];
        _silderView.backgroundColor =[UIColor greenColor];
    }
    return _silderView;
}

- (YMSegmentselectorScrollView *)titleScrollView
{
    if (_titleScrollView==nil) {
        _titleScrollView = [[YMSegmentselectorScrollView alloc] init];
        
        _titleScrollView.scrollsToTop = NO ;
        _titleScrollView.userInteractionEnabled =YES;
        [_titleScrollView setShowsVerticalScrollIndicator:NO];
        [_titleScrollView setShowsHorizontalScrollIndicator:NO];
        _titleScrollView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        
        for (int i = 0; i<self.segmentArr.count; i++) {
            UIViewController *vc = self.segmentArr[i];
            UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:[vc title] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:self.btnFont];
            [_titleScrollView addSubview:button];
        }
        [_titleScrollView addSubview:self.silderView];
        [_titleScrollView addSubview:self.underLineView];
    }
    return _titleScrollView;
}

- (YMSegmentselectorScrollView *)contentScrollView
{
    if (_contentScrollView==nil) {
        _contentScrollView = [[YMSegmentselectorScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.scrollsToTop = NO ;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        
        for (int i= 0; i<self.segmentArr.count; i++) {
            UIViewController *vc =self.segmentArr[i];
            [self addChildViewController:vc];
        }
    }
    return _contentScrollView;
}
#pragma mark -- init
- (instancetype)initWithSegmentVcArr:(NSArray *)segmentArr
{
    if (self=[super init]) {
        self.segmentArr = segmentArr;
    }
    return self;
}
#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 添加标题
    [self.view addSubview:self.titleScrollView];
    // 添加内容
    [self.view addSubview:self.contentScrollView];
}
#pragma mark -- 布局
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    /** 容器布局   */
    self.contentScrollView.frame = CGRectMake(0, self.tagHeight, MainScreenWidth, MainScreenHeight - self.tagHeight) ;
    self.contentScrollView.contentSize = CGSizeMake(self.segmentArr.count * MainScreenWidth , MainScreenHeight - self.tagHeight);
    
    /**  标签容器布局   */
    self.titleScrollView.frame = CGRectMake(0, 0, MainScreenWidth, self.tagHeight);
    
    /**  滑块布局   */
    self.silderView.frame = CGRectMake(0, self.tagHeight - 2, _btnwidth, 2);
    
    /**  标签布局   */
    CGFloat Zwidth = 0;  //每个btn宽度的总长
    CGFloat Fwidth;  //每个btn的frame
    
    int i = 0 ;
    //获取所有button
    for (UIView *titleScrollview in self.titleScrollView.subviews) {
        if ([[titleScrollview class] isEqual:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)titleScrollview;
            if (_btnNormolColor) {
                [subBtn setTitleColor:_btnNormolColor forState:UIControlStateNormal];
            }
            
            //每个btn宽度
            subBtn.titleLabel.font = [UIFont systemFontOfSize:self.btnFont];
            CGFloat subBtnWidth = [NSString autoWidthWithString:subBtn.titleLabel.text Font:self.btnFont]+30;
            Zwidth += subBtnWidth;  //总宽度
            Fwidth = Zwidth-subBtnWidth; //frame 宽度
            subBtn.frame=CGRectMake(Fwidth, 0, subBtnWidth, self.tagHeight - 2);
            subBtn.tag =10000+i;
            [subBtn addTarget:self action:@selector(cilckBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                subBtn.selected = YES;
                if (_btnSlectColor) {
                    [subBtn setTitleColor:_btnSlectColor forState:UIControlStateNormal];
                }else{
                    [subBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                _lastBtn = subBtn;
            }
            i++ ;
        }
    }
    //计算出来的总宽度小于屏幕宽度时，每个btn宽度
    if (Zwidth<MainScreenWidth) {
        _btnwidth = MainScreenWidth/self.childViewControllers.count;
    }
    if (Zwidth<MainScreenWidth) {
        //titlteBtn 居中显示
        self.titleScrollView.contentSize = CGSizeMake((MainScreenWidth-Zwidth) / 2 + Zwidth, self.tagHeight);
    }else{
        self.titleScrollView.contentSize = CGSizeMake(Zwidth, self.tagHeight);
    }
    /**   下划线  */
    self.underLineView.frame = CGRectMake(0, self.tagHeight - 0.5, Zwidth, 0.5);
    
    //默认偏移
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView ];
    //指定的偏移量
    if (self.ScorllviewIndex != 0) {
        CGPoint offset = self.contentScrollView.contentOffset;
        offset.x = self.ScorllviewIndex * MainScreenWidth;
        [self.contentScrollView setContentOffset:offset animated:YES];
    }
}
#pragma mark -- 标签按钮点击调用
- (void)cilckBtn:(UIButton *)btn
{
    UIButton *button = [self.titleScrollView viewWithTag:btn.tag];
    _lastBtn.selected = NO;
    if (self.btnNormolColor) { //if 设置了默认btn 颜色
        [_lastBtn setTitleColor:self.btnNormolColor forState:UIControlStateNormal];
    } else {
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    button.selected = YES;
    if (self.btnSlectColor) {
        [button setTitleColor:self.btnSlectColor forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    _lastBtn = button;
    NSInteger index = btn.tag-10000;
    // 定位到指定位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * MainScreenWidth;
    [self.contentScrollView setContentOffset:offset animated:YES];
}
#pragma mark UIScrollviewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;  // --->屏幕的宽度
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前控制器需要显示的控制器的索引
    NSInteger index = offsetX / width;
    // 让对应的顶部标题居中显示
    UIButton *button = self.titleScrollView.subviews[index];
    //滑块位置
    CGRect rect  =  CGRectMake(button.frame.origin.x+15, button.frame.size.height , button.frame.size.width-30, 2) ;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.silderView.frame=rect;
    }];
    _lastBtn.selected = NO;
    if (self.btnNormolColor) {
        [_lastBtn setTitleColor:self.btnNormolColor forState:UIControlStateNormal];
    } else {
        [_lastBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (![button isKindOfClass:[UIButton class]]) {
        return;
    }
    button.selected = YES;
    if (_btnSlectColor) {
        [button setTitleColor:_btnSlectColor forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    _lastBtn = button;
    //偏移量
    CGPoint titleOffsetX = self.titleScrollView.contentOffset;
    titleOffsetX.x = button.center.x - width/2; //这里是偏移移动，titlescorllview随着滑动移动，这里就是始终居中 - width/2
    // 左边偏移量边界
    if(titleOffsetX.x < 0) {
        titleOffsetX.x = 0;
    }
    //最大偏移， 避免最右边空出一大部分
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - width;
    // 右边偏移量边界
    if(titleOffsetX.x > maxOffsetX) {
        titleOffsetX.x = maxOffsetX;
    }
    // 修改偏移量
    [self.titleScrollView  setContentOffset:titleOffsetX animated:YES];
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    // 如果当前位置的控制器已经显示过了，就直接返回，不需要重复添加控制器的view
    if([willShowVc isViewLoaded]) return;
#pragma mark  控制器就是通过这里进行的显示
    // 如果你没有显示过，则将控制器的view添加到contentScrollView上
    willShowVc.view.frame = CGRectMake(index * width, 0, width, height);
    
    [scrollView addSubview:willShowVc.view];
}
#pragma mark -- 当手指抬起停止减速的时候会调用这个方法,
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView]; //加载ctrl
}
#pragma mark -- setter
-(void)setSliderBackColor:(UIColor *)sliderBackColor
{
    _sliderBackColor = sliderBackColor ;
    self.silderView.backgroundColor = sliderBackColor;
}
/**  标签栏颜色   */
-(void)setTitleScrollviewBackColor:(UIColor *)titleScrollviewBackColor
{
    _titleScrollviewBackColor = titleScrollviewBackColor;
    self.titleScrollView.backgroundColor =_titleScrollviewBackColor;
}
/**  默认选中时的颜色   */
-(void)setBtnSlectColor:(UIColor *)btnSlectColor
{
    _btnSlectColor = btnSlectColor;
}
/**  默认未选中的颜色  */
-(void)setBtnNormolColor:(UIColor *)btnNormolColor
{
    _btnNormolColor = btnNormolColor ;
}
#pragma mark -- getter
- (NSArray *)segmentArr
{
    if (_segmentArr==nil) {
        _segmentArr = [[NSArray alloc] init];
    }
    return _segmentArr;
}
@end
