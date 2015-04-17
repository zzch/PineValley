//
//  ZCWedgeModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCWedgeModel.h"

@implementation ZCWedgeModel
+ (instancetype)wedgeModelWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.distance_from_hole=dict[@"distance_from_hole"];
        self.putt_length=dict[@"putt_length"];
        
    }
    return self;
}
@end
