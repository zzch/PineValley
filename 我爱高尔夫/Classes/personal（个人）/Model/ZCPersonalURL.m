//
//  ZCPersonalURL.m
//  我爱高尔夫
//
//  Created by hh on 15/4/10.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalURL.h"

@implementation ZCPersonalURL

+ (instancetype)personalURLWithDict:(NSDictionary *)dict
{


    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.url=dict[@"url"];
        
    }
    return self;
}


@end
