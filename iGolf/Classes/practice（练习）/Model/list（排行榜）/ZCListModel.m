//
//  ZCListModel.m
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCListModel.h"

@implementation ZCListModel
+ (instancetype)listModelWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{

    if (self=[super init]) {
        
        self.position=dict[@"position"];
        self.recorded_scorecards_count=dict[@"recorded_scorecards_count"];
        self.isself=dict[@"self"];
        self.total=dict[@"total"];
        self.uuid=dict[@"uuid"];
        self.user=[ZCUserModel userModelWithDict:dict[@"user"]];
        
        
        
    }
    return self;
}
@end
