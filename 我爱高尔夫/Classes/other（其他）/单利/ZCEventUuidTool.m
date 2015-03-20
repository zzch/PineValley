//
//  ZCEventUuidTool.m
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCEventUuidTool.h"

@implementation ZCEventUuidTool

static ZCEventUuidTool *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    //    return nil;
    // 懒加载，不能保证多线程并发的实例化是唯一的
    // 加互斥锁，性能非常糟糕。苹果强烈不建议程序员使用！
    //    @synchronized(self) {
    //        if (_instance == nil) {
    //            _instance = [super allocWithZone:zone];
    //        }
    //    }
    // dispatch_once能够确保块代码中的操作只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // block中的代码只能被执行一次
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedEventUuidTool
{
    // 无论调用多少次类方法，对象只会被初始化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark - MRC相关方法
// 判断是否支持MRC
#if !__has_feature(objc_arc)
- (oneway void)release {}
- (id)retain { return _instance; }
- (id)autorelease { return _instance; }
- (NSUInteger)retainCount { return UINT_MAX; }
#endif

- (id)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
          
        });
    }
    return self;
}





@end
