//
//  ZCGraphicsView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCGraphicsView.h"

@implementation ZCGraphicsView



- (void)drawRect:(CGRect)rect
{
//    // 1.获得上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();

    drawCircle();
}

/**
 *  画圆
 */
void drawCircle()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 10, 100, 100));
    
    CGContextSetLineWidth(ctx, 10);
    
    // 3.显示所绘制的东西
    CGContextStrokePath(ctx);
}


@end
