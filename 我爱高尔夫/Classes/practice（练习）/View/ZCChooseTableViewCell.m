//
//  ZCChooseTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChooseTableViewCell.h"
@interface ZCChooseTableViewCell()


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
       //公司名称
        UILabel *name=[[UILabel alloc] init];
        [self addSubview:name];
        _name=name;

        UILabel *address=[[UILabel alloc] init];
        [self addSubview:address];
        _address=address;


        UILabel *distance=[[UILabel alloc] init];
        [self addSubview:distance];
        _distance=distance;
    }
    return  self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameX=15;
    CGFloat nameY=15;
    CGFloat nameW=SCREEN_WIDTH-2*nameX;
    CGFloat nameH=self.frame.size.height-2*nameY;
    _name.frame=CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat addressX=15;
    CGFloat addressY=45;
    CGFloat addressW=SCREEN_WIDTH-2*nameX;
    CGFloat addressH=self.frame.size.height - 2*nameY;
    _address.frame=CGRectMake(addressX, addressY, addressW, addressH);
    
    CGFloat distanceH=15;
    CGFloat distanceX=nameX+nameW-30;
    //ZCLog(@"%f------",SCREEN_WIDTH);
    CGFloat distanceY=(self.frame.size.height-distanceH)/2;
    CGFloat distanceW=15;
    _distance.frame=CGRectMake(distanceX, distanceY, distanceW, distanceH);
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
