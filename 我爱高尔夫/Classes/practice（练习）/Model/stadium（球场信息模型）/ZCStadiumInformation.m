//
//  ZCStadiumInformation.m
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStadiumInformation.h"

@implementation ZCStadiumInformation
+ (instancetype)stadiumInformationWithDict:(NSDictionary *)dict
{
   
    
    return [[self alloc] initWithDict:dict];
    
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        
         NSDictionary *courses = dict[@"courses"];
        self.courses=[NSMutableArray array];
        for (NSDictionary *course in courses) {
            ZCChildStadium *childStadium=[ZCChildStadium childStadiumWithDict:course];
            [self.courses addObject:childStadium];
        }
        
//         ZCLog(@"---groups---%zd",self.groups.count);
//        ZCChildStadium *aa=self.groups[3];
//         ZCLog(@"---groups---%@",aa.uuid);
        
        
    }
    return self;
}

@end
