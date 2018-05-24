//
//  YMNSKeyedArchiverStore.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMNSKeyedArchiverStore : NSObject<NSCoding>

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 年龄 */
@property (nonatomic, copy) NSString *age;


/**
 自定义的归档保存数据的方法

 @param object 保存对象
 @param filePath 文件路径
 */
+ (void)saveObject:(YMNSKeyedArchiverStore *)object path:(NSString *)filePath;

/**
 自定义的读取沙盒中解档出的数据

 @param filePath 文件路径
 @return 文件
 */
+ (YMNSKeyedArchiverStore *)getObjectWithPath:(NSString *)filePath;


/**
 清除指定目录下的文件缓存

 @param fiePath  文件路径
 */
+ (void)clearFilePath:(NSString *)fiePath;
@end
