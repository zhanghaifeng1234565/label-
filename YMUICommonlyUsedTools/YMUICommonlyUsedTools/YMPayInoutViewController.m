//
//  YMPayInoutViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPayInoutViewController.h"

#import "YMPayInputView.h"

@interface YMPayInoutViewController ()

/** 支付密码视图 */
@property (nonatomic, strong) YMPayInputView *payView;

@end

@implementation YMPayInoutViewController

#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 加载导航数据
    [self loadNavUIData];
    // 添加视图
    [self addSubViews];
}
#pragma mark -- 加载导航数据
- (void)loadNavUIData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.title style:UIBarButtonItemStylePlain target:self action:nil];
}
#pragma mark -- 添加视图
- (void)addSubViews
{
    [self.view addSubview:self.payView];
}
#pragma mark -- getter
- (YMPayInputView *)payView
{
    if (_payView==nil) {
        _payView = [[YMPayInputView alloc] initWithFrame:CGRectMake(15, 60, MainScreenWidth-30, 40) passwordCount:6];
        [YMUICommonUsedTools configPropertyWithView:_payView backgroundColor:[UIColor whiteColor] cornerRadius:4.0f borderWidth:0.5f borderColor:[UIColor colorWithHexString:@"e5e5e5"]];
        __weak typeof(&*self) ws = self;
        _payView.inputSuccessBlock = ^(NSString *pswStr) {
            ws.payOnoutViewControllerBlock(pswStr);
            [ws.navigationController popViewControllerAnimated:YES];
        };
    }
    return _payView;
}
@end
