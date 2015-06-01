//
//  ZCScorecardTableViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/2/3.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCTotalScorecards.h"
@interface ZCScorecardTableViewController : UIViewController
@property(nonatomic,strong)ZCTotalScorecards *totalScorecards;
@property(nonatomic,copy)NSString *uuid;
//@property(nonatomic,copy)NSString *tee_box;
//@property(nonatomic,copy)NSString *lastUuid;
//@property(nonatomic,copy)NSString *lastTee_box;
@end
