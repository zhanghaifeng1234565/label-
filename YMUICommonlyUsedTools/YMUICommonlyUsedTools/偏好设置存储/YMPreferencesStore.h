//
//  YMPreferencesStore.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 偏好存储 */
@interface YMPreferencesStore : NSObject

/**
 偏好存储某个对象方法

 @param object 存储对象
 @param key 存储键
 */
- (void)ymPreferencesStoreObject:(id)object key:(NSString *)key;

/**
 移除某个对象偏好存储

 @param key 移除键
 */
- (void)ymPreferencesStoreRemoveObjectForKey:(NSString *)key;

@end
