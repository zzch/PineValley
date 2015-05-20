//
//  ZCViewTheResultsModel.m
//  iGolf
//
//  Created by hh on 15/5/19.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCViewTheResultsModel.h"

@implementation ZCViewTheResultsModel

+ (instancetype)viewTheResultsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.uuid=dict[@"uuid"];
        self.position=dict[@"position"];
        self.recorded_scorecards_count=dict[@"recorded_scorecards_count"];
        self.strokes=dict[@"strokes"];
        self.total=dict[@"total"];
        self.user=[ZCUserModel userModelWithDict:dict[@"user"]];
        self.scorecards=[ZCStatisticalScorecard statisticalScorecardWithDict:dict[@"scorecards"]];
        
    }

    return self;
}


@end
