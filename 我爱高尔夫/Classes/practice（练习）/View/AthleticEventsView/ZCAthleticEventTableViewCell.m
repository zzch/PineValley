//
//  ZCAthleticEventTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/22.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAthleticEventTableViewCell.h"
@interface ZCAthleticEventTableViewCell()
@property(nonatomic,weak)UIImageView *photoView;
@property(nonatomic,weak)UILabel *personName;
@property(nonatomic,weak)UILabel *stadiumName;
@property(nonatomic,weak)UILabel *stadiumtype;
@property(nonatomic,weak)UILabel *numberPerson;
@end
@implementation ZCAthleticEventTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"athleticEvent";
    ZCAthleticEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCAthleticEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *photoView=[[UIImageView alloc] init];
        photoView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:photoView];
        self.photoView=photoView;
        
        UILabel *personName=[[UILabel alloc] init];
        [self.contentView addSubview:personName];
        self.personName=personName;
        
        
        UILabel *stadiumName=[[UILabel alloc] init];
        [self.contentView addSubview:stadiumName];
        self.stadiumName=stadiumName;
        
        
        UILabel *stadiumtype=[[UILabel alloc] init];
        [self.contentView addSubview:stadiumtype];
        self.stadiumtype=stadiumtype;

        
        UILabel *numberPerson=[[UILabel alloc] init];
        [self.contentView addSubview:numberPerson];
        self.numberPerson=numberPerson;

        
    }
    return self;
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat photoViewX=0;
    CGFloat photoViewY=0;
    CGFloat photoViewW=60;
    CGFloat photoViewH=self.frame.size.height;
    self.photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    
    CGFloat personNameX=photoViewX+photoViewW+10;
    CGFloat personNameY=5;
    CGFloat personNameW=90;
    CGFloat personNameH=20;
    self.personName.frame=CGRectMake(personNameX, personNameY, personNameW, personNameH);
    
    CGFloat stadiumNameX=personNameX;
    CGFloat stadiumNameY=personNameY+personNameH+5;
    CGFloat stadiumNameW=190;
    CGFloat stadiumNameH=20;
    self.stadiumName.frame=CGRectMake(stadiumNameX, stadiumNameY, stadiumNameW, stadiumNameH);
    
    CGFloat stadiumtypeX=personNameX;
    CGFloat stadiumtypeY=stadiumNameY+stadiumNameH+5;
    CGFloat stadiumtypeW=60;
    CGFloat stadiumtypeH=20;
    self.stadiumtype.frame=CGRectMake(stadiumtypeX, stadiumtypeY, stadiumtypeW, stadiumtypeH);


    
    CGFloat numberPersonY=personNameY;
    CGFloat numberPersonW=60;
    CGFloat numberPersonH=20;
    CGFloat numberPersonX=self.frame.size.width-numberPersonW-10;
    self.numberPerson.frame=CGRectMake(numberPersonX, numberPersonY, numberPersonW, numberPersonH);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
