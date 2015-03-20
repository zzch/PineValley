//
//  ZCStadiumInformation.h
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCChildStadium.h"
@interface ZCStadiumInformation : NSObject
/**
 *  球场名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  球场集体信息模型
 */

@property (nonatomic, strong) NSMutableArray *courses;
+ (instancetype)stadiumInformationWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
