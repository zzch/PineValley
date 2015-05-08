//
//  ZCGraphicsView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCGraphicsView.h"
@interface ZCGraphicsView()
@property(nonatomic,weak)UIImageView *imageView;
@end
@implementation ZCGraphicsView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        UIImageView *imageView=[[UIImageView alloc] init];
        
        
        imageView.image=[UIImage imageNamed:@"tj_tubiao"];
        [self addSubview:imageView];
        self.imageView=imageView;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame=CGRectMake((self.frame.size.width-193)/2, (self.frame.size.height-193)/2, 193, 193);

}

//- (void)drawRect:(CGRect)rect
//{
////    // 1.获得上下文
////    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    drawCircle();
//}
//
///**
// *  画圆
// */
//void drawCircle()
//{
////    // 1.获得上下文
////    CGContextRef ctx = UIGraphicsGetCurrentContext();
////    
////    // 2.画圆
//////    CGContextAddEllipseInRect(ctx, CGRectMake(50, 10, 100, 100));
//////    
//////    CGContextSetLineWidth(ctx, 10);
////    CGContextAddArc(ctx, 100, 100, 50, 0, M_PI_4, 1);
////    [[UIColor yellowColor] set];
////    // 3.显示所绘制的东西
////   // CGContextStrokePath(ctx);
////     CGContextFillPath(ctx);
//    
//    
//    
//    
//    
//    
//    
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGFloat rgba[] = {1.0,0.0,0.0,1.0};
//    CGContextSetFillColor(context, rgba);
//    CGContextMoveToPoint(context, 150.0, 200.0);
//    CGContextAddArc(context, 150.0, 200.0, 100.0, 10.0, 200.0, 1);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
//   // CGContextFillPath(context);
//
//}


@end
