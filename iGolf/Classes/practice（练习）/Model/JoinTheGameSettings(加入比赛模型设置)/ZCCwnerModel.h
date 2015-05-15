//
//  ZCCwnerModel.h
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCwnerModel : NSObject
/**
 *  玩家的名字
 */
@property(nonatomic,copy)NSString *nickname;
/**
 *  头像地址
 */
@property(nonatomic,copy)NSString *portrait;

///**
// *  头像地址
// */
//@property(nonatomic,copy)NSString *portrait;



+ (instancetype)cwnerModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
