//
//  ZCVenueModel.m
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCVenueModel.h"

@implementation ZCVenueModel


+ (instancetype)venueModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
          
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
    }
    return self;
}

@end
