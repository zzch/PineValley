//
//  ZCCoursesModel.m
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCCoursesModel.h"

@implementation ZCCoursesModel
+ (instancetype)coursesModelWithDict:(NSDictionary *)dict
{
    ZCLog(@"%@",dict);
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.holes_count=[dict[@"holes_count"] intValue];
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        ZCLog( @"%@",dict);
        ZCLog( @"%@",dict[@"tee_boxes"]);
        self.tee_boxes=[NSMutableArray array];
        
        for (NSString *dx in dict[@"tee_boxes"]) {
            
            
            ZCLog(@"%@",dx);
            [self.tee_boxes addObject:dx];
            
        }
        
//        for (NSDictionary *dict in dict[@"tee_boxes"]) {
//            [self.tee_boxes addObject:dict];
//        }
//        
    }
    return self;
}

@end
