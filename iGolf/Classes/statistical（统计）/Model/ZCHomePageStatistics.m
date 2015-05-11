//
//  ZCHomePageStatistics.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCHomePageStatistics.h"

@implementation ZCHomePageStatistics

+ (instancetype)homePageStatisticsWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
         self.average_score=dict[@"average_score"];
         self.best_score=dict[@"best_score"];
         self.birdie=dict[@"birdie"];
         self.bogey=dict[@"bogey"];
         self.eagle=dict[@"eagle"];
         self.double_eagle=dict[@"double_eagle"];
         self.finished_matches_count=dict[@"finished_matches_count"];
         self.handicap=dict[@"handicap"];
         self.par=dict[@"par"];
         self.rank=dict[@"rank"];
         self.total_matches_count=dict[@"total_matches_count"];
         self.double_bogey=dict[@"double_bogey"];
        
        
    }
    return self;
}


@end
