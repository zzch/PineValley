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
        
         NSDictionary *groups = dict[@"groups"];
        self.groups=[NSMutableArray array];
        for (NSDictionary *group in groups) {
            ZCChildStadium *childStadium=[ZCChildStadium childStadiumWithDict:group];
            [self.groups addObject:childStadium];
        }
        
//         ZCLog(@"---groups---%zd",self.groups.count);
//        ZCChildStadium *aa=self.groups[3];
//         ZCLog(@"---groups---%@",aa.uuid);
        
        
    }
    return self;
}

@end
