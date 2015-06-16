//
//  ZCPlayerModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/28.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPlayerModel.h"

@implementation ZCPlayerModel
+ (instancetype)playerModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
       
        
        self.position=dict[@"position"];
        self.recorded_scorecards_count=dict[@"recorded_scorecards_count"];
        self.scoring_type=dict[@"scoring_type"];
        self.strokes=dict[@"strokes"];
        self.total=dict[@"total"];
        self.owned=dict[@"owned"];
        
        self.user=[ZCUserModel userModelWithDict:dict[@"user"]];
        
        ZCLog(@"%@",dict[@"total"]);
        ZCLog(@"%@",dict[@"recorded_scorecards_count"]);
        ZCLog(@"%@",dict[@"strokes"]);
        ZCLog(@"%@",dict[@"scoring_type"]);
    }
    return self;

}
@end
