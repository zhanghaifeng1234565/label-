//
//  EncodeViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "EncodeViewController.h"

@interface EncodeViewController ()<UITextFieldDelegate>

/** 背景滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 姓名 */
@property (nonatomic, strong) YMUITextField *nameTextField;
/** 年龄 */
@property (nonatomic, strong) YMUITextField *ageTextField;
/** 保存按钮 */
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation EncodeViewController
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
#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 加载视图
    [self loadSubviewUI];
    // 配置属性
    [self configProperty];
}
#pragma mark -- 加载视图
- (void)loadSubviewUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.nameTextField];
    [self.scrollView addSubview:self.ageTextField];
    [self.scrollView addSubview:self.saveBtn];
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.saveBtn.bottom+30);
}
#pragma mark -- 配置属性
- (void)configProperty
{
    // 名字
    [YMUICommonUsedTools configPropertyWithTextField:self.nameTextField textFont:18 textColor:[UIColor blackColor] textPlaceHolder:@"请输入姓名" textPlaceHolderFont:18 textPlaceHolderTextColor:[UIColor blueColor] textAlignment:NSTextAlignmentCenter];
    [YMUICommonUsedTools configPropertyWithView:self.nameTextField backgroundColor:[UIColor groupTableViewBackgroundColor] cornerRadius:4.0f borderWidth:0.5f borderColor:[UIColor blueColor]];
    
    // 年龄
    [YMUICommonUsedTools configPropertyWithTextField:self.ageTextField textFont:18 textColor:[UIColor blackColor] textPlaceHolder:@"请输入年龄" textPlaceHolderFont:18 textPlaceHolderTextColor:[UIColor blueColor] textAlignment:NSTextAlignmentCenter];
    [YMUICommonUsedTools configPropertyWithView:self.ageTextField backgroundColor:[UIColor groupTableViewBackgroundColor] cornerRadius:4.0f borderWidth:0.5f borderColor:[UIColor blueColor]];
    
    [YMUICommonUsedTools configPropertyWithButton:self.saveBtn title:@"保存" titleColor:[UIColor brownColor] titleLabelFont:17];
    [YMUICommonUsedTools configPropertyWithView:self.saveBtn backgroundColor:[UIColor magentaColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    
    //解档拿到数据
    YMNSKeyedArchiverStore *store = [YMNSKeyedArchiverStore getObjectWithPath:@"personFile.data"];
    //打印出结果，证明归档解档成功
    self.nameTextField.text = store.name;
    self.ageTextField.text = store.age;
}
#pragma mark -- 保存按钮点击调用
- (void)saveBtnClick
{
    if ([self.nameTextField.text isEqualToString:@""]) {
        [YMBlackSmallAlert showAlertWithMessage:@"请输入姓名" time:2.0f];
        return;
    }
    
    if ([self.ageTextField.text isEqualToString:@""]) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入年龄" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    
    if (self.encodeViewControllerBlcok) {
        self.encodeViewControllerBlcok(@"解档");
    }
    
    YMNSKeyedArchiverStore *store = [[YMNSKeyedArchiverStore alloc] init];
    store.name = self.nameTextField.text;
    store.age = self.ageTextField.text;
    //归档保存数据
    [YMNSKeyedArchiverStore saveObject:store path:@"personFile.data"];
    [self.navigationController popViewControllerAnimated:YES];
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
{
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
#pragma mark -- getter
- (UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-NavBarHeight)];
    }
    return _scrollView;
}

- (YMUITextField *)nameTextField
{
    if (_nameTextField==nil) {
        _nameTextField = [[YMUITextField alloc] initWithFrame:CGRectMake(15, 50, MainScreenWidth-30, 48)];
        _nameTextField.delegate = self;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameTextField;
}

- (YMUITextField *)ageTextField
{
    if (_ageTextField==nil) {
        _ageTextField = [[YMUITextField alloc] initWithFrame:CGRectMake(15, self.nameTextField.bottom+15, MainScreenWidth-30, 48)];
        _ageTextField.delegate = self;
        _ageTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_ageTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _ageTextField;
}

- (UIButton *)saveBtn
{
    if (_saveBtn==nil) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, self.ageTextField.bottom+30, MainScreenWidth-30, 48)];
        [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
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
