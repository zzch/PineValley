//
//  ZCSelectTheDisplay.m
//  我爱高尔夫
//
//  Created by hh on 15/4/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSelectTheDisplay.h"

@implementation ZCSelectTheDisplay
+ (instancetype)selectTheDisplayWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        //禁止使用KVC
        self.distance_from_hole=dict[@"distance_from_hole"];
        self.point_of_fall=dict[@"point_of_fall"];
        self.penalties=dict[@"penalties"];
        self.sequence=dict[@"sequence"];
        self.club=dict[@"club"];
        self.uuid=dict[@"uuid"];



        
    }
    return self;
}
@end
