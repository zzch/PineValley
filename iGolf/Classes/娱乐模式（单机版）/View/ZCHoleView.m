//
//  ZCHoleView.m
//  iGolf
//
//  Created by hh on 15/7/20.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleView.h"
#import "ZCEditView.h"
#import "ZCDouModel.h"
@interface ZCHoleView()<ZCEditViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic ,weak)UIView *personView;
@property(nonatomic ,weak)UIButton *rivalView;
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

//对手的头像
@property(nonatomic,weak)UIImageView *otherImageView;
@property(nonatomic,weak)UILabel *otherNameLabel;
@property(nonatomic,weak)UIImageView *winImage;
@property(nonatomic,weak)UIImageView *winImage2;
@property(nonatomic,weak)UIButton *button1;
@property(nonatomic,weak)UIButton *button2;

//开启平局让杆时候 对手的控件
@property(nonatomic,weak)UIImageView *personImage2;
//开启平局让杆时候 对手的名字
@property(nonatomic,weak)UILabel *personLabel2;

@property(nonatomic,assign)int isOpen1;
@property(nonatomic,assign)int isOpen2;
@property(nonatomic,assign)int isOpen3;
@property(nonatomic,assign)int isOpen4;
@property(nonatomic,assign)int isOpen5;
//谁赢 1代表 本机的用户赢，2代表添加用户赢
@property(nonatomic,assign)int whoWin;


@property(nonatomic,strong)NSMutableDictionary *userDict;
@property(nonatomic,strong)NSMutableDictionary *otherDict;

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
        
        UIButton *rivalView=[[UIButton alloc] init];
        rivalView.tag=3809;
        //rivalView.frame=CGRectMake(180, 10, 50, 80);
        [self addSubview:rivalView];
        rivalView.backgroundColor=[UIColor redColor];
        self.rivalView=rivalView;
        [rivalView addTarget:self action:@selector(clickTheRivalView) forControlEvents:UIControlEventTouchUpInside];
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
        
        
        //默认值
       
      //  switchAction
        
        
    }
    return self;
}

//点击编辑昵称
-(void)clickTheRivalView
{
    
    if ([self.delegate respondsToSelector:@selector(buttonIsClicker:)]) {
        [self.delegate buttonIsClicker:nil];
    }
    
    
}


//控制器传个人信息过来
-(void)acceptPersonalInformation:(UIImage *)image andName:(NSString *)name
{
    self.otherImageView.image=image;
    self.otherNameLabel.text=name;
    self.personLabel2.text=name;
    self.personImage2.image=image;
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
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, view.frame.size.width+5, view.frame.size.width, 20);
    nameLabel.text=nameStr;
    nameLabel.textColor=[UIColor blackColor];
   
    [view addSubview:nameLabel];
    
    
    if (view.tag==3809) {
        self.otherImageView=imageView;
        self.otherNameLabel=nameLabel;
    }
    
    
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
    personImage2.image=self.otherImageView.image;
    [button2 addSubview:personImage2];
    self.personImage2=personImage2;
    
    //名字
    UILabel *nameLabel2=[[UILabel alloc] init];
    nameLabel2.frame=CGRectMake(10, 75, 70, 20);
    nameLabel2.text=self.otherNameLabel.text;
    [button2 addSubview:nameLabel2];
    self.personLabel2=nameLabel2;
    
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
    self.whoWin=2;
    
    [self.button1 setBackgroundColor:[UIColor whiteColor]];
    [self.button2 setBackgroundColor:[UIColor yellowColor]];
    self.winImage.hidden=YES;
    self.winImage2.hidden=NO;
     [self switchAction:nil];
   
}

