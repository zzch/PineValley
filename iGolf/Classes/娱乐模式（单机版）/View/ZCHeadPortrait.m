//
//  ZCHeadPortrait.m
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHeadPortrait.h"
@interface ZCHeadPortrait()
@property(nonatomic,weak)UIImageView *photoView;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIImageView *moneyImage;
@property(nonatomic,weak)UILabel *numberLabel;
@end
@implementation ZCHeadPortrait

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        // 获取路劲 取出图片
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        NSData *imageData=[NSData dataWithContentsOfFile:path];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
       

//        UIImageView *imageView=[[UIImageView alloc] init];
//        //CGFloat imageViewX=
//        imageView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
//        imageView.layer.cornerRadius=self.frame.size.width/2;
//        imageView.layer.masksToBounds=YES;
//        imageView.image=image;
//        [self addSubview:imageView ];
//        self.photoView=imageView;
        
        
        UIImageView *photoView=[[UIImageView alloc] init];
       // photoView.backgroundColor=[UIColor redColor];
        photoView.layer.cornerRadius=30;
        photoView.layer.masksToBounds=YES;
        photoView.image=image;

        [self addSubview:photoView];
        self.photoView=photoView;


        UILabel *nameLabel=[[UILabel alloc] init];
        
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.text=@"张三";
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UIImageView *moneyImage=[[UIImageView alloc] init];
        moneyImage.backgroundColor=[UIColor blueColor];
        [self addSubview:moneyImage];
         self.moneyImage=moneyImage;

        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.text=@"10";
        numberLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        
        
    }
    return self;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat photoViewX=0;
    CGFloat photoViewY=0;
    CGFloat photoViewW=self.frame.size.width;
    CGFloat photoViewH=self.frame.size.width;
    self.photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=photoViewW+3;
    CGFloat nameLabelW=photoViewW;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat moneyImageX=5;
    CGFloat moneyImageY=nameLabelY+nameLabelH+2;
    CGFloat moneyImageW=10;
    CGFloat moneyImageH=10;
    self.moneyImage.frame=CGRectMake(moneyImageX, moneyImageY, moneyImageW, moneyImageH);
    
    CGFloat numberLabelX=20;
    CGFloat numberLabelY=moneyImageY;
    CGFloat numberLabelW=20;
    CGFloat numberLabelH=15;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);

}


@end
