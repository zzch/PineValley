//
//  ZCUserModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUserModel : NSObject
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



+ (instancetype)userModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
