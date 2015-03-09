//
//  ZCSetting.h
//  我爱高尔夫
//
//  Created by hh on 15/2/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSetting : NSObject
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened) BOOL opened;
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  选择球洞
 */
@property (nonatomic, copy) NSString *choose;
/**
 *  选择T台
 */
@property (nonatomic, copy) NSString *tChoose;
@end
