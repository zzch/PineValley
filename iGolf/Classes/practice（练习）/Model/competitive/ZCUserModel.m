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



- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        ZCLog( @"%@",dict[@"nickname"]);
        
        self.nickname=[NSString stringWithFormat:@"%@",dict[@"nickname"]];
        
        
        
        
        //if ([dict[@"portrait"] isKindOfClass:[NSNull class]])
            if ([self _valueOrNil:dict[@"portrait"]]==nil)

            
        {
            self.portrait=dict[@"portrait"];
        }else
        {
          self.portrait=dict[@"portrait"][@"url"];
        }
        
    }
    return self;
}

@end
