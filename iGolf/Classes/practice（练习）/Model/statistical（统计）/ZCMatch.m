//
//  ZCMatch.m
//  iGolf
//
//  Created by hh on 15/6/2.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCMatch.h"

@implementation ZCMatch
+ (instancetype)matchWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.played_at=[dict[@"played_at"] longValue];
        self.name=dict[@"venue"][@"name"];
    }
    return self;
}
@end
