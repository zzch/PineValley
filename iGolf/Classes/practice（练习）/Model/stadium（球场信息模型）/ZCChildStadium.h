//
//  ZCChildStadium.h
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCChildStadium : NSObject
/**
 *  球场ID
 */
@property (nonatomic, copy) NSString *uuid;
/**
 *  子球场名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  球场洞数
 */
@property (nonatomic, assign) int holes_count;
/**
 *  球洞
 */
@property (nonatomic, strong) NSMutableArray *tee_boxes;


+ (instancetype)childStadiumWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
