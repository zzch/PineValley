//
//  ZCResultsModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/21.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCResultsModel.h"

@implementation ZCResultsModel


+ (instancetype)resultsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.advantage_transformation=dict[@"advantage_transformation"];
        self.average_drive_length=dict[@"average_drive_length"];
        self.birdie=dict[@"birdie"];
        self.bogey=dict[@"bogey"];
        self.bounce=dict[@"bounce"];
        self.double_bogey=dict[@"double_bogey"];
        self.double_eagle=dict[@"double_eagle"];
        self.drive_fairways_hit=dict[@"drive_fairways_hit"];
        self.eagle=dict[@"eagle"];
        self.finished_count=dict[@"finished_count"];
        self.gir=dict[@"gir"];
        self.handicap=dict[@"handicap"];
        self.par=dict[@"par"];
        self.putts=dict[@"putts"];
        self.putts_per_gir=dict[@"putts_per_gir"];
        self.score=dict[@"score"];
        self.score_par_3=dict[@"score_par_3"];
        self.score_par_4=dict[@"score_par_4"];
        self.score_par_5=dict[@"score_par_5"];
        
    }
    return self;

}

@end
