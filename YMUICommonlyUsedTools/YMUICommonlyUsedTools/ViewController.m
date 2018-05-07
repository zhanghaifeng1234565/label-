//
//  ViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "YMUICommonUsedTools.h"
#import "YMUIPlaceholderTextView.h"
#import "UIScrollView+UITouch.h"

#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define NavBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
static CGFloat font = 22;

@interface ViewController ()<UITextFieldDelegate, UITextViewDelegate>

/** 背景滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 设置行间距的 label */
@property (nonatomic, strong) UILabel *testLabel;
/** 带有占位文字和行间距的输入框 */
@property (nonatomic, strong) YMUIPlaceholderTextView *textView;
/** 带有占位文字的输入框 */
@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation ViewController

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
    
    // 添加背景滚动视图
    [self.view addSubview:self.scrollView];
    
    // 添加设置行间距的 label
    [self.scrollView addSubview:self.testLabel];
    [YMUICommonUsedTools configPropertyWithLabel:self.testLabel font:font textColor:[UIColor blueColor] textAlignment:NSTextAlignmentLeft numberOfLine:0];
    [YMUICommonUsedTools configPropertyWithLabel:self.testLabel font:font lineSpace:5 maxWidth:MainScreenWidth-30];
    CGFloat labelHeight = [YMUICommonUsedTools getHeightWithLabel:self.testLabel font:font lineSpace:5 maxWidth:MainScreenWidth-30];
    CGFloat labelWidth = [YMUICommonUsedTools getWidthWithLabel:self.testLabel font:font];
    
    CGRect labelFrame = self.testLabel.frame;
    labelFrame.size.height = labelHeight;
    labelFrame.size.width = labelWidth>MainScreenWidth-30?MainScreenWidth-30:labelWidth;
    self.testLabel.frame = labelFrame;
    
    [YMUICommonUsedTools configPropertyWithView:self.testLabel backgroundColor:[UIColor yellowColor] cornerRadius:2.0f borderWidth:0.5f borderColor:[UIColor greenColor]];
    
    // 添加带有占位文字和行间距的输入框
    [self.scrollView addSubview:self.textView];
    [YMUICommonUsedTools configPropertyWithView:self.textView backgroundColor:[UIColor groupTableViewBackgroundColor] cornerRadius:4.0f borderWidth:0.5f borderColor:[UIColor blueColor]];
    
    // 添加带有占位文字的输入框
    [self.scrollView addSubview:self.textFiled];
    [YMUICommonUsedTools configPropertyWithTextField:self.textFiled textFont:18 textColor:[UIColor blackColor] textPlaceHolder:@"我是占位 textFiled" textPlaceHolderFont:18 textPlaceHolderTextColor:[UIColor blueColor] textAlignment:NSTextAlignmentCenter];
    [YMUICommonUsedTools configPropertyWithView:self.textFiled backgroundColor:[UIColor groupTableViewBackgroundColor] cornerRadius:4.0f borderWidth:0.5f borderColor:[UIColor blueColor]];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.textFiled.frame.origin.y+self.textFiled.frame.size.height+30);
}
#pragma mark -- textFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{ // 限制输入字数
    
    CGFloat maxLength = 20;
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
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"☻"]) {
        return NO;
    }
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 100) {
        textView.text = [textView.text substringToIndex:100];
    }
}
#pragma mark -- getter
- (UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-NavBarHeight)];
    }
    return _scrollView;
}

- (UILabel *)testLabel
{
    if (_testLabel==nil) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, MainScreenWidth-30, 17)];
        _testLabel.text = @"费拉嘉陵江法兰克阿里客服afjssjflj";
        _testLabel.backgroundColor = [UIColor magentaColor];
    }
    return _testLabel;
}

- (YMUIPlaceholderTextView *)textView
{
    if (_textView==nil) {
        _textView = [[YMUIPlaceholderTextView alloc] initWithFrame:CGRectMake(15, self.testLabel.frame.origin.y+self.testLabel.frame.size.height+20, MainScreenWidth-30, 100)];
        _textView.delegate = self;
        _textView.contentInset = UIEdgeInsetsMake(3, 0, 10, 0);
        [YMUICommonUsedTools configPropertyWithTextView:self.textView textFont:15 textColor:[UIColor blackColor] lineSpace:5.0f textPlaceHolder:@"我是 textView" textPlaceHolderFont:15 textPlaceHolderTextColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft];
        _textView.text = @"就索拉卡计费拉嘉陵江法兰克阿里客服afjssjflj, 设计费垃圾埃里克计费索拉卡计费历史记录方式家乐福就索拉卡计费拉嘉陵江法兰克阿里客服afjssjflj";
    }
    return _textView;
}

- (UITextField *)textFiled
{
    if (_textFiled==nil) {
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(15, self.textView.frame.origin.y+self.textView.frame.size.height+20, MainScreenWidth-30, 48)];
        _textFiled.delegate = self;
        _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textFiled;
}
#pragma mark - KeyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect rect = self.scrollView.frame;
    rect.size.height = MainScreenHeight-kbSize.height;
    self.scrollView.frame = rect;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect rect = self.scrollView.frame;
    rect.size.height = MainScreenHeight-NavBarHeight;
    self.scrollView.frame = rect;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.scrollView endEditing:YES];
}
@end
