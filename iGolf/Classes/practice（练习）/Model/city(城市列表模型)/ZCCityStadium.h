//
//  ZCCityStadium.h
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCityStadium : NSObject
//球场信息编号
@property (nonatomic, copy) NSString *uuid;
//球场名字
@property (nonatomic, copy) NSString *name;
//球场地址
@property (nonatomic, copy) NSString *address;
+ (instancetype)coursesWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
