//
//  ZCPlayerModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/28.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPlayerModel.h"

@implementation ZCPlayerModel
+ (instancetype)playerModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
       
        
        self.position=dict[@"position"];
        self.score=dict[@"score"];
        self.status=dict[@"status"];
        
        self.user=[ZCUserModel userModelWithDict:dict[@"user"]];
        
        
    }
    return self;

}
@end
