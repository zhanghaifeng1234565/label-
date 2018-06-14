//
//  ChartSimpleViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ChartSimpleViewController.h"
#include <math.h>

#import "DrawLineView.h"

@interface ChartSimpleViewController ()
/** 背景视图 */
@property (nonatomic, strong) UIView *bgView;
/** 垂直线 */
@property (nonatomic, strong) CALayer *vLayer;
/** 水平线 */
@property (nonatomic, strong) CALayer *hLayer;
/** 斜线 */
@property (nonatomic, strong) CALayer *lineLayer;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;
/** 画折线 */
@property (nonatomic, strong) DrawLineView *drawLineView;
/** 颜色渐变图层 */
@property (nonatomic, strong) CAShapeLayer *colorShapeLayer;

@end

@implementation ChartSimpleViewController

#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加视图
    [self addSubviews];
    // 布局视图
    [self layoutSubviews];
}
#pragma mark -- 添加视图
- (void)addSubviews
{
    [self.view addSubview:self.bgView];
    
    [self.bgView.layer addSublayer:self.hLayer];
    [self.bgView.layer addSublayer:self.colorShapeLayer];
    [self.colorShapeLayer addSublayer:self.gradientLayer];
    [self.bgView.layer addSublayer:self.vLayer];
    [self.bgView.layer addSublayer:self.lineLayer];
    
    [self.view addSubview:self.drawLineView];
}
#pragma mark -- 布局视图
- (void)layoutSubviews
{
    self.bgView.frame = CGRectMake(15, 100, self.view.frame.size.width-30, 200);
    self.vLayer.frame = CGRectMake(0, 0, 1, self.bgView.frame.size.height);
    self.hLayer.frame = CGRectMake(0, self.bgView.frame.size.height, self.bgView.frame.size.width, 1);
    
    self.lineLayer.frame = CGRectMake(0, self.bgView.frame.size.height/2-0.5, self.bgView.frame.size.width, 1);
    double angle = atan(self.bgView.frame.size.height/self.bgView.frame.size.width);
    NSLog(@"angle===%f", angle);
    [self.lineLayer setValue:@(M_PI-angle) forKeyPath:@"transform.rotation.z"];
    
    self.colorShapeLayer.frame = self.bgView.bounds;
    self.gradientLayer.frame = self.colorShapeLayer.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addLineToPoint:CGPointMake(20, 195)];
    [path addLineToPoint:CGPointMake(self.colorShapeLayer.frame.size.width-20, 15)];
    [path addLineToPoint:CGPointMake(self.colorShapeLayer.frame.size.width-20, 200)];
    [path addLineToPoint:CGPointMake(20, 200)];
    // [path addLineToPoint:CGPointMake(10, 10)];
    //    [path closePath];
    
    path.lineWidth = 10;
    [[UIColor redColor] setStroke];
    
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    self.colorShapeLayer.mask = shapeLayer;
    
    NSNumber *point1 = [NSNumber numberWithInt:0.9];
    NSNumber *point2 = [NSNumber numberWithInt:0.5];
    NSNumber *point3 = [NSNumber numberWithInt:0.1];
    _gradientLayer.locations = @[point1, point2, point3];
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    
    self.drawLineView.frame = CGRectMake(15, 350, self.view.frame.size.width-30, 200);
}
#pragma mark -- lazyLoad
- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bgView;
}

- (CALayer *)hLayer
{
    if (_hLayer == nil) {
        _hLayer = [[CALayer alloc] init];
        _hLayer.backgroundColor = [UIColor magentaColor].CGColor;
    }
    return _hLayer;
}

- (CALayer *)vLayer
{
    if (_vLayer == nil) {
        _vLayer = [[CALayer alloc] init];
        _vLayer.backgroundColor = [UIColor magentaColor].CGColor;
    }
    return _vLayer;
}

- (CALayer *)lineLayer
{
    if (_lineLayer == nil) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _lineLayer;
}

- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        //        //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
        //        _gradientLayer.startPoint = CGPointMake(0, 0.0);
        //        _gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    }
    return _gradientLayer;
}

- (DrawLineView *)drawLineView
{
    if (_drawLineView == nil) {
        _drawLineView = [[DrawLineView alloc] init];
        _drawLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _drawLineView;
}

- (CAShapeLayer *)colorShapeLayer
{
    if (_colorShapeLayer == nil) {
        _colorShapeLayer = [[CAShapeLayer alloc] init];
        _colorShapeLayer.fillColor = [UIColor blueColor].CGColor;
        _colorShapeLayer.strokeColor = [UIColor purpleColor].CGColor;
        _colorShapeLayer.masksToBounds = YES;
    }
    return _colorShapeLayer;
}
@end