-(void)clickTheButton1:(UIButton *)button
{
    self.whoWin=1;
    [self.button2 setBackgroundColor:[UIColor whiteColor]];
    [self.button1 setBackgroundColor:[UIColor yellowColor]];
    self.winImage2.hidden=YES;
    self.winImage.hidden=NO;
    
    [self switchAction:nil];
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
    ZCLog(@"执行了码");
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        switch (switchButton.tag) {
            case 13001:
                self.isOpen1=1;
                break;
            case 13002:
                self.isOpen2=1;
                break;
            case 13003:
                self.isOpen3=1;
                break;
            case 13004:
                self.isOpen4=1;
                break;
            case 13005:
                self.isOpen5=1;
                [self clickTheButton1:nil];
                self.drawToWinView.hidden=NO;
                //[self clickTheButton1:nil];
                break;
            default:
                break;
        }
//        if (switchButton.tag==13005) {
//            
//        }
        
        
        ZCLog(@"是");
    }else if(isButtonOn==NO) {
        switch (switchButton.tag) {
            case 13001:
                self.isOpen1=0;
                break;
            case 13002:
                self.isOpen2=0;
                break;
            case 13003:
                self.isOpen3=0;
                break;
            case 13004:
                self.isOpen4=0;
                break;
            case 13005:
                self.isOpen5=0;
                self.whoWin=0;
                self.drawToWinView.hidden=YES;
                break;
            default:
                break;
        }
        ZCLog(@"否");
    }
    [self agentByValue];
   }

//默认值
-(void)theDefaultValue
{

    self.isOpen1=1;
    self.isOpen2=1;
    self.isOpen3=1;
    self.isOpen4=1;
    self.isOpen5=0;
    self.whoWin=0;
    
    NSData *image= UIImagePNGRepresentation(self.personImage);
    NSMutableDictionary *userDict=[NSMutableDictionary dictionary];
    userDict[@"isUser"]=@(1);
    userDict[@"name"]=self.personName;
    userDict[@"personImage"]=image;
    self.userDict=userDict;
    
    
    UIImageView *image1;
    UILabel *label1;
    for (id view in self.rivalView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image1=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            label1=view;
        }
        
    }
   // ZCLog(@"%@",label1.text);
    
    NSData *image2= UIImagePNGRepresentation(image1.image);
    NSMutableDictionary *otherDict=[NSMutableDictionary dictionary];
    otherDict[@"isUser"]=@(0);
    otherDict[@"name"]=label1.text;
    otherDict[@"personImage"]=image2;
    self.otherDict=otherDict;

    
    [self agentByValue];
}

-(void)agentByValue
{

        if ([self.delegate respondsToSelector:@selector(switchButtonIsOpen:andSwitch2:andSwitch3:andSwitch4:andSwitch5:andWhoWin:andUserDict:andOtherDict:)]) {
        [self.delegate switchButtonIsOpen:self.isOpen1 andSwitch2:self.isOpen2 andSwitch3:self.isOpen3 andSwitch4:self.isOpen4 andSwitch5:self.isOpen5 andWhoWin:self.whoWin andUserDict:self.userDict andOtherDict:self.otherDict];
        ZCLog(@"%d",self.whoWin);
    }

}



//返回数组头像
-(NSMutableArray *)obtainCompetitorInformation
{
   NSMutableArray *teamArray=[NSMutableArray array];
   
    UIImageView *image1;
    UILabel *label1;
    for (id view in self.personView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image1=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            label1=view;
        }
        
    }

    
    UIImageView *image2;
    UILabel *label2;
    for (id view in self.rivalView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image2=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            label2=view;
        }
        
    }

    
    
    
    ZCDouModel *userModel=[[ZCDouModel alloc] init];
    userModel.isUser=1;
    userModel.name=label1.text;
    userModel.personImage=image1.image;
    
    [teamArray addObject:userModel];
    
    
    ZCDouModel *userModel2=[[ZCDouModel alloc] init];
    userModel2.isUser=0;
    userModel2.name=label2.text;
    userModel2.personImage=image2.image;
    
    [teamArray addObject:userModel2];
    
    
    
    return teamArray;
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
