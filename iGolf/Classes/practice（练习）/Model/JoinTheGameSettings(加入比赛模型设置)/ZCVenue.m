//
//  ZCVenue.m
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCVenue.h"
#import "ZCCoursesModel.h"
@implementation ZCVenue
+ (instancetype)venueModelWithDict:(NSDictionary *)dict
{
    
    
    ZCLog(@"%@",dict);
    
    return [[self alloc ] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        
        
        self.name=dict[@"name"];
        
        self.courses=[NSMutableArray array];
        
        ZCLog(@"%@",dict[@"courses"]);
        
        for (NSDictionary *dd in dict[@"courses"]) {
           
            ZCCoursesModel *Courses=[ZCCoursesModel coursesModelWithDict:dd];
             [self.courses addObject:Courses];
        }
        
        
        
//        for (NSDictionary *dict in dict[@"courses"]) {
//            ZCCoursesModel *Courses=[ZCCoursesModel coursesModelWithDict:dict];
//            [self.courses addObject:Courses];
//        }
        
        
    }
    return self;
}

@end
