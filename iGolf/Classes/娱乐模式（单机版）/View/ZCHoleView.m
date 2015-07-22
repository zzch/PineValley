//
//  ZCHoleView.m
//  iGolf
//
//  Created by hh on 15/7/20.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleView.h"
@interface ZCHoleView()
@property(nonatomic ,weak)UIView *personView;
@property(nonatomic ,weak)UIView *rivalView;
@property(nonatomic ,weak)UILabel *VS;
@property(nonatomic ,weak)UIView *firstView;
@property(nonatomic ,weak)UIView *secondView;
@property(nonatomic ,weak)UIView *thirdView;
@property(nonatomic ,weak)UIView *fourthView;
@property(nonatomic ,weak)UIView *fifthView;
@property(nonatomic ,weak)UIView *drawToWinView;

@property(nonatomic,assign)int indexTag;
//机主的头像
@property(nonatomic,weak)UIImage *personImage;
//机主的名字
@property(nonatomic,copy)NSString *personName;
//对手的头像
@property(nonatomic,weak)UIImage *otherImage;


@property(nonatomic,weak)UIImageView *winImage;
@property(nonatomic,weak)UIImageView *winImage2;
@property(nonatomic,weak)UIButton *button1;
@property(nonatomic,weak)UIButton *button2;


@end
@implementation ZCHoleView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        // 获取路劲 取出图片
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        NSData *imageData=[NSData dataWithContentsOfFile:path];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        self.personImage=image;

        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        self.personName=account.nickname;

        
        
        UIView *personView=[[UIView alloc] init];
        [self addSubview:personView];
        self.personView=personView;
        [self addPersonView:personView andPersonImage:image andPersonName:[NSString stringWithFormat:@"%@",account.nickname]];
        
        
        UILabel *VS=[[UILabel alloc] init];
        VS.text=@"VS";
        VS.textColor=[UIColor blackColor];
        [self addSubview:VS];
        self.VS=VS;
        
        UIView *rivalView=[[UIView alloc] init];
        //rivalView.frame=CGRectMake(180, 10, 50, 80);
        [self addSubview:rivalView];
        rivalView.backgroundColor=[UIColor redColor];
        self.rivalView=rivalView;
        
        [self addPersonView:rivalView andPersonImage:image andPersonName:@"编辑昵称"];
        
        
        UIView *firstView=[[UIView alloc] init];
        [self addSubview:firstView];
         self.firstView=firstView;
        [self addView:firstView andNameLabelText:@"小鸟球翻一倍"];
        
        
        UIView *secondView=[[UIView alloc] init];
        [self addSubview:secondView];
        self.secondView=secondView;
        [self addView:secondView andNameLabelText:@"老鹰球翻两倍"];
        
        UIView *thirdView=[[UIView alloc] init];
        [self addSubview:thirdView];
        self.thirdView=thirdView;
        [self addView:thirdView andNameLabelText:@"双倍标准杆翻一倍"];
        
        UIView *fourthView=[[UIView alloc] init];
        [self addSubview:fourthView];
        self.fourthView=fourthView;
        [self addView:fourthView andNameLabelText:@"打平进入下一洞"];
        
        UIView *fifthView=[[UIView alloc] init];
        [self addSubview:fifthView];
        self.fifthView=fifthView;
        [self addView:fifthView andNameLabelText:@"平局让杆"];


        
        UIView *drawToWinView=[[UIView alloc] init];
        [self addSubview:drawToWinView];
        drawToWinView.hidden=YES;
        self.drawToWinView=drawToWinView;
        [self addTheDrawToWinView:drawToWinView];
        
        
    }
    return self;
}


-(void)addPersonView:(UIView *)view
  andPersonImage:(UIImage *)image andPersonName:(NSString *)nameStr
{
    [self layoutIfNeeded];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    //CGFloat imageViewX=
    imageView.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.width);
    imageView.layer.cornerRadius=view.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    imageView.image=image;
    [view addSubview:imageView ];
    
    UIButton *nameButton=[[UIButton alloc] init];
    nameButton.frame=CGRectMake(0, view.frame.size.width+5, view.frame.size.width, 20);
    [nameButton setTitle:nameStr forState:UIControlStateNormal];
    [nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:nameButton];
    
    
    
}

