//
//  ZCStatisticalScorecard.m
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStatisticalScorecard.h"

@implementation ZCStatisticalScorecard
+ (instancetype)statisticalScorecardWithDict:(NSDictionary *)dict
{
    
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
       
  
        self.par=[NSMutableArray array];
        self.par=dict[@"par"];
        
        ZCLog(@"%@",self.par );
        self.score=[NSMutableArray array];
        self.score=dict[@"score"];

        ZCLog(@"%@",self.score);

        self.status=[NSMutableArray array];
        self.status=dict[@"status"];

        
        
    }
    return self;
    
}
@end
