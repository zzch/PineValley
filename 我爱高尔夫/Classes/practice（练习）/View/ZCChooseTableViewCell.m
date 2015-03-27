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
//球场地址
@property (nonatomic, weak) UILabel *address;
//距离
@property (nonatomic, weak) UILabel *distance;

@property (nonatomic, weak) UIImageView *addressImage;
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
        self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yihangbeijing"]];
        
        self.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xuanzeqiuchang_bj_anxia"]];
        
       //公司名称
        UILabel *name=[[UILabel alloc] init];
        [self addSubview:name];
        _name=name;
         name.font=[UIFont systemFontOfSize:16];
        name.textColor=ZCColor(208, 210, 212);

        UILabel *address=[[UILabel alloc] init];
        [self addSubview:address];
        _address=address;
        address.font=[UIFont systemFontOfSize:14];
        address.textColor=ZCColor(208, 210, 212);


        UILabel *distance=[[UILabel alloc] init];
        [self addSubview:distance];
        _distance=distance;
        distance.textColor=ZCColor(37, 176, 28);

        
        
        UIImageView *addressImage=[[UIImageView alloc] init];
        [self addSubview:addressImage];
        self.addressImage=addressImage;
        addressImage.image=[UIImage imageNamed:@"weizhi"];
         
    }
    return  self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameX=self.frame.size.width*0.05 ;
    CGFloat nameY=self.frame.size.height*0.2;
    CGFloat nameW=self.frame.size.width*0.68;
    CGFloat nameH=self.frame.size.height-(2*nameY)-(self.frame.size.height*0.15);
    _name.frame=CGRectMake(nameX, nameY, nameW, nameH);
    
    
    //图片
    CGFloat addressImageX=nameX ;
    CGFloat addressImageY=nameY+nameH+(self.frame.size.height*0.05);
    CGFloat addressImageW=10;
    CGFloat addressImageH=14;

    _addressImage.frame=CGRectMake(addressImageX, addressImageY, addressImageW, addressImageH);
    
    
    CGFloat addressX=addressImageX+15;
    CGFloat addressY=addressImageY;
    CGFloat addressW=self.frame.size.width*0.73;
    CGFloat addressH=addressImageH;
    _address.frame=CGRectMake(addressX, addressY, addressW, addressH);
    
    CGFloat distanceH=15;
    CGFloat distanceX=self.frame.size.width*0.75;
    //ZCLog(@"%f------",SCREEN_WIDTH);
    CGFloat distanceY=(self.frame.size.height-distanceH)/2;
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
    self.address.text=[NSString stringWithFormat:@"%@",stadium.address];
    // NSLog(@"%@",stadium.distance);
    

    
    
}




- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
