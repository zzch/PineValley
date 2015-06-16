//
//  ZCHistoryCoursesModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCHistoryCoursesModel.h"

@implementation ZCHistoryCoursesModel
+ (instancetype)historyCoursesWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{

    if (self=[super init]) {
        
        self.name=dict[@"name"];
        self.address=dict[@"address"];
        self.uuid=dict[@"uuid"];
        self.played_count=dict[@"played_count"];
    }
    return self;

}
@end
