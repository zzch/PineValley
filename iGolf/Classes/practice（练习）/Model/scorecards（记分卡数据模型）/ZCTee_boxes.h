//
//  ZCTee_boxes.h
//  iGolf
//
//  Created by hh on 15/5/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTee_boxes : NSObject
/**
 *  T台的颜色
 */
@property (nonatomic, copy) NSString *color;
/**
 *  距离球洞的码数
 */
@property (nonatomic, copy) NSString *distance_from_hole;

/**
 *  用户选择的T台
 */
@property (nonatomic, copy) NSString *used;



+ (instancetype)tee_boxesWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
