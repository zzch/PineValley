//
//  ZCVenueModel.h
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCVenueModel : NSObject
/**
 *  球场名字
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)venueModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
