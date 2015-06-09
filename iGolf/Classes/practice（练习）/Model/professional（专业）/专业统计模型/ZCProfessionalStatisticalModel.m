//
//  ZCProfessionalStatisticalModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/13.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCProfessionalStatisticalModel.h"
#import "ZCMatch.h"
@implementation ZCProfessionalStatisticalModel

+ (instancetype)professionalStatisticalModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.scorecards=[ZCStatisticalScorecard statisticalScorecardWithDict:dict[@"scorecards"]];
        self.item_01=dict[@"item_01"];
        self.item_02=dict[@"item_02"];
        self.item_03=dict[@"item_03"];
        self.item_04=dict[@"item_04"];
        self.item_05=dict[@"item_05"];
        self.item_06=dict[@"item_06"];
        self.item_07=dict[@"item_07"];
        self.item_08=dict[@"item_08"];
        self.item_09=dict[@"item_09"];
        self.item_10=dict[@"item_10"];
         self.match=[ZCMatch matchWithDict:dict[@"match"]];
        
        
    }
    return self;
}

@end
