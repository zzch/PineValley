//
//  ZCMatch.h
//  iGolf
//
//  Created by hh on 15/6/2.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMatch : NSObject
/**
 *  时间
 */
@property(nonatomic,assign)long played_at;
/**
 *  时间
 */
@property(nonatomic,copy)NSString *name;

+ (instancetype)matchWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
