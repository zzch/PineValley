//
//  ZCUserModel.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCUserModel.h"

@implementation ZCUserModel
+ (instancetype)userModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        ZCLog( @"%@",dict[@"nickname"]);
        
        self.nickname=[NSString stringWithFormat:@"%@",dict[@"nickname"]];
        
        
        
        
        if ([dict[@"portrait"] isKindOfClass:[NSNull class]]) {
            self.portrait=dict[@"portrait"];
        }else
        {
          self.portrait=dict[@"portrait"][@"url"];
        }
        
    }
    return self;
}

@end
