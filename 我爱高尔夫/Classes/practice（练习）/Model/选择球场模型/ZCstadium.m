//
//  ZCstadium.m
//  我爱高尔夫
//
//  Created by hh on 15/2/6.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
// 球场信息模型

#import "ZCstadium.h"

@implementation ZCstadium
+ (instancetype)stadiumWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
       // [self setValuesForKeysWithDictionary:dict];
        
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        self.address=dict[@"address"];
        self.distance=[dict[@"distance"] floatValue];
        self.holes_count=dict[@"holes_count"];
        
        
    }
    return self;


}
@end
