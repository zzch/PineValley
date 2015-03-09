//
//  ZCCity.m
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCity.h"
#import "ZCCityStadium.h"
@implementation ZCCity

+(instancetype)citysWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name=dict[@"name"];
        NSDictionary *courses = dict[@"courses"];
        self.courses = [NSMutableArray array];
        for (NSDictionary *course in courses) {
//            NSString *address = course[@"address"];
//            NSString *name = course[@"name"];
//            NSString *uuid = course[@"uuid"];
//            NSLog(@"%@--,%@--,%@--",address,name,uuid);
            
            ZCCityStadium *stadium = [ZCCityStadium coursesWithDict:course];
            [self.courses addObject:stadium];
        }
       // ZCLog(@"---courses---%zd",self.courses.count);
    }
    return self;
    
}

@end
