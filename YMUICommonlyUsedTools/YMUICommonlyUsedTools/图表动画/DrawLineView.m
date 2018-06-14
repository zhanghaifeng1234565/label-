//
//  DrawLineView.m
//  CALayerDemo
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DrawLineView.h"

@interface DrawLineView ()
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;
/** 颜色渐变图层 */
@property (nonatomic, strong) CAShapeLayer *colorShapeLayer;
/** 动画路径 */
@property (nonatomic, strong) UIView *demoView;
@end

@implementation DrawLineView

- (instancetype)init
{
    if (self = [super init]) {
        [self.layer addSublayer:self.colorShapeLayer];
        [self.colorShapeLayer addSublayer:self.gradientLayer];
        [self addSubview:self.demoView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.colorShapeLayer.frame = self.bounds;
    self.gradientLayer.frame = self.colorShapeLayer.bounds;
    self.demoView.frame = CGRectMake(self.frame.size.width/7/2, 70, 10, 10);
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 1);
    CGPoint points[7];
    points[0] = CGPointMake(self.frame.size.width/7/2, 70);
    points[1] = CGPointMake(self.frame.size.width/7, 130);
    points[2] = CGPointMake(self.frame.size.width/7*2, 90);
    points[3] = CGPointMake(self.frame.size.width/7*3, 60);
    points[4] = CGPointMake(self.frame.size.width/7*4, 30);
    points[5] = CGPointMake(self.frame.size.width/7*5, 80);
    points[6] = CGPointMake(self.frame.size.width/7*6, 70);
    CGContextAddLines(context, points, 7);
    CGContextStrokePath(context);
    
    CGFloat margin = 10.0f;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width/7/2, 200)];
    [path addLineToPoint:CGPointMake(points[0].x, points[0].y+margin)];
    [path addLineToPoint:CGPointMake(points[1].x, points[1].y+margin)];
    [path addLineToPoint:CGPointMake(points[2].x, points[2].y+margin)];
    [path addLineToPoint:CGPointMake(points[3].x, points[3].y+margin)];
    [path addLineToPoint:CGPointMake(points[4].x, points[4].y+margin)];
    [path addLineToPoint:CGPointMake(points[5].x, points[5].y+margin)];
    [path addLineToPoint:CGPointMake(points[6].x, points[6].y+margin)];
    [path addLineToPoint:CGPointMake(points[6].x, 200)];
    [path closePath];
    path.lineWidth = 10;
    [[UIColor clearColor] setStroke];
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    animation.path = path.CGPath;
    // 动画时间间隔
    animation.duration = 3.0f;
    // 重复次数为最大值
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到动画视图上
    [_demoView.layer addAnimation:animation forKey:nil];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    self.colorShapeLayer.mask = shapeLayer;
    
    for (int i = 0; i < 7; i ++) {
        CGRect ellipseRect = CGRectMake(points[i].x - 3, points[i].y - 3, 8, 8);
        CGContextAddEllipseInRect(context, ellipseRect);
        CGContextSetLineWidth(context, 3);
        [[UIColor whiteColor] setStroke];
        [[UIColor redColor] setFill];
        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
    }
}

- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
        _gradientLayer.startPoint = CGPointMake(0, 0.0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    }
    return _gradientLayer;
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

- (UIView *)demoView
{
    if (_demoView == nil) {
        _demoView = [[UIView alloc] init];
        _demoView.backgroundColor = [UIColor redColor];
        _demoView.layer.masksToBounds = YES;
        _demoView.layer.cornerRadius = 5.0f;
    }
    return _demoView;
}
@end
