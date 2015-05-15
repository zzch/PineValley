//
//  ZCTee_boxes.m
//  iGolf
//
//  Created by hh on 15/5/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCTee_boxes.h"

@implementation ZCTee_boxes
+ (instancetype)tee_boxesWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}




- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.color=dict[@"color"];
        self.distance_from_hole=dict[@"distance_from_hole"];
        self.used=dict[@"used"];
    }
    return self;
}
@end
