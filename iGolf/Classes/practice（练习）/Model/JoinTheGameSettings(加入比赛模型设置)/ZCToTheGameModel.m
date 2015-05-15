//
//  ZCToTheGameModel.m
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCToTheGameModel.h"

@implementation ZCToTheGameModel
+ (instancetype)toTheGameModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        
        ZCLog(@"%@",dict[@"owner"]);
        ZCLog(@"%@",dict[@"venue"]);
        self.owner=[ZCCwnerModel cwnerModelWithDict:dict[@"owner"]];
        self.venue=[ZCVenue venueModelWithDict:dict[@"venue"]];
        self.started_at=[dict[@"started_at"] longValue];
        
    }
    return self;
    
}

@end
