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
{
    dispatch_source_t _timer;
}

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
    // 倒计时
    [self countdownCalcOverTime:@"30"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.payView endEditing:YES];
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
#pragma mark -- 倒计时剩余时间
-(void)countdownCalcOverTime:(NSString *)timeInterval
{
    if (_timer==0) {
        __block int timeout = [timeInterval intValue]; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = 0;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                } else {
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *resultTime_dayLabel = @"";
                        NSString *resultTime_hourLabel = @"";
                        NSString *resultTime_minuteLabel = @"";
                        NSString *resultTime_secondLabel = @"";
                        if (days==0) {
                            resultTime_dayLabel = @"";
                        }else{
                            resultTime_dayLabel = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours==0) {
                            resultTime_hourLabel = @"";
                        }else{
                            if (hours<10) {
                                resultTime_hourLabel = [NSString stringWithFormat:@"0%d时",hours];
                            }else{
                                resultTime_hourLabel = [NSString stringWithFormat:@"%d时",hours];
                            }
                        }
                        if (minute==0) {
                            resultTime_minuteLabel = [NSString stringWithFormat:@"0%d:",minute];
                        }else{
                            if (minute<10) {
                                resultTime_minuteLabel = [NSString stringWithFormat:@"0%d:",minute];
                            }else{
                                resultTime_minuteLabel = [NSString stringWithFormat:@"%d:",minute];
                            }
                        }
                        if (second==0) {
                            resultTime_secondLabel = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            if (second<10) {
                                resultTime_secondLabel = [NSString stringWithFormat:@"0%d",second];
                            }else{
                                resultTime_secondLabel = [NSString stringWithFormat:@"%d",second];
                            }
                        }
                        
                        self.title = [NSString stringWithFormat:@"剩余支付时间 %@%@%@%@",resultTime_dayLabel,resultTime_hourLabel,resultTime_minuteLabel,resultTime_secondLabel];
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
@end
