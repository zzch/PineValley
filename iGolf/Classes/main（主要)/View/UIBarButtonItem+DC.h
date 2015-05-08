//
//  UIBarButtonItem+DC.h
//  我爱高尔夫
//
//  Created by hh on 15/3/31.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DC)
+ (UIBarButtonItem *)barBtnItemWithNormalImageName:(NSString *)normImageName hightImageName:(NSString *)hightIamgeName action:(SEL)action target:(id)target;
@end
