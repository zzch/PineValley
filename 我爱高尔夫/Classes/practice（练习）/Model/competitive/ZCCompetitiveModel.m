//
//  ZCCompetitiveModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/24.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCompetitiveModel.h"
#import "ZCscorecard.h"
@implementation ZCCompetitiveModel
+ (instancetype)competitiveModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.uuid=dict[@"uuid"];
        self.type=dict[@"type"];
        NSDictionary *scorecards=dict[@"scorecards"];
        self.scorecards=[NSMutableArray array];
        for (NSDictionary *secorecar in scorecards) {
            
            
            NSString *address = secorecar[@"distance_from_hole_to_tee_box"];
            NSString *name = secorecar[@"tee_box_color"];
            NSString *uuid = secorecar[@"par"];
            NSLog(@"%@--,%@--,%@--",address,name,uuid);
            ZCLog(@"%@",secorecar);
            ZCscorecard *scorecard=[ZCscorecard scorecardsWithDict:secorecar];
            [self.scorecards addObject:scorecard];
            
            //            ZCLog(@"%@",Scorecards.tee_box_color);
            //            ZCLog(@"%@",Scorecards.uuid);
            
        }
        //        ZCLog(@"%lu",self.scorecards.count);
        //        ZCscorecard *aa=self.scorecards[3];
        //         ZCLog(@"%@",aa.number);
        
        
    }
    
    return self;
}


@end
