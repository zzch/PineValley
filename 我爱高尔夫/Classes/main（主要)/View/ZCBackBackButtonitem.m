//
//  ZCBackBackButtonitem.m
//  我爱高尔夫
//
//  Created by hh on 15/3/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCBackBackButtonitem.h"

@implementation ZCBackBackButtonitem


-(instancetype)init
{
    if (self=[super init]) {
        self.style=UIBarButtonItemStylePlain;
        UIImage* image = [UIImage imageNamed:@"fanhui-anxia"];
        UIImage *image1=[UIImage imageNamed:@"fanhui"];
       
        [self setBackButtonBackgroundImage:[image1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [self setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
        

       //initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
        
    }
    return self;
}

@end
