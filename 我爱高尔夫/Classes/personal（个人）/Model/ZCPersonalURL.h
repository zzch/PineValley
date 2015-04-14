//
//  ZCPersonalURL.h
//  我爱高尔夫
//
//  Created by hh on 15/4/10.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPersonalURL : NSObject
/**
 url
 */
@property(nonatomic,copy)NSString *url;


+ (instancetype)personalURLWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
