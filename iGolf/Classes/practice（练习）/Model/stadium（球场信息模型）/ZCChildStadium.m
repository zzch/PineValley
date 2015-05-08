//
//  ZCChildStadium.m
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChildStadium.h"

@implementation ZCChildStadium

+ (instancetype)childStadiumWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
   
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    //ZCLog(@"%@",dict);
    if (self=[super init]) {
       
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        
        self.holes_count=[dict[@"holes_count"] intValue];
        
        self.tee_boxes=[NSMutableArray array];
        
        for (NSDictionary *box in dict[@"tee_boxes"]) {
            [self.tee_boxes addObject:box];
        }
        ZCLog(@"self.tee_boxes---%@",self.tee_boxes[0]);
    }
    return self;
}


@end
