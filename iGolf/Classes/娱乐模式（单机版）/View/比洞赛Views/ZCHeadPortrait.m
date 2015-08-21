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
@property(nonatomic,weak)UIImageView *bjImageView;
@end
@implementation ZCHeadPortrait

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
//        // 获取路劲 取出图片
//        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
//        NSData *imageData=[NSData dataWithContentsOfFile:path];
//        UIImage *image=[[UIImage alloc] initWithData:imageData];
       

//        UIImageView *imageView=[[UIImageView alloc] init];
//        //CGFloat imageViewX=
//        imageView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
//        imageView.layer.cornerRadius=self.frame.size.width/2;
//        imageView.layer.masksToBounds=YES;
//        imageView.image=image;
//        [self addSubview:imageView ];
//        self.photoView=imageView;
       // CGFloat w= self.frame.size.width/2;
        
        
        UIImageView *photoView=[[UIImageView alloc] init];
       
        photoView.layer.cornerRadius=self.frame.size.width/2;
        photoView.layer.masksToBounds=YES;
        photoView.layer.borderWidth=3;
       
        [self addSubview:photoView];
        self.photoView=photoView;


        
        UIImageView *bjImageView=[[UIImageView alloc] init];
        bjImageView.image=[UIImage imageNamed:@"ganshuchengji"];
        [self addSubview:bjImageView];
        self.bjImageView=bjImageView;
        
        
        UILabel *nameLabel=[[UILabel alloc] init];
        
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.text=@"张三";
        nameLabel.textColor=[UIColor whiteColor];
        [bjImageView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UIImageView *moneyImage=[[UIImageView alloc] init];
        moneyImage.image=[UIImage imageNamed:@"jinbi"];
        [bjImageView addSubview:moneyImage];
         self.moneyImage=moneyImage;

        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.text=@"-110";
        numberLabel.textColor=[UIColor whiteColor];
        numberLabel.textAlignment=NSTextAlignmentCenter;
        [bjImageView addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        
        
    }
    return self;

}


-(void)setIndexColor:(int)indexColor
{
    _indexColor=indexColor;
    if (indexColor==1) {
        self.photoView.layer.borderColor=ZCColor(45, 219, 254) .CGColor;
        self.nameLabel.textColor=ZCColor(45, 219, 254) ;
    }else{
    self.photoView.layer.borderColor=ZCColor(69, 226, 57).CGColor;
        self.nameLabel.textColor=ZCColor(69, 226, 57);
    }
    
    
    
    
}


-(void)setScore:(int)score
{
    _score=score;
    self.numberLabel.text=[NSString stringWithFormat:@"%d",score];

}



-(void)setOfflinePlayer:(ZCOfflinePlayer *)offlinePlayer
{
    _offlinePlayer=offlinePlayer;
    
    
    
    ZCLog(@"%@",offlinePlayer.portrait);
    // 获取路劲 取出图片
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:offlinePlayer.portrait];
    NSData *imageData=[NSData dataWithContentsOfFile:path];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    self.photoView.image=image;
    self.nameLabel.text=offlinePlayer.nickname;
    self.numberLabel.text=[NSString stringWithFormat:@"%ld",(long)offlinePlayer.score];
    ZCLog(@"%@",[NSString stringWithFormat:@"%ld",(long)offlinePlayer.score]);
    
    
    [self layoutSubviews];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat photoViewY=0;
    CGFloat photoViewW=self.frame.size.width*0.8;
    CGFloat photoViewH=self.frame.size.width*0.8;
    CGFloat photoViewX=(self.frame.size.width-photoViewW)/2;
    self.photoView.layer.cornerRadius=photoViewW/2;
    self.photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    
    
    
    CGFloat bjImageViewY=photoViewW+15;
    CGFloat bjImageViewW=self.frame.size.width;
    CGFloat bjImageViewH=50;
    self.bjImageView.frame=CGRectMake(0, bjImageViewY, bjImageViewW, bjImageViewH);
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=bjImageViewW;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat w=[ZCTool getFrame:CGSizeMake(200, 20) content:self.numberLabel.text fontSize:[UIFont systemFontOfSize:18]].size.width;
    CGFloat MW=w+20;
    
    CGFloat moneyImageX=(bjImageViewW-MW)/2;
    CGFloat moneyImageY=nameLabelH+3;
    CGFloat moneyImageW=17;
    CGFloat moneyImageH=17;
    self.moneyImage.frame=CGRectMake(moneyImageX, moneyImageY, moneyImageW, moneyImageH);
    
    CGFloat numberLabelX=moneyImageX+moneyImageW+3;
    CGFloat numberLabelY=moneyImageY;
    CGFloat numberLabelW=w+10;
    CGFloat numberLabelH=17;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);

}


@end
