//
//  ZCAccount.h
//  我爱高尔夫
//
//  Created by hh on 15/2/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAccount : NSObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *phone;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
