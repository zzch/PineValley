//
//  ZCCity.h
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCity : NSObject
/**
 *  省份名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  该省份下球场名称
 */
@property (nonatomic, strong) NSMutableArray *venues;

+ (instancetype)citysWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
