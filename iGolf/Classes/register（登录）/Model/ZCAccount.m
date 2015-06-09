//
//  ZCAccount.m
//  我爱高尔夫
//
//  Created by hh on 15/2/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//账号模型

#import "ZCAccount.h"

@implementation ZCAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.nickname=dict[@"nickname"];
        self.token=dict[@"token"];
        self.type=dict[@"type"];
        self.uuid=dict[@"uuid"];
        self.phone=dict[@"phone"];
        
        if ([self _valueOrNil:dict[@"portrait"]]==nil) {
            self.portrait=dict[@"portrait"];
        }else
        {
        self.portrait=dict[@"portrait"][@"url"];
        }
    }
    return self;


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
/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.token = [decoder decodeObjectForKey:@"token"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.uuid = [decoder decodeObjectForKey:@"uuid"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.phone=[decoder decodeObjectForKey:@"phone"];
        self.portrait=[decoder decodeObjectForKey:@"portrait"];
        
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.uuid forKey:@"uuid"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.portrait forKey:@"portrait"];
    
}





@end
