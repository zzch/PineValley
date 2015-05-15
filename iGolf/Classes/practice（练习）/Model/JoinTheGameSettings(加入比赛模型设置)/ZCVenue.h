//
//  ZCVenue.h
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCVenue : NSObject
/**
 *  子场数据
 */
@property(nonatomic,strong) NSMutableArray *courses;
@property(nonatomic,copy) NSString *name;


+ (instancetype)venueModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
