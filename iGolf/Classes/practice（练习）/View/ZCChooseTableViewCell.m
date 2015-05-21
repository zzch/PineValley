//
//  ZCChooseTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChooseTableViewCell.h"
@interface ZCChooseTableViewCell()
///球场名称
@property (nonatomic, weak) UILabel *name;
//多少洞
@property (nonatomic, weak) UILabel *holeLabel;
//距离
@property (nonatomic, weak) UILabel *distance;

@property (nonatomic, weak) UIImageView *distanceImage;
@property (nonatomic, weak) UIImageView *holeImage;
@end
@implementation ZCChooseTableViewCell

//+(instancetype)cellWithTable:(UITableView *)tableView
//{
//    static NSString *ID = @"choose";
//    ZCChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[ZCChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return  cell;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       // self.backgroundView  yihangbeijing
        //设置背景图片
       // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        
       // self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
//        self.selectedBackgroundView=[[UIView alloc] initWithFrame:self.frame];
//        self.selectedBackgroundView.backgroundColor=ZCColor(15, 14, 14);

        
       //公司名称
        UILabel *name=[[UILabel alloc] init];
        [self addSubview:name];
        _name=name;
         name.font=[UIFont systemFontOfSize:16];
        name.textColor=ZCColor(34, 34, 34);

        
        UIImageView *holeImage=[[UIImageView alloc] init];
        [self addSubview:holeImage];
        self.holeImage=holeImage;
        holeImage.image=[UIImage imageNamed:@"xzqc_qiudong"];
        
        
        UILabel *holeLabel=[[UILabel alloc] init];
        [self addSubview:holeLabel];
        _holeLabel=holeLabel;
        holeLabel.font=[UIFont systemFontOfSize:14];
        holeLabel.textColor=ZCColor(85, 85, 85);


        UIImageView *distanceImage=[[UIImageView alloc] init];
        distanceImage.image=[UIImage imageNamed:@"xzqc_weizh"];
        [self.contentView addSubview:distanceImage];
        self.distanceImage=distanceImage;
        
        
        
        UILabel *distance=[[UILabel alloc] init];
        [self addSubview:distance];
        _distance=distance;
        distance.textColor=ZCColor(85, 85, 85);

        
        
       
         
    }
    return  self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameX=self.frame.size.width*0.05 ;
    CGFloat nameY=self.frame.size.height*0.2;
    CGFloat nameW=SCREEN_WIDTH-nameX;
    CGFloat nameH=self.frame.size.height-(2*nameY)-(self.frame.size.height*0.15);
    _name.frame=CGRectMake(nameX, nameY, nameW, nameH);
    
    
    //图片
    CGFloat addressImageX=nameX ;
    CGFloat addressImageY=nameY+nameH+(self.frame.size.height*0.05);
    CGFloat addressImageW=10;
    CGFloat addressImageH=14;

    self.holeImage.frame=CGRectMake(addressImageX, addressImageY, addressImageW, addressImageH);
    
    
    CGFloat addressX=addressImageX+addressImageW+5;
    CGFloat addressY=addressImageY;
    CGFloat addressW=self.frame.size.width*0.73;
    CGFloat addressH=addressImageH;
    _holeLabel.frame=CGRectMake(addressX, addressY, addressW, addressH);
    
    
    
    CGFloat distanceImageH=13;
    CGFloat distanceImageX=self.frame.size.width*0.65;
    //ZCLog(@"%f------",SCREEN_WIDTH);
    CGFloat distanceImageY=addressY;//(self.frame.size.height-distanceH)/2;
    CGFloat distanceImageW=10;
    _distanceImage.frame=CGRectMake(distanceImageX, distanceImageY, distanceImageW, distanceImageH);
    
    
    
    CGFloat distanceH=15;
    CGFloat distanceX=distanceImageX+distanceImageW+5;
    //ZCLog(@"%f------",SCREEN_WIDTH);
    CGFloat distanceY=distanceImageY;//(self.frame.size.height-distanceH)/2;
    CGFloat distanceW=80;
    _distance.frame=CGRectMake(distanceX, distanceY, distanceW, distanceH);
}


-(void)setStadium:(ZCstadium *)stadium
{
    _stadium=stadium;
    
    
    self.name.text = stadium.name;
    float distance = stadium.distance;
    //cell.distance.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:distance]];
    
    self.distance.text = [NSString stringWithFormat:@"%.1fkm",distance];
    
    // cell.distance.text =@"11";
    //cell.address.text=stadium.address;
    
    
    self.holeLabel.text=[NSString stringWithFormat:@"%@洞",stadium.holes_count];
    
    
    

    
    
}




- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
