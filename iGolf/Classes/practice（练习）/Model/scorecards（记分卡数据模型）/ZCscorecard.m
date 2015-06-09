//
//  ZCscorecard.m
//  我爱高尔夫
//
//  Created by hh on 15/3/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCscorecard.h"

@implementation ZCscorecard
+ (instancetype)scorecardsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.uuid=dict[@"uuid"];
        self.number=dict[@"number"];
        self.par=dict[@"par"];
        self.score=dict[@"score"];
        self.putts=dict[@"putts"];
        self.penalties=dict[@"penalties"];
         self.driving_distance=dict[@"driving_distance"];
         self.direction=dict[@"direction"];
        self.distance_from_hole=dict[@"distance_from_hole"];
        self.tee_boxes=[NSMutableArray array];
        
        NSDictionary *tee_boxes=dict[@"tee_boxes"];
        
        for (NSDictionary *dict in tee_boxes) {
            
            ZCTee_boxes *tee_box=[ZCTee_boxes tee_boxesWithDict:dict];
            
            [self.tee_boxes addObject:tee_box];
            
            
        }
        
        
        
        
        
    }
    return self;
    
}


@end
