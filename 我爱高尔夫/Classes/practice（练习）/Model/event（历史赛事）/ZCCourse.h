//
//  ZCCourse.h
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCourse : NSObject
/**
 *  球场的uuid
 */
@property (nonatomic, copy) NSString *uuid;
/**
 *  球场的名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  球场的地址
 */
@property (nonatomic, copy) NSString *address;


+ (instancetype)courseWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
