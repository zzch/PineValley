//
//  ZCWedgeModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCWedgeModel : NSObject
/**
 最远切杆距离
 */
@property(nonatomic,copy)NSString *distance_from_hole;
/**
 成功
 */
@property(nonatomic,copy)NSString *putt_length;


+ (instancetype)wedgeModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
