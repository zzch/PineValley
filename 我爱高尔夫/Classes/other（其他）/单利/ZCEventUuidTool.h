//
//  ZCEventUuidTool.h
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCEventUuidTool : NSObject
+ (instancetype)sharedEventUuidTool;
@property (nonatomic, copy) NSString *uuid;
//是专业还是简单
@property (nonatomic, copy) NSString *scoring;

@end
