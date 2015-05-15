//
//  ZCCwnerModel.m
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCCwnerModel.h"

@implementation ZCCwnerModel
+ (instancetype)cwnerModelWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
    
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        
        
        self.nickname=[NSString stringWithFormat:@"%@",dict[@"nickname"]];
        
         self.portrait=dict[@"portrait"][@"url"];
    }
    return self;
}


@end
