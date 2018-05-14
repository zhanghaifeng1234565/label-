//
//  YMPayInputView.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPayInputView.h"

static CGFloat dotWidth = 11.0f;

@interface YMPayInputView ()<UITextFieldDelegate, YMUITextFieldDelegate, UIGestureRecognizerDelegate>

/** 背景视图数组 */
@property (nonatomic, strong) NSMutableArray <UIView *> *bgViewArr;
/** 密码圆点 label 数组 */
@property (nonatomic, strong) NSMutableArray <UILabel *> *dotLabelArr;
/** 密码输入框 数组*/
@property (nonatomic, strong) NSMutableArray <UITextField *> *textFieldArr;
/** 密码位数 */
@property (nonatomic, assign) NSInteger passwordCount;
/** 最后一次输入的字符串 */
@property (nonatomic, copy) NSString *lastStr;

@end

@implementation YMPayInputView
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame passwordCount:(NSInteger)passwordCount
{
    if (self=[super initWithFrame:frame]) {
        self.passwordCount = passwordCount;
        [self setUpUI];
    }
    return self;
}
#pragma mark -- 创建视图
- (void)setUpUI
{
    for (int i = 0; i < self.passwordCount; i++) {
        // 背景
        UIView *bgView = [[UIView alloc] init];
        bgView.tag = i;
        [self addSubview:bgView];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
        [bgView addGestureRecognizer:tap];
        [YMUICommonUsedTools configPropertyWithView:bgView backgroundColor:[UIColor whiteColor] cornerRadius:0.0f borderWidth:0.5f borderColor:[UIColor colorWithHexString:@"e5e5e5"]];
        bgView.frame = CGRectMake(i*self.width/self.passwordCount, 0, self.width/self.passwordCount, self.height);
        [self.bgViewArr addObject:bgView];
        
        // 圆点
        UILabel *dotLabel = [[UILabel alloc] init];
        [bgView addSubview:dotLabel];
        dotLabel.tag = i;
        dotLabel.frame = CGRectMake((bgView.width-dotWidth)/2, (bgView.height-dotWidth)/2, dotWidth, dotWidth);
        [YMUICommonUsedTools configPropertyWithView:dotLabel backgroundColor:[UIColor colorWithHexString:@"ff3d3d"] cornerRadius:dotWidth/2 borderWidth:0.0f borderColor:[UIColor colorWithHexString:@"ff3d3d"]];
        [self.dotLabelArr addObject:dotLabel];
        
        // 输入框
        YMUITextField *textField = [[YMUITextField alloc] init];
        [bgView addSubview:textField];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.ym_delegate = self;
        textField.tag = i;
        textField.tintColor = [UIColor colorWithHexString:@"ff3d3d"];
        textField.frame = CGRectMake(0, 0, bgView.width, bgView.height);
        textField.backgroundColor = [UIColor whiteColor];
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [YMUICommonUsedTools configPropertyWithTextField:textField textFont:22 textColor:[UIColor clearColor] textPlaceHolder:@"" textPlaceHolderFont:22 textPlaceHolderTextColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
        [self.textFieldArr addObject:textField];
        
        if (i==0) {
            [textField becomeFirstResponder];
        }
    }
}

- (void)tapGest:(UITapGestureRecognizer *)tap
{
    UITextField *textField = self.textFieldArr[tap.view.tag];
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self obtainPswStr];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.lastStr = textField.text;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.lastStr = textField.text;
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text length]>0) {
        NSString *nowStr = [textField.text substringFromIndex:[self.lastStr length]];
        textField.text = nowStr;
        UILabel *dotLabel = self.dotLabelArr[textField.tag];
        UIView *bgView = self.bgViewArr[textField.tag];
        [bgView bringSubviewToFront:dotLabel];
    }
    if ([textField.text length]==1) {
        if (textField.tag==self.textFieldArr.count-1) {
            [textField resignFirstResponder];
            [self obtainPswStr];
        } else {
            UITextField *tField = self.textFieldArr[textField.tag+1];
            [tField becomeFirstResponder];
        }
    }
    
    CGFloat maxLength=1;
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:maxLength];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)ymTextFieldDeleteBackward:(YMUITextField *)textField
{
    UITextField *textF = self.textFieldArr[textField.tag];
    UIView *bgView = self.bgViewArr[textField.tag];
    [bgView bringSubviewToFront:textF];
    if (textField.tag>0) {
        UITextField *tField = self.textFieldArr[textField.tag-1];
        [tField becomeFirstResponder];
    }
}
#pragma mark -- 获取密码
- (void)obtainPswStr
{
    NSString *pswStr = @"";
    for (int i = 0; i < self.textFieldArr.count; i++) {
        UITextField *tf = self.textFieldArr[i];
        pswStr = [pswStr stringByAppendingString:tf.text];
    }
    self.pswStr = pswStr;
    if (self.inputSuccessBlock) {
        self.inputSuccessBlock(pswStr);
    }
}
#pragma mark -- getter
- (NSMutableArray<UIView *> *)bgViewArr
{
    if (_bgViewArr==nil) {
        _bgViewArr = [[NSMutableArray alloc] init];
    }
    return _bgViewArr;
}

- (NSMutableArray<UILabel *> *)dotLabelArr
{
    if (_dotLabelArr==nil) {
        _dotLabelArr = [[NSMutableArray alloc] init];
    }
    return _dotLabelArr;
}

- (NSMutableArray<UITextField *> *)textFieldArr
{
    if (_textFieldArr==nil) {
        _textFieldArr = [[NSMutableArray alloc] init];
    }
    return _textFieldArr;
}
@end
