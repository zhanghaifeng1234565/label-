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
#import <MapKit/MapKit.h>

@interface YMUISearchViewController ()

/** 搜索 */
@property (nonatomic, strong) YMUISearchBar *searchBar;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, copy) NSString *destination;

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
        _searchBar.baseBackgroundImage = [[UIImage imageNamed:@"top_navigation_bg_6p"] imageByScrollAlpha:1.0f];
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
    [self thirdMapRoute];
}

//导航只需要目的地经纬度，endLocation为纬度、经度的数组
-(void)doNavigationWithEndLocation:(NSArray *)endLocation
{
    
    //NSArray * endLocation = [NSArray arrayWithObjects:@"26.08",@"119.28", nil];
    
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"导航功能",@"nav123456",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",@"导航测试",@"nav123456",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    
    //选择
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSInteger index = maps.count;
    
    for (int i = 0; i < index; i++) {
        
        NSString * title = maps[i][@"title"];
        
        //苹果原生地图方法
        if (i == 0) {
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMap];
            }];
            [alert addAction:action];
            
            continue;
        }
        
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *urlString = maps[i][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        
        [alert addAction:action];
        
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

//苹果地图
- (void)navAppleMap
{
    //    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.destinationCoordinate2D];
    
    //终点坐标
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(26.08, 119.28);
    
    
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    
    
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    //第二个，都可以用
    //    NSDictionary * dic = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]};
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
    
    
}

- (void)thirdMapRoute
{
    self.lat = 22.5369144502;
    self.lon = 113.9226940117;
    self.destination = @"南山文体中心";
    //终点坐标
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.lat, self.lon);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //当前位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        //传入目的地，会显示在苹果自带地图上面目的地一栏
        toLocation.name = self.destination;
        //导航方式选择walking
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    
    [alert addAction:action];
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=walking&coord_type=gcj02",coordinate.latitude, coordinate.longitude,self.destination] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=2",@"刷哪儿",coordinate.latitude,coordinate.longitude,self.destination] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}
@end
