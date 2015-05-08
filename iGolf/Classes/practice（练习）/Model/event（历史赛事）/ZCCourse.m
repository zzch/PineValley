//
//  ZCCourse.m
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCourse.h"

@implementation ZCCourse


+ (instancetype)courseWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        //后台数据属性可能添加修改 禁止用KVC
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        self.address=dict[@"address"];
        
        
    }
    return self;
}



@end
