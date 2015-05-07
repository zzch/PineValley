//
//  ZCCityStadium.m
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCityStadium.h"

@implementation ZCCityStadium
+(instancetype)coursesWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        self.address=dict[@"address"];
        
    }
    return self;

}



@end
