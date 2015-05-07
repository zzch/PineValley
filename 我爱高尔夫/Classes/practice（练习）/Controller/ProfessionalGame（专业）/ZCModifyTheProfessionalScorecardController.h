//
//  ZCModifyTheProfessionalScorecardController.h
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCscorecard.h"
@class ZCModifyTheProfessionalScorecardController;
@protocol ZCModifyTheProfessionalScorecardControllerDelegate<NSObject>
@optional
- (void)modifyTheProfessionalScorecardController:(ZCModifyTheProfessionalScorecardController *)modifyTheProfessionalScorecardController didSaveScorecardt:(ZCscorecard *)scorecard;
@end


@interface ZCModifyTheProfessionalScorecardController : UIViewController
@property(nonatomic,strong) ZCscorecard *scorecard;


@property(nonatomic,weak) id<ZCModifyTheProfessionalScorecardControllerDelegate >delegate;
@end
