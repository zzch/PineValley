//
//  ZCAthleticEventsModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAthleticEventsModel.h"
#import "ZCUserModel.h"
@implementation ZCAthleticEventsModel


+ (instancetype)athleticEventsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.name=dict[@"name"];
        self.password=dict[@"password"];
        self.players_count=dict[@"players_count"];
        self.rule=dict[@"rule"];
        self.started_at=dict[@"started_at"];
        self.uuid=dict[@"uuid"];
        self.user=[ZCUserModel userModelWithDict:dict[@"user"]];
        
        
        NSDictionary *courses = dict[@"courses"];
        self.courses=[NSMutableArray array];
        for (NSDictionary *course in courses) {
            ZCChildStadium *childStadium=[ZCChildStadium childStadiumWithDict:course];
            [self.courses addObject:childStadium];
        }
        
//
//        ZCChildStadium *aa=self.courses[1];
//        ZCLog(@"%@",aa.tee_boxes[1]);
        
    }
    return self;
}

@end
