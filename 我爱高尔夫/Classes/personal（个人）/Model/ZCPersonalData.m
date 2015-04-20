//
//  ZCPersonalData.m
//  我爱高尔夫
//
//  Created by hh on 15/4/10.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalData.h"

@implementation ZCPersonalData


+ (instancetype)personalDataWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
//        if (dict[@"birthday"] is) {
//            <#statements#>
//        }
        self.birthday=[dict[@"birthday"] longValue] ;
        self.desc=dict[@"description"];
        self.gender=dict[@"gender"];
        self.handicap=dict[@"handicap"];
        self.last_signed_in_at=dict[@"last_signed_in_at"];
        self.signed_up_at=dict[@"signed_up_at"];
        self.portrait=dict[@"portrait"];
        
        
    }
    return self;

}


@end
