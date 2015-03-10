//
//  ZCEvent.m
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCEvent.h"
#import "ZCCourse.h"
@implementation ZCEvent
+ (instancetype)eventWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        //后台数据属性可能添加修改 禁止用KVC
        self.uuid=dict[@"uuid"];
        self.type=dict[@"type"];
        self.score=dict[@"score"] ;
        self.recorded_scorecards_count=dict[@"recorded_scorecards_count"] ;
        
        self.started_at=dict[@"started_at"] ;
        
        self.course=[ZCCourse courseWithDict:dict[@"course"]];
        ZCLog(@"%@",self.course.name);
        
    }
    return self;
}
@end
