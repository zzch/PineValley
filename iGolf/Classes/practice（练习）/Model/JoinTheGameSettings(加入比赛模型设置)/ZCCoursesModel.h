//
//  ZCCoursesModel.h
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCoursesModel : NSObject
/**
 *  子场名字
 */
@property(nonatomic,copy)NSString *name;

/**
 *  子场洞数
 */
@property(nonatomic,assign)int holes_count;
/**
 *  子场UUID
 */
@property(nonatomic,copy)NSString *uuid;
/**
 *  子场的T台
 */
@property(nonatomic,strong)NSMutableArray *tee_boxes;

+ (instancetype)coursesModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
