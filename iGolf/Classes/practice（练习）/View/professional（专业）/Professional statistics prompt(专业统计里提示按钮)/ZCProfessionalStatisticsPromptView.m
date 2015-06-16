//
//  ZCProfessionalStatisticsPromptView.m
//  iGolf
//
//  Created by hh on 15/6/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCProfessionalStatisticsPromptView.h"
@interface ZCProfessionalStatisticsPromptView()
@property(nonatomic,weak)UILabel *instructionsLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIView *mainView;
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UIButton *button;
@property(nonatomic,weak)UIImageView *topImageView;
@property(nonatomic,weak)UIImageView *bjImage;
@end
@implementation ZCProfessionalStatisticsPromptView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        //添加控件
        [self addControls];
        
    }
    return self;
}


-(void)addControls
{
    
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image1=[UIImage imageNamed:@"jstj_ts_anniu" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    
    UIImage *image2=[UIImage imageNamed:@"jstj_ts_bj" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    
    
    UIImageView *bjImage=[[UIImageView alloc] init];
    bjImage.image=image2;
    bjImage.alpha=1.0;
    [self addSubview:bjImage];
    self.bjImage=bjImage;
    
    UIView *mainView=[[UIView alloc] init];
   
    //mainView.alpha=1.0;
    
//    mainView.layer.cornerRadius=10;//设置圆角的半径为10
//    mainView.layer.masksToBounds=YES;
    [self addSubview:mainView];
    self.mainView=mainView;
    
   
   
    
    UIImageView *topImageView=[[UIImageView alloc] init];
    topImageView.image=[UIImage imageNamed:@"jstj_ts_wh"];
    [mainView addSubview:topImageView];
    self.topImageView=topImageView;
    
     UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.textColor=ZCColor(85, 85, 85);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UIView *bjView=[[UIView alloc] init];
    bjView.backgroundColor=ZCColor(170, 170, 170);
    [mainView addSubview:bjView];
    self.bjView=bjView;
    
    
    UILabel *instructionsLabel=[[UILabel alloc] init];
    instructionsLabel.textAlignment=NSTextAlignmentCenter;
    //自动折行设置NSLineBreakByWordWrapping   UILineBreakModeWordWrap
    instructionsLabel.textColor=ZCColor(34, 34, 34);
    instructionsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    instructionsLabel.numberOfLines = 0;
    instructionsLabel.font=[UIFont systemFontOfSize:18];
    [mainView addSubview:instructionsLabel];
    self.instructionsLabel=instructionsLabel;
    
    
    
    
   
    
    
    UIButton *button1=[[UIButton alloc] init];
   
    [button1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickThebutton) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:button1];
    self.button=button1;
    
    
}


-(void)clickThebutton
{
    [self removeFromSuperview];
}



-(void)setNameStr:(NSString *)nameStr
{
    _nameStr=nameStr;
    self.nameLabel.text=self.nameStr;

}

-(void)setInstructionsStr:(NSString *)instructionsStr
{
    _instructionsStr=instructionsStr;
    
//    CGFloat instructionsLabelX=25;
//    CGFloat instructionsLabelY=self.nameLabel.frame.size.height+self.nameLabel.frame.origin.y+30;
//    CGFloat instructionsLabelW=self.mainView.frame.size.width-50;
//    CGFloat instructionsLabelH=[self.instructionsStr sizeWithFont:[UIFont systemFontOfSize:18]].height;
//    self.instructionsLabel.frame=CGRectMake(instructionsLabelX, instructionsLabelY, instructionsLabelW, instructionsLabelH);
    
    self.instructionsLabel.text=instructionsStr;
}



//根据字符串计算出宽高
-(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize
{
    CGRect rect = [content boundingRectWithSize:frame options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil] context:nil];
    return rect;
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    
    
    
    CGFloat mainViewX=23;
    CGFloat mainViewW=SCREEN_WIDTH-(2*mainViewX);
    CGFloat mainViewH=260;
    CGFloat mainViewY=(SCREEN_HEIGHT-mainViewH)/2;
    self.bjImage.frame=CGRectMake(mainViewX, mainViewY, mainViewW, mainViewH);
    
   self.mainView.frame=CGRectMake(mainViewX, mainViewY, mainViewW, mainViewH);

    CGFloat topImageViewX=(mainViewW-60)/2;
    CGFloat topImageViewW=60;
    CGFloat topImageViewH=60;
    CGFloat topImageViewY=-30;
    self.topImageView.frame=CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH);
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=55;
    CGFloat nameLabelW=mainViewW;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    self.bjView.frame=CGRectMake(22, nameLabelY+nameLabelH+15, mainViewW-44, 1);
    
    
    
    CGFloat instructionsLabelX=25;
    CGFloat instructionsLabelY=nameLabelY+nameLabelH+25;
    CGFloat instructionsLabelW=mainViewW-50;
    CGFloat instructionsLabelH=[self getFrame:CGSizeMake(instructionsLabelW, 80) content:self.instructionsStr fontSize:[UIFont systemFontOfSize:18]].size.height;
    self.instructionsLabel.frame=CGRectMake(instructionsLabelX, instructionsLabelY, instructionsLabelW, instructionsLabelH);
    
    
    CGFloat buttonX=23;
    CGFloat buttonY=mainViewH-68;
    CGFloat buttonW=mainViewW-(2*buttonX);
    CGFloat buttonH=40;
    self.button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

@end
