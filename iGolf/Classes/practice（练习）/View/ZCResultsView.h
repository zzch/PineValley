//
//  ZCResultsView.h
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCStatisticalScorecard.h"
@interface ZCResultsView : UIView
+(instancetype)initWithResultsViewWithFrame:(CGRect)frame andModel:(ZCStatisticalScorecard *)scorecard;
@end
