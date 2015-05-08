//
//  ZCResultsViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/4/21.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCResultsViewController : UIViewController
//点击按场次传过来的值
@property(nonatomic,copy)NSString *numberStr;
@property(nonatomic,strong)NSMutableDictionary *timeDict;
@property(nonatomic,copy)NSString *uuid;

@property(nonatomic,copy)NSString *name;

@end
