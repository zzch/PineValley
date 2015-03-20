//
//  ZCStatistical.m
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStatistical.h"
#import "ZCStatisticalScorecard.h"
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
        
        self.scorecards=[ZCStatisticalScorecard statisticalScorecardWithDict:dict[@"scorecards"]];
//        ZCLog(@"%@",self.putts);
        
    }
    return self;
}




@end
