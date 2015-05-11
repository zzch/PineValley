//
//  MTScenicShopCell.m
//  MyTravel
//
//  Created by ranki on 14-12-15.
//  Copyright (c) 2014年 mytravel. All rights reserved.
//

#import "MTScenicShopCell.h"


@implementation MTScenicShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
//        UILabel *phoneLab = [[UILabel alloc] init];
//        phoneLab.textColor = [UIColor grayColor];
//        phoneLab.font = [UIFont systemFontOfSize:13];
//        [self addSubview:phoneLab];
//        self.phoneLab = phoneLab;
        
        UILabel *addressLab= [[UILabel alloc] init];
        addressLab.textColor = [UIColor grayColor];
//        addressLab.font = kMiniFont;
        [self addSubview:addressLab];
        self.addressLab = addressLab;
        
        UILabel *nameLab = [[UILabel alloc] init];
//        nameLab.font = kContentFont;
        nameLab.numberOfLines = 0;
        [self addSubview:nameLab];
        self.nameLab = nameLab;
        
        UILabel *priceLab = [[UILabel alloc] init];
        priceLab.textColor = [UIColor grayColor];
//        priceLab.font = kMiniFont;
        priceLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:priceLab];
        self.priceLab = priceLab;
        
//        UIImageView *iconStar = [[UIImageView alloc] init];
//        [self addSubview:iconStar];
//        self.iconStar = iconStar;
        
        UILabel *distanceLab = [[UILabel alloc] init];
        distanceLab.textColor = [UIColor grayColor];
//        distanceLab.font = kMiniFont;
        distanceLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:distanceLab];
        self.distanceLab = distanceLab;
        
//        DLStarRatingControl *starRatingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 154, 320, 153) andStars:5 isFractional:YES numberOfFractions:8];
//        starRatingControl.userInteractionEnabled = NO;
//        starRatingControl.rating = 3;
//        starRatingControl.hidden = YES;
//        starRatingControl.autoresizingMask =  UIViewAutoresizingNone;
//        [self addSubview:starRatingControl];
//        self.starRatingControl = starRatingControl;
//        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [phoneBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneBtn];
        self.phoneBtn = phoneBtn;
        _rating = 0;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat gap = 10;
    CGFloat LabHeight = 30;
    
    CGFloat imageW = 80;
    CGFloat imageH = 80;
    CGFloat phoneBtnW = 44;
    
    if (_iconView.image)
    {
        _iconView.frame = CGRectMake(gap, gap, imageW, imageH);
    }
    
    CGFloat nameLabX = CGRectGetMaxX(_iconView.frame) + gap;
    _nameLab.frame = CGRectMake(nameLabX, gap, 320 - phoneBtnW, LabHeight);
    
    //CGFloat iconStarY = self.height * 0.5;
    
//    if (_rating != 0)
//    {
//        _starRatingControl.frame = CGRectMake(nameLabX, iconStarY, 90, 16);
//        _starRatingControl.rating = _rating;
//        _starRatingControl.hidden = NO;
//    }
 
    if (_phone != nil)
    {
        CGFloat phoneBtnX = 280;
        _phoneBtn.frame = CGRectMake(phoneBtnX, gap, phoneBtnW, 44);
    }
    
    if (_priceLab.text != nil)
    {
        
        CGFloat priceLabX = 250;
        CGFloat priceLabY = CGRectGetMaxY(_nameLab.frame) ;
        _priceLab.frame = CGRectMake(priceLabX, priceLabY, 60, 30);
        
        CGFloat addressLabY = CGRectGetMaxY(_priceLab.frame);
        
        _addressLab.frame = CGRectMake(nameLabX, addressLabY, 200, LabHeight);

        _distanceLab.frame = CGRectMake(230, addressLabY, 90, LabHeight);
        
        _height = CGRectGetMaxY(_distanceLab.frame) + gap;
    }
    else
    {
        CGFloat addressLabY = CGRectGetMaxY(_nameLab.frame);
        
        _addressLab.frame = CGRectMake(nameLabX, addressLabY, 200, LabHeight);
        
        _distanceLab.frame = CGRectMake(230, addressLabY, 90, LabHeight);
        
        _height = CGRectGetMaxY(_distanceLab.frame) + gap;
    }
   
}

- (void)phoneBtnClick
{
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",self.phone];
    NSURL *url = [NSURL URLWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
