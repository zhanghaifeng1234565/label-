//
//  YMPreferencesStore.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPreferencesStore.h"

@implementation YMPreferencesStore
#pragma mark -- 存储某个对象
- (void)ymPreferencesStoreObject:(id)object key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
 #pragma mark -- 移除某个对象
- (void)ymPreferencesStoreRemoveObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
