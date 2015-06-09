//
//  ZCStatistical.m
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStatistical.h"
#import "ZCStatisticalScorecard.h"
#import "ZCMatch.h"
@implementation ZCStatistical

+ (instancetype)statisticalWithDict:(NSDictionary *)dict
{
    return [[self alloc ] initWithDict:dict];
    //ZCLog(@"%@",dict[@"net"]);
    

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self=[super init]) {
        
        self.penalties=dict[@"penalties"];
        self.score=dict[@"score"];
        self.net=dict[@"net"];
        self.putts=dict[@"putts"];
        
        self.advantage_transformation=dict[@"advantage_transformation"];
        self.average_drive_length=dict[@"average_drive_length"];
        self.birdie=dict[@"birdie"];
        self.bounce=dict[@"bounce"];
        self.double_bogey=dict[@"double_bogey"];
        self.double_eagle=dict[@"double_eagle"];
        self.drive_fairways_hit=dict[@"drive_fairways_hit"];
        self.eagle=dict[@"eagle"];
        self.gir=dict[@"gir"];
        self.longest_drive_length=dict[@"longest_drive_length"];
        self.par=dict[@"par"];
         self.putts_per_gir=dict[@"putts_per_gir"];
         self.score_par_3=dict[@"score_par_3"];
         self.score_par_4=dict[@"score_par_4"];
         self.score_par_5=dict[@"score_par_5"];
         self.scrambles=dict[@"scrambles"];
        self.bogey=dict[@"bogey"];
        self.match=[ZCMatch matchWithDict:dict[@"match"]];
        
        
        
        
        self.scorecards=[ZCStatisticalScorecard statisticalScorecardWithDict:dict[@"scorecards"]];
//        ZCLog(@"%@",self.putts);
        
    }
    return self;
}




@end
