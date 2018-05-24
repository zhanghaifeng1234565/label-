//
//  YMNSKeyedArchiverStore.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/23.
//  Copyright © 2018年 iOS. All rights reserved.
//
/**
 Documents[NSDocumentDirectory]【iTunes 会备份该目录。一般用来存储需要持久化的数据】
 Library
    Caches[NSCachesDirectory]【缓存，iTunes 不会自动备份该目录。内存不足时会被清除，应用没有运行时可能会被清除。一般存储体积大、不需要备份的非重要信息】
    Preferences【iTunes 会备份该目录，可以来存储一些偏好设置】【可以使用 YMPreferencesStore】
 tmp[NSString *tmp= NSTemporaryDirectory()]【iTunes 不会备份这个目录，用来存储临时数据，应用退出时会清除该目录下载的数据】
 */

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
