//
//  ZCCueMode.m
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCueMode.h"

@implementation ZCCueMode

+ (instancetype)cueModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.uses=dict[@"uses"];
        self.average_length=dict[@"average_length"];
        self.minimum_length=dict[@"minimum_length"];
        self.maximum_length=dict[@"maximum_length"];
        self.less_than_average_length=dict[@"less_than_average_length"];
        self.greater_than_average_length=dict[@"greater_than_average_length"];
    }
    return self;
}


@end
