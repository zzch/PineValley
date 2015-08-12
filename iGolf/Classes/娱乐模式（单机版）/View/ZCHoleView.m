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
@property(nonatomic ,weak)UIButton *personView;
@property(nonatomic ,weak)UIButton *rivalView;
@property(nonatomic ,weak)UIImageView *VS;
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
@property(nonatomic,weak)UIScrollView *scollView;
@property(nonatomic,weak)UIImageView *bjImage;

@property(nonatomic,strong)NSMutableDictionary *userDict;
@property(nonatomic,strong)NSMutableDictionary *otherDict;

@property(nonatomic,weak)UIImageView *meImage1;
@property(nonatomic,weak)UIImageView *otherImage2;
@property(nonatomic,weak)UILabel *meLabel1;
@property(nonatomic,weak)UILabel *otherLabel2;
@end
@implementation ZCHoleView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        UIScrollView *scollView=[[UIScrollView  alloc] init];
        scollView.backgroundColor=ZCColor(237, 237, 237);
        scollView.bounces=NO;
        [self addSubview:scollView];
        
        self.scollView=scollView;
        
        // 获取路劲 取出图片
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        NSData *imageData=[NSData dataWithContentsOfFile:path];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        self.personImage=image;

        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        self.personName=account.nickname;

        
        
        
        UIImageView *bjImage=[[UIImageView alloc] init];
        bjImage.userInteractionEnabled=YES;
        bjImage.image=[ZCTool imagePullLitre:@"taimian"];
        [self.scollView addSubview:bjImage];
        self.bjImage=bjImage;
        
        
        UIButton *personView=[[UIButton alloc] init];
        [bjImage addSubview:personView];
        self.personView=personView;
        [self addPersonView:personView andPersonImage:image andPersonName:[NSString stringWithFormat:@"%@",account.nickname]];
        
        
        UIImageView *VS=[[UIImageView alloc] init];
        VS.image=[UIImage imageNamed:@"vs"];
        [bjImage addSubview:VS];
        self.VS=VS;
        
        
        UIButton *rivalView=[[UIButton alloc] init];
        rivalView.tag=3809;
        [bjImage addSubview:rivalView];
        self.rivalView=rivalView;
        
        [self addPersonView:rivalView andPersonImage:[UIImage imageNamed:@"morentouxiang"] andPersonName:@"玩家1"];
        [rivalView addTarget:self action:@selector(clickTheRivalView) forControlEvents:UIControlEventTouchUpInside];
       
        
        
        
        
        UIView *firstView=[[UIView alloc] init];
        firstView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:firstView];
         self.firstView=firstView;
        [self addView:firstView andNameLabelText:@"小鸟球翻一倍"];
        UIView *secondView=[[UIView alloc] init];
        secondView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:secondView];
        self.secondView=secondView;
        [self addView:secondView andNameLabelText:@"老鹰球翻两倍"];
        
        UIView *thirdView=[[UIView alloc] init];
        thirdView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:thirdView];
        self.thirdView=thirdView;
        [self addView:thirdView andNameLabelText:@"双倍标准杆翻一倍"];
        
        UIView *fourthView=[[UIView alloc] init];
        fourthView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:fourthView];
        self.fourthView=fourthView;
        [self addView:fourthView andNameLabelText:@"打平进入下一洞"];
        
        UIView *fifthView=[[UIView alloc] init];
        fifthView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:fifthView];
        self.fifthView=fifthView;
        [self addView:fifthView andNameLabelText:@"平局让杆"];


        
        UIView *drawToWinView=[[UIView alloc] init];
        drawToWinView.backgroundColor=[UIColor whiteColor];
        [self.scollView addSubview:drawToWinView];
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
    [self layoutSubviews];
    
    
//    UIImageView *biImage=[[UIImageView alloc] init];
//    biImage.image=[UIImage imageNamed:@""];
//    biImage.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.width);
//    [view addSubview:biImage ];
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.width);
    imageView.layer.cornerRadius=view.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    imageView.layer.borderWidth=2;
    if (view.tag==3809)
    {
        imageView.layer.borderColor=[UIColor yellowColor].CGColor;
    }else{
    imageView.layer.borderColor=[UIColor redColor].CGColor;
    }
    imageView.image=image;
    [view addSubview:imageView ];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, view.frame.size.width+5, view.frame.size.width, 20);
    nameLabel.text=nameStr;
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor=[UIColor redColor];
    nameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:nameLabel];
    
    
    if (view.tag==3809) {
        self.otherImageView=imageView;
        self.otherNameLabel=nameLabel;
        nameLabel.textColor=[UIColor yellowColor];
    }
    
    
}

