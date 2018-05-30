//
//  YMUISearchViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUISearchViewController.h"
#import "YMConsultViewController.h"

#import "YMUISearchBar.h"

@interface YMUISearchViewController ()

/** 搜索 */
@property (nonatomic, strong) YMUISearchBar *searchBar;

@end

@implementation YMUISearchViewController
#pragma mark -- init
- (instancetype)init
{
    if (self = [super init]) {
        //键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加视图
    [self addSubviews];
    // 配置属性
    [self configProperty];
    // 最后进行布局
    [self layoutSubviesUI];
}
#pragma mark -- 添加视图
- (void)addSubviews
{
    [self.view addSubview:self.searchBar];
}
#pragma mark -- 配置属性
- (void)configProperty
{
    self.searchBar.placeholder = @"placeholder";
}
#pragma mark -- 布局
- (void)layoutSubviesUI
{
    self.searchBar.frame = CGRectMake(15, 30, MainScreenWidth-30, 48);
}
#pragma mark -- getter
- (YMUISearchBar *)searchBar
{
    if (_searchBar==nil) {
        _searchBar = [[YMUISearchBar alloc] init];
        WS(ws);
        _searchBar.ymUISearchBarSearchBtnActionBlock = ^(NSString *text) {
            YMConsultViewController *vc = [[YMConsultViewController alloc] init];
            vc.title = text;
            [ws.navigationController pushViewController:vc animated:YES];
        };
        _searchBar.placeholderColor = @"ff3d3d";
        _searchBar.topMargin = 6;
        _searchBar.leftMargin = 15;
        _searchBar.baseBackgroundImage = [UIImage imageNamed:@"top_navigation_bg_6p"];
        _searchBar.tfLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_sousuo"]];
        _searchBar.clearImage = @"login_delete_icon";
    }
    return _searchBar;
}
#pragma mark - KeyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
