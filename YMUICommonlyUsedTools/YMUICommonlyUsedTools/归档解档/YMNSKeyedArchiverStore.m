//
//  YMNSKeyedArchiverStore.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMNSKeyedArchiverStore.h"

@implementation YMNSKeyedArchiverStore
#pragma mark -- 归档，Key建议使用宏代替，这里就不使用了
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
}
#pragma mark -- 解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
    }
    return self;
}
#pragma mark -- 类方法，运用NSKeyedArchiver归档数据
+ (void)saveObject:(YMNSKeyedArchiverStore *)object path:(NSString *)filePath
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path=[docPath stringByAppendingPathComponent:filePath];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
#pragma mark -- 类方法，使用NSKeyedUnarchiver解档数据
+ (YMNSKeyedArchiverStore *)getObjectWithPath:(NSString *)filePath
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path=[docPath stringByAppendingPathComponent:filePath];
    YMNSKeyedArchiverStore *object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}
#pragma mark -- 清除指定目录下的文件
+ (void)clearFilePath:(NSString *)fiePath
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if ([p isEqualToString:fiePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    }
}
@end