//平局让杆
-(void)addTheDrawToWinView:(UIView *)view
{
    [self layoutSubviews];
//    
//    UILabel *textLabel=[[UILabel alloc] init];
//    textLabel.frame=CGRectMake(0, 0, view.frame.size.width, 20);
//    textLabel.text=@"平局谁获胜？";
//    textLabel.textAlignment=NSTextAlignmentCenter;
//    [view addSubview:textLabel];
    
    UIButton *button1=[[UIButton alloc] init];
    button1.frame=CGRectMake(0, 0, SCREEN_WIDTH/2, view.frame.size.height) ;
    [button1 addTarget:self action:@selector(clickTheButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button1];
    self.button1=button1;
    
        //添加button1上的内容
    UIImageView *personImage1=[[UIImageView alloc] init];
    //personImage.backgroundColor=[UIColor redColor];
    personImage1.frame=CGRectMake((SCREEN_WIDTH/2-80)/2, 10, 80, 80);
    personImage1.layer.cornerRadius=40;
    personImage1.layer.masksToBounds=YES;
    personImage1.layer.borderWidth=2;
    personImage1.layer.borderColor=[UIColor whiteColor].CGColor;
    personImage1.image=self.personImage;
    [button1 addSubview:personImage1];
    self.meImage1=personImage1;
    
    
    //名字
    UILabel *nameLabel1=[[UILabel alloc] init];
    nameLabel1.frame=CGRectMake(0, 95, SCREEN_WIDTH/2, 20);
    nameLabel1.text=self.personName;
    nameLabel1.textAlignment=NSTextAlignmentCenter;
    nameLabel1.textColor=[UIColor whiteColor];
    [button1 addSubview:nameLabel1];
    self.meLabel1=nameLabel1;
    
    //胜利的图片
    UIImageView *winImage=[[UIImageView alloc] init];
    winImage.frame=CGRectMake(SCREEN_WIDTH/2-31-5, 5, 31, 31);
    winImage.image=[UIImage imageNamed:@"pingjun_xuanzhong"];
    [button1 addSubview:winImage];
    self.winImage=winImage;
    

    UIButton *button2=[[UIButton alloc] init];
    
    button2.frame=CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, view.frame.size.height) ;
    [button2 addTarget:self action:@selector(clickTheButton2:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    self.button2=button2;
    
    //添加button2上的内容
    UIImageView *personImage2=[[UIImageView alloc] init];
    personImage2.backgroundColor=[UIColor redColor];
    personImage2.frame=CGRectMake((SCREEN_WIDTH/2-80)/2, 10, 80, 80);
    personImage2.layer.cornerRadius=40;
    personImage2.layer.masksToBounds=YES;
    personImage2.layer.borderWidth=2;
    personImage2.layer.borderColor=[UIColor yellowColor].CGColor;

    personImage2.image=self.otherImageView.image;
    [button2 addSubview:personImage2];
    self.otherImage2=personImage2;
    
    
    //名字
    UILabel *nameLabel2=[[UILabel alloc] init];
    nameLabel2.frame=CGRectMake(0, 95, SCREEN_WIDTH/2, 20);
    nameLabel2.text=self.otherNameLabel.text;
    [button2 addSubview:nameLabel2];
    nameLabel2.textAlignment=NSTextAlignmentCenter;
    self.personLabel2=nameLabel2;
    self.otherLabel2=nameLabel2;
    
    //胜利的图片
    UIImageView *winImage2=[[UIImageView alloc] init];
    winImage2.frame=CGRectMake(SCREEN_WIDTH/2-31-5, 5, 31, 31);
    winImage2.image=[UIImage imageNamed:@"pingjun_xuanzhong"];
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
    
    self.meImage1.layer.borderColor=[UIColor redColor].CGColor;
    self.meLabel1.textColor=[UIColor redColor];
    
    self.otherImage2.layer.borderColor=[UIColor whiteColor].CGColor;
    self.otherLabel2.textColor=[UIColor blackColor];
    
     [self switchAction:nil];
   
}

-(void)clickTheButton1:(UIButton *)button
{
    self.whoWin=1;
    [self.button2 setBackgroundColor:[UIColor whiteColor]];
    [self.button1 setBackgroundColor:[UIColor redColor]];
    self.winImage2.hidden=YES;
    
    self.meImage1.layer.borderColor=[UIColor whiteColor].CGColor;
    self.meLabel1.textColor=[UIColor whiteColor];
    
    self.otherImage2.layer.borderColor=[UIColor yellowColor].CGColor;
    self.otherLabel2.textColor=[UIColor yellowColor];


    self.winImage.hidden=NO;
    
    [self switchAction:nil];
}

-(void)addView:(UIView *)view andNameLabelText:(NSString *)nameStr
{
    [self layoutSubviews];
    
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
                [self layoutSubviews];
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
                [self layoutSubviews];
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
    
//    NSData *image= UIImagePNGRepresentation(self.personImage);
//    NSMutableDictionary *userDict=[NSMutableDictionary dictionary];
//    userDict[@"isUser"]=@(1);
//    userDict[@"name"]=self.personName;
//    userDict[@"personImage"]=image;
//    self.userDict=userDict;
//    
//    
//    UIImageView *image1;
//    UILabel *label1;
//    for (id view in self.rivalView.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            image1=view;
//        }
//        if ([view isKindOfClass:[UILabel class]]) {
//            label1=view;
//        }
//        
//    }
//   // ZCLog(@"%@",label1.text);
//    
//    NSData *image2= UIImagePNGRepresentation(image1.image);
//    NSMutableDictionary *otherDict=[NSMutableDictionary dictionary];
//    otherDict[@"isUser"]=@(0);
//    otherDict[@"name"]=label1.text;
//    otherDict[@"personImage"]=image2;
//    self.otherDict=otherDict;
//
    
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
    
    self.scollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGFloat bjImageX=10;
    CGFloat bjImageY=22;
    CGFloat bjImageW=SCREEN_WIDTH-bjImageX*2;
    CGFloat bjImageH=135;
    self.bjImage.frame=CGRectMake(bjImageX, bjImageY, bjImageW, bjImageH);
    
    
    CGFloat personViewX=26;
    CGFloat personViewY=24;
    CGFloat personViewW=68;
    CGFloat personViewH=bjImageH-2*personViewY;
    self.personView.frame=CGRectMake(personViewX, personViewY, personViewW, personViewH);
    
    
    CGFloat vsW=47;
    CGFloat vsH=20;
    CGFloat vsX=(bjImageW-vsW)/2;
    CGFloat vsY=(bjImageH-vsH)/2;
    self.VS.frame=CGRectMake(vsX, vsY, vsW, vsH);
    
    
    CGFloat rivalViewW=personViewW;
    CGFloat rivalViewH=personViewH;
    CGFloat rivalViewX=bjImageW-rivalViewW-26;
    CGFloat rivalViewY=personViewY;
    self.rivalView.frame=CGRectMake(rivalViewX, rivalViewY, rivalViewW, rivalViewH);
    
    
    CGFloat firstViewY=bjImageY+bjImageH+23;
    self.firstView.frame=CGRectMake(0,firstViewY, SCREEN_WIDTH, 40);
    
    CGFloat secondViewY=firstViewY+40+1;
    self.secondView.frame=CGRectMake(0, secondViewY, SCREEN_WIDTH, 40);
    
    CGFloat thirdViewY=secondViewY+40+1;
    self.thirdView.frame=CGRectMake(0, thirdViewY, SCREEN_WIDTH, 40);
    
    CGFloat fourthViewY=thirdViewY+40+1;
    self.fourthView.frame=CGRectMake(0, fourthViewY, SCREEN_WIDTH, 40);
    
    
    CGFloat fifthViewY=fourthViewY+40+1;
    self.fifthView.frame=CGRectMake(0, fifthViewY, SCREEN_WIDTH, 40);
    
    CGFloat drawToWinViewY=fifthViewY+40+30;
    self.drawToWinView.frame=CGRectMake(0, drawToWinViewY, SCREEN_WIDTH, 118);
    
    if (self.isOpen5) {
        self.scollView.contentSize = CGSizeMake(0,drawToWinViewY+150 );
    }else
    {
    self.scollView.contentSize = CGSizeMake(0,fifthViewY+100 );
    }
    

}

@end
