//
//  ZCTotalGradeViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCStatisticalScorecard.h"
#import "ZCMatch.h"
@interface ZCTotalGradeViewController : UIViewController
@property(nonatomic,strong)ZCStatisticalScorecard *professionalScorecardModel;
@property(nonatomic,strong)NSDictionary *totalModel;
@property(nonatomic,strong)ZCMatch *match;
@end
