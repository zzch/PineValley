//
//  ZCPersonalInformationViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/4/8.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPersonalData.h"
@class ZCPersonalInformationViewController;
@protocol ZCPersonalInformationViewControllerDelegate<NSObject>
@optional
-(void)ZCPersonalInformationViewController:(ZCPersonalInformationViewController *)ZCPersonalInformationViewController andPersonImage:(UIImage *)personImage  andSignatureTextView:(NSString *)SignatureStr  andPersonName:(NSString *) name;
@end
@interface ZCPersonalInformationViewController : UIViewController
@property(nonatomic,strong)ZCPersonalData *personalData;
@property(nonatomic,strong)UIImage *personalImage;
@property(nonatomic,weak)NSString *name;
@property(nonatomic,weak) id<ZCPersonalInformationViewControllerDelegate>delegate;
@end
