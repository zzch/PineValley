//
//  ZCHistoricalEventsModel.m
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHistoricalEventsModel.h"

@implementation ZCHistoricalEventsModel
+ (instancetype)historicalEventsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.uuid=dict[@"uuid"];
        self.players_count=dict[@"players_count"];
        self.started_at=[dict[@"started_at"] longValue];
        self.player=[ZCPlayer playerModelWithDict:dict[@"player"]] ;
        self.venue=[ZCVenueModel venueModelWithDict:dict[@"venue"]];
    }
    return self;
}

@end
