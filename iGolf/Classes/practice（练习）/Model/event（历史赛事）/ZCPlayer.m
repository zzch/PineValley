//
//  ZCPlayer.m
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCPlayer.h"

@implementation ZCPlayer
+ (instancetype)playerModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self=[super init]) {
        self.recorded_scorecards_count=dict[@"recorded_scorecards_count"];
        self.scoring_type=dict[@"scoring_type"];
        self.strokes=dict[@"strokes"];
        
        
        
    }
    return self;
}

@end
