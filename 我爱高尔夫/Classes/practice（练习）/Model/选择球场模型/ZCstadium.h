//
//  ZCstadium.h
//  我爱高尔夫
//
//  Created by hh on 15/2/6.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//球场信息模型

@interface ZCstadium : NSObject
//球场信息编号
@property (nonatomic, copy) NSString *uuid;
//球场名字
@property (nonatomic, copy) NSString *name;
//球场地址
@property (nonatomic, copy) NSString *address;
//现距离离球场距离
@property (nonatomic, assign) float distance;

+ (instancetype)stadiumWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
