//
//  ZCPersonalData.h
//  我爱高尔夫
//
//  Created by hh on 15/4/10.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPersonalURL.h"
@interface ZCPersonalData : NSObject
/**
 生日
 */
@property(nonatomic,assign)long birthday;

/**
 签名
 */
@property(nonatomic,copy)NSString *desc;
/**
性别
 */
@property(nonatomic,copy)NSString *gender;

/**
 
 */
@property(nonatomic,copy)NSString *handicap;

/**

 */
@property(nonatomic,copy)NSString *last_signed_in_at;

/**

 */
@property(nonatomic,copy)NSString *signed_up_at;

/**
 地址
 */
@property(nonatomic,copy)NSString *portrait;

+ (instancetype)personalDataWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
