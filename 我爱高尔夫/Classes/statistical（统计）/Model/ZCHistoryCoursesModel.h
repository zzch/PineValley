//
//  ZCHistoryCoursesModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCHistoryCoursesModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *address;
//球场的uuid
@property(nonatomic,copy)NSString *uuid;
//历史次数
@property(nonatomic,copy)NSString *visited_count;

+ (instancetype)historyCoursesWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
