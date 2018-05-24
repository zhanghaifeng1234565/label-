//
//  DecodeViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DecodeViewController.h"

@interface DecodeViewController ()

/** 展示 */
@property (nonatomic, strong) UILabel *label;
/** 清除按钮 */
@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation DecodeViewController

#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.clearBtn];
    
    YMNSKeyedArchiverStore *store = [YMNSKeyedArchiverStore getObjectWithPath:@"personFile.data"];
    self.label.text = [NSString stringWithFormat:@"姓名：%@ -- 年龄：%@", store.name, store.age];
    [YMUICommonUsedTools configPropertyWithLabel:self.label font:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLine:0];
    
    [YMUICommonUsedTools configPropertyWithButton:self.clearBtn title:@"清除" titleColor:[UIColor brownColor] titleLabelFont:17];
    [YMUICommonUsedTools configPropertyWithView:self.clearBtn backgroundColor:[UIColor magentaColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
}
#pragma mark -- 清除按钮点击调用
- (void)clearBtnClick
{
    [YMNSKeyedArchiverStore clearFilePath:@"personFile.data"];
    if (self.decodeViewControllerBlcok) {
        self.decodeViewControllerBlcok(@"归档");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- getter
- (UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, MainScreenWidth-30, 100)];
    }
    return _label;
}

- (UIButton *)clearBtn
{
    if (_clearBtn==nil) {
        _clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, self.label.bottom+30, MainScreenWidth-30, 48)];
        [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
@end
