//
//  UIBarButtonItem+DC.m
//  我爱高尔夫
//
//  Created by hh on 15/3/31.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "UIBarButtonItem+DC.h"

@implementation UIBarButtonItem (DC)
+ (UIBarButtonItem *)barBtnItemWithNormalImageName:(NSString *)normImageName hightImageName:(NSString *)hightIamgeName action:(SEL)action target:(id)target
{
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:normImageName] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:hightIamgeName] forState:UIControlStateHighlighted];
    btn1.frame = (CGRect){{0,0},btn1.currentImage.size};
    [btn1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
}

@end