//平局让杆
-(void)addTheDrawToWinView:(UIView *)view
{
    [self layoutIfNeeded];
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(0, 0, view.frame.size.width, 20);
    textLabel.text=@"平局谁获胜？";
    textLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:textLabel];
    
    UIButton *button1=[[UIButton alloc] init];
    button1.frame=CGRectMake(0, 25, SCREEN_WIDTH/2, view.frame.size.height-25) ;
    [button1 addTarget:self action:@selector(clickTheButton1:) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor=[UIColor yellowColor];
    [view addSubview:button1];
    self.button1=button1;
    
        //添加button1上的内容
    UIImageView *personImage=[[UIImageView alloc] init];
    personImage.backgroundColor=[UIColor redColor];
    personImage.frame=CGRectMake(10, 10, 70, 70);
    personImage.layer.cornerRadius=35;
    personImage.layer.masksToBounds=YES;
    personImage.image=self.personImage;
    [button1 addSubview:personImage];
    
    //名字
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10, 75, 70, 20);
    nameLabel.text=self.personName;
    [button1 addSubview:nameLabel];
    
    //胜利的图片
    UIImageView *winImage=[[UIImageView alloc] init];
    winImage.frame=CGRectMake(85, 10, 30, 75);
    winImage.backgroundColor=[UIColor redColor];
    [button1 addSubview:winImage];
    self.winImage=winImage;
    

    UIButton *button2=[[UIButton alloc] init];
    
    button2.frame=CGRectMake(SCREEN_WIDTH/2, 25, SCREEN_WIDTH/2, view.frame.size.height-25) ;
    [button2 addTarget:self action:@selector(clickTheButton2:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    self.button2=button2;
    
    //添加button2上的内容
    UIImageView *personImage2=[[UIImageView alloc] init];
    personImage2.backgroundColor=[UIColor redColor];
    personImage2.frame=CGRectMake(10, 10, 70, 70);
    personImage2.layer.cornerRadius=35;
    personImage2.layer.masksToBounds=YES;
    personImage2.image=self.personImage;
    [button2 addSubview:personImage2];
    
    //名字
    UILabel *nameLabel2=[[UILabel alloc] init];
    nameLabel2.frame=CGRectMake(10, 75, 70, 20);
    nameLabel2.text=self.personName;
    [button2 addSubview:nameLabel2];
    
    //胜利的图片
    UIImageView *winImage2=[[UIImageView alloc] init];
    winImage2.frame=CGRectMake(85, 10, 30, 75);
    winImage2.backgroundColor=[UIColor redColor];
    winImage2.hidden=YES;
    [button2 addSubview:winImage2];
    self.winImage2=winImage2;
    

}


-(void)clickTheButton2:(UIButton *)button
{
    [self.button1 setBackgroundColor:[UIColor whiteColor]];
    [self.button2 setBackgroundColor:[UIColor yellowColor]];
    self.winImage.hidden=YES;
    self.winImage2.hidden=NO;
    
   
}

-(void)clickTheButton1:(UIButton *)button
{
    [self.button2 setBackgroundColor:[UIColor whiteColor]];
    [self.button1 setBackgroundColor:[UIColor yellowColor]];
    self.winImage2.hidden=YES;
    self.winImage.hidden=NO;
    
}

-(void)addView:(UIView *)view andNameLabelText:(NSString *)nameStr
{
    [self layoutIfNeeded];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=view.frame.size.width*0.6;
    CGFloat nameLabelH=view.frame.size.height;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
    [view addSubview:nameLabel];
    
    
    self.indexTag++;
    ZCLog(@"%d",self.indexTag);
    
    UISwitch *switchView=[[UISwitch alloc] init];
    CGFloat switchViewW=40;
    CGFloat switchViewH=view.frame.size.height-10;
    CGFloat switchViewX=SCREEN_WIDTH-switchViewW-20;
    CGFloat switchViewY=5;
    switchView.frame=CGRectMake(switchViewX, switchViewY, switchViewW, switchViewH);
    
    switchView.tag=13000+self.indexTag;
    
  [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    if ( switchView.tag==13005) {
        switchView.on=NO;
    }else
    {
        switchView.on=YES;
    }
    [view addSubview:switchView];

}

//开关
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        if (switchButton.tag==13005) {
            self.drawToWinView.hidden=NO;
        }
        
        
        ZCLog(@"是");
    }else {
        if (switchButton.tag==13005) {
            self.drawToWinView.hidden=YES;
        }
        ZCLog(@"否");
    }
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.personView.frame=CGRectMake(10, 10, 80, 120);
    self.VS.frame=CGRectMake((SCREEN_WIDTH-30)/2, 90, 30, 40);
    self.rivalView.frame=CGRectMake(180, 10, 80, 120);
    self.firstView.frame=CGRectMake(0, 140, SCREEN_WIDTH, 30);
    self.secondView.frame=CGRectMake(0, 171, SCREEN_WIDTH, 30);
    self.thirdView.frame=CGRectMake(0, 202, SCREEN_WIDTH, 30);
    self.fourthView.frame=CGRectMake(0, 233, SCREEN_WIDTH, 30);
    self.fifthView.frame=CGRectMake(0, 264, SCREEN_WIDTH, 30);
    self.drawToWinView.frame=CGRectMake(0, 300, SCREEN_WIDTH, 110);
    

}

@end
