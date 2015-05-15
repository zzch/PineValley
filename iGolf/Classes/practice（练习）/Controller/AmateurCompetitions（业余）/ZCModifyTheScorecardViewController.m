//
//  ZCModifyTheScorecardViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/3/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCModifyTheScorecardViewController.h"
#import "ZCScorecard.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "UIBarButtonItem+DC.h"
#import "MBProgressHUD+NJ.h"
@interface ZCModifyTheScorecardViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
//总杆数 加号
@property(weak,nonatomic) UIButton *totalLabelAddButton;

//总杆数 减号
@property(weak,nonatomic) UIButton *totalLabelMinusButton;

//推杆数 加号
@property(weak,nonatomic) UIButton *pushLabelAddButton;

//推杆数 减号
@property(weak,nonatomic) UIButton *pushLabelMinusButton;

//推杆数 加号
@property(weak,nonatomic) UIButton *punishAddButton;

//推杆数 减号
@property(weak,nonatomic) UIButton *punishMinusButton;

//总杆数VIew
@property (weak, nonatomic)  UIView *totalView;
//推杆数名称
@property (weak, nonatomic)  UIView *pushLabelView;
//推杆数名称
@property (weak, nonatomic)  UIView *punishLabelView;
////距离数名称
@property (weak, nonatomic)  UIView *distanceView;
//pickView

@property (weak, nonatomic)  UIView *pickerView;


//总杆数
@property (weak, nonatomic)  UILabel *totalLabel;
//推杆
@property (weak, nonatomic)  UILabel *pushLabel;
//罚杆
@property (weak, nonatomic)  UILabel *punish;
//总杆数
@property(nonatomic,assign) int count;
//推杆数
@property(nonatomic,assign) int pushcount;
//罚杆数
@property(nonatomic,assign) int punishcount;

//距离
@property (weak, nonatomic)  UILabel *distanceLabel;
//命中
@property (weak, nonatomic)  UILabel *hitLabel;

@property (strong,nonatomic) NSArray *pickArray;
@property (weak, nonatomic)  UIPickerView *pickView;
//是否改变值
@property (nonatomic, assign, getter = isEditor) BOOL editor;

@end

@implementation ZCModifyTheScorecardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:[NSString stringWithFormat:@"%@洞",self.scorecard.number]];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;

    
    
    //加载控件
    [self loadLontrol];
    
    [self defaultData];
    
    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveOtherView)];
    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;
    

//    //返回按钮
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 31, 18);
//    
//    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"fanhui-anxia"] forState:UIControlStateHighlighted];
//    [backBtn addTarget:self action:@selector(dataToModify) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//   
//    self.navigationItem.leftBarButtonItem = backItem;dataToModify
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(dataToModify:) target:self];
    

//    // 修改返回按钮
//    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia-anxia" action:@selector(dataToModify:) target:self];
    //注册观察者
    [self registeredObservers];

    
}



//加载控件
-(void)loadLontrol
{
    //创建总杆view
    UIView *totalView=[[UIView alloc] init];
    //totalView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    CGFloat  totalViewX=0;
    CGFloat  totalViewY=0;
    CGFloat  totalViewW=SCREEN_WIDTH;//self.view.frame.size.width*0.3125;
    CGFloat  totalViewH=60;//SCREEN_WIDTH*0.1056;//self.view.frame.size.height*0.1056;
    totalView.frame=CGRectMake(totalViewX, totalViewY, totalViewW, totalViewH);
    [self.view addSubview:totalView];
    self.totalView=totalView;
    
    UIView *bjView1=[[UIView alloc] init];
    bjView1.frame=CGRectMake(0, totalViewY+totalViewH, SCREEN_WIDTH, 1);
    bjView1.backgroundColor=ZCColor(136, 119, 73);
    [self.view addSubview:bjView1];
    [self totalViewContent];
    
    
    
    //创建推杆View
    UIView *pushLabelView=[[UIView alloc] init];
    
    CGFloat  pushLabelViewX=totalViewX;
    CGFloat  pushLabelViewY=bjView1.frame.size.height+bjView1.frame.origin.y;
    CGFloat  pushLabelViewW=totalViewW;
    CGFloat  pushLabelViewH=totalViewH;
    pushLabelView.frame=CGRectMake(pushLabelViewX, pushLabelViewY, pushLabelViewW, pushLabelViewH);
    // pushLabelView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    [self.view addSubview:pushLabelView];
    
    UIView *bjView2=[[UIView alloc] init];
    bjView2.frame=CGRectMake(0, pushLabelViewY+pushLabelViewH, SCREEN_WIDTH, 1);
    bjView2.backgroundColor=ZCColor(136, 119, 73);
    [self.view addSubview:bjView2];

    
    self.pushLabelView=pushLabelView;
    
    //推杆view里的内容
    [self pushLabelViewContent];
    
    //创建罚杆View
    UIView *punishLabelView=[[UIView alloc] init];
    CGFloat  punishLabelViewX=pushLabelViewX;
    CGFloat  punishLabelViewY=bjView2.frame.origin.y+bjView2.frame.size.height;
    CGFloat  punishLabelViewW=pushLabelViewW;
    CGFloat  punishLabelViewH=pushLabelViewH;
    punishLabelView.frame=CGRectMake(punishLabelViewX, punishLabelViewY, punishLabelViewW, punishLabelViewH);
   // punishLabelView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    [self.view addSubview:punishLabelView];
    self.punishLabelView=punishLabelView;
    
    
    UIView *bjView3=[[UIView alloc] init];
    bjView3.frame=CGRectMake(0, punishLabelViewY+punishLabelViewH, SCREEN_WIDTH, 1);
    bjView3.backgroundColor=ZCColor(136, 119, 73);
    [self.view addSubview:bjView3];

    
    //创建罚杆View
    [self punishLabelViewContent];
    
    
    
    //创建开球显示属性的View
    
    UIView *distanceView=[[UIView alloc] init];
    CGFloat  distanceViewX=totalViewX;
    CGFloat  distanceViewY=bjView3.frame.size.height+bjView3.frame.origin.y;
    CGFloat  distanceViewW=totalViewW;
    CGFloat  distanceViewH=75;//SCREEN_HEIGHT*0.132;
    distanceView.frame=CGRectMake(distanceViewX, distanceViewY, distanceViewW, distanceViewH);
    //distanceView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"A5dong_kaiqiujuli_beijing"]];
    [self.view addSubview:distanceView];
    self.distanceView=distanceView;
    //创建显示成绩的内容
     [self distanceViewContent];
    
    UIView *bjView4=[[UIView alloc] init];
    bjView4.frame=CGRectMake(0, distanceViewY+distanceViewH, SCREEN_WIDTH, 1);
    bjView4.backgroundColor=ZCColor(136, 119, 73);
    [self.view addSubview:bjView4];

    
    
    
    //创建pickviec
    UIView *pickerView=[[UIView alloc] init];
    
    CGFloat  pickViewY=bjView4.frame.size.height+bjView4.frame.origin.y+20;
    CGFloat  pickViewW=SCREEN_WIDTH;
    CGFloat  pickViewH=SCREEN_HEIGHT-pickViewY;
    CGFloat  pickViewX=30;
    pickerView.frame=CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
    //pickerView.backgroundColor=ZCColor(23, 25, 28);
    [self.view addSubview:pickerView];
    self.pickerView=pickerView;
    

//创建pickview
    [self pickerViewContent];
    

}

//创建pickview
-(void)pickerViewContent
{
    //创建pickview
    
    UIPickerView *pickView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickView.delegate=self;
    pickView.dataSource = self;
    //pickView.tintColor=[UIColor whiteColor];
    CGFloat pickViewW=200;
    CGFloat pickViewH=160;
    CGFloat pickViewX=(self.pickerView.frame.size.width-pickViewW)/2-40;
    CGFloat pickViewY=10;
    pickView.frame = CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
    pickView.showsSelectionIndicator = YES;
    self.pickView=pickView;
    [self.pickerView addSubview:pickView ];
    
    
}


//创建显示成绩的页面
-(void)distanceViewContent
{
    UILabel *distanceLabelName=[[UILabel alloc] init];
    CGFloat distanceLabelNameX=self.distanceView.frame.size.width*0.152;
    CGFloat distanceLabelNameY=self.distanceView.frame.size.height*0.22;
    CGFloat distanceLabelNameW=70;
    CGFloat distanceLabelNameH=20;
    distanceLabelName.frame=CGRectMake(distanceLabelNameX, distanceLabelNameY, distanceLabelNameW, distanceLabelNameH);
    distanceLabelName.text=@"开球距离";
    distanceLabelName.textAlignment=NSTextAlignmentCenter;
    distanceLabelName.textColor=ZCColor(240, 208, 122);
    [self.distanceView addSubview:distanceLabelName];
    
    //显示值
    UILabel *distanceLabel=[[UILabel alloc] init];
    CGFloat distanceLabelX=distanceLabelNameX;
    CGFloat distanceLabelY=distanceLabelNameY+distanceLabelNameH+self.distanceView.frame.size.height*0.1;
    
    CGFloat distanceLabelW=70;
    CGFloat distanceLabelH=20;
    distanceLabel.frame=CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
    distanceLabel.textColor=ZCColor(240, 208, 122);
    distanceLabel.textAlignment=NSTextAlignmentCenter;
    
    self.distanceLabel=distanceLabel;
    [self.distanceView addSubview:distanceLabel];
    
    
    //命中
    UILabel *hitLabelName=[[UILabel alloc] init];
    CGFloat hitLabelNameW=70;
    CGFloat hitLabelNameH=20;
    CGFloat hitLabelNameX=self.distanceView.frame.size.width-distanceLabelNameX-hitLabelNameW;
    CGFloat hitLabelNameY=distanceLabelNameY;
    
    hitLabelName.frame=CGRectMake(hitLabelNameX, hitLabelNameY, hitLabelNameW, hitLabelNameH);
    hitLabelName.text=@"开球命中";
    hitLabelName.textAlignment=NSTextAlignmentCenter;
    hitLabelName.textColor=ZCColor(240, 208, 122);
    [self.distanceView addSubview:hitLabelName];
    
    //显示值
    UILabel *hitLabel=[[UILabel alloc] init];
    CGFloat hitLabelX=hitLabelNameX;
    CGFloat hitLabelY=distanceLabelY;
    
    CGFloat hitLabelW=70;
    CGFloat hitLabelH=20;
    hitLabel.frame=CGRectMake(hitLabelX, hitLabelY, hitLabelW, hitLabelH);
    hitLabel.textColor=ZCColor(240, 208, 122);
    hitLabel.textAlignment=NSTextAlignmentCenter;
    
    self.hitLabel=hitLabel;
    [self.distanceView addSubview:hitLabel];


}



//添加罚杆里的内容
-(void)punishLabelViewContent
{
    UILabel *totalLabelName=[[UILabel alloc] init];
    CGFloat  totalLabelNameX=0;
    CGFloat  totalLabelNameY=0;
    CGFloat  totalLabelNameW=self.punishLabelView.frame.size.width*0.3125;
    CGFloat  totalLabelNameH=self.punishLabelView.frame.size.height;
    totalLabelName.frame=CGRectMake(totalLabelNameX, totalLabelNameY, totalLabelNameW, totalLabelNameH);
    totalLabelName.text=@"罚杆数";
    totalLabelName.textAlignment=NSTextAlignmentCenter;
    totalLabelName.font=[UIFont systemFontOfSize:22];
    totalLabelName.textColor=ZCColor(240, 208, 122);
    [self.punishLabelView addSubview:totalLabelName ];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(totalLabelNameW, 0, 1, totalLabelNameH);
    //UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"A5dong_shuxian"]];
    bjView.backgroundColor=ZCColor(136, 119, 73);
    [self.punishLabelView addSubview:bjView];
    
    //创建减号
    UIButton *totalLabelMinusButton=[[UIButton alloc] init];
    CGFloat  totalLabelMinusButtonX=self.punishLabelView.frame.size.width*0.06+totalLabelNameW+1;
    
    CGFloat  totalLabelMinusButtonW=29;
    CGFloat  totalLabelMinusButtonH=30;
    CGFloat  totalLabelMinusButtonY=(self.punishLabelView.frame.size.height-totalLabelMinusButtonW)*0.5;
    totalLabelMinusButton.frame=CGRectMake(totalLabelMinusButtonX, totalLabelMinusButtonY, totalLabelMinusButtonW, totalLabelMinusButtonH);
    [totalLabelMinusButton setImage:[UIImage imageNamed:@"jianshao"] forState:UIControlStateNormal];
    //[totalLabelMinusButton setImage:[UIImage imageNamed:@"A5dong_jianshao_anxia"] forState:UIControlStateHighlighted];
    [self.punishLabelView addSubview:totalLabelMinusButton];
    [totalLabelMinusButton addTarget:self action:@selector(punishReduction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创罚杆杆数成绩label
    UILabel *punish=[[UILabel alloc] init];
    punish.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"shujudong"]];
    CGFloat totalLabelX=totalLabelMinusButtonX+totalLabelMinusButtonW+self.pushLabelView.frame.size.width*0.1;
    CGFloat totalLabelW=36;
    CGFloat totalLabelH=36;
    CGFloat totalLabelY=(self.punishLabelView.frame.size.height-totalLabelW)*0.5;
    punish.frame=CGRectMake(totalLabelX, totalLabelY, totalLabelW, totalLabelH);
    
    punish.textColor=ZCColor(240, 208, 122);
    punish.textAlignment=NSTextAlignmentCenter;
    self.punish=punish;
    [self.punishLabelView addSubview:punish];
    
    //创建加号按钮
    UIButton *totalLabelAddButton=[[UIButton alloc] init];
    CGFloat  totalLabelAddButtonX=self.punishLabelView.frame.size.width*0.1+totalLabelX+totalLabelW;
    
    CGFloat  totalLabelAddButtonW=29;//self.punishLabelView.frame.size.width*0.09;
    CGFloat  totalLabelAddButtonH=30;//self.punishLabelView.frame.size.height*0.483;
    CGFloat  totalLabelAddButtonY=(self.punishLabelView.frame.size.height-totalLabelAddButtonW)*0.5;
    totalLabelAddButton.frame=CGRectMake(totalLabelAddButtonX, totalLabelAddButtonY, totalLabelAddButtonW, totalLabelAddButtonH);
    [totalLabelAddButton setImage:[UIImage imageNamed:@"tiejia"] forState:UIControlStateNormal];
   // [totalLabelAddButton setImage:[UIImage imageNamed:@"A5dong_zengjia_anxia"] forState:UIControlStateHighlighted];
    
    [self.punishLabelView addSubview:totalLabelAddButton];
    
    [totalLabelAddButton addTarget:self action:@selector(punishAdd) forControlEvents:UIControlEventTouchUpInside];
    

}
//推杆的内容
-(void)pushLabelViewContent
{
    UILabel *totalLabelName=[[UILabel alloc] init];
    CGFloat  totalLabelNameX=0;
    CGFloat  totalLabelNameY=0;
    CGFloat  totalLabelNameW=self.pushLabelView.frame.size.width*0.3125;
    CGFloat  totalLabelNameH=self.pushLabelView.frame.size.height;
    totalLabelName.frame=CGRectMake(totalLabelNameX, totalLabelNameY, totalLabelNameW, totalLabelNameH);
    totalLabelName.text=@"推杆数";
    totalLabelName.textAlignment=NSTextAlignmentCenter;
    totalLabelName.font=[UIFont systemFontOfSize:22];
    totalLabelName.textColor=ZCColor(240, 208, 122);
    [self.pushLabelView addSubview:totalLabelName ];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(totalLabelNameW, 0, 1, totalLabelNameH);
    //UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"A5dong_shuxian"]];
    bjView.backgroundColor=ZCColor(136, 119, 73);
    [self.pushLabelView addSubview:bjView];
    
    //创建减号
    UIButton *totalLabelMinusButton=[[UIButton alloc] init];
    CGFloat  totalLabelMinusButtonX=self.pushLabelView.frame.size.width*0.06+totalLabelNameW+1;
    
    CGFloat  totalLabelMinusButtonW=29;
    CGFloat  totalLabelMinusButtonH=30;
    CGFloat  totalLabelMinusButtonY=(self.pushLabelView.frame.size.height-totalLabelMinusButtonW)*0.5;
    totalLabelMinusButton.frame=CGRectMake(totalLabelMinusButtonX, totalLabelMinusButtonY, totalLabelMinusButtonW, totalLabelMinusButtonH);
    [totalLabelMinusButton setImage:[UIImage imageNamed:@"jianshao"] forState:UIControlStateNormal];
  //  [totalLabelMinusButton setImage:[UIImage imageNamed:@"A5dong_jianshao_anxia"] forState:UIControlStateHighlighted];
    [self.pushLabelView addSubview:totalLabelMinusButton];
    [totalLabelMinusButton addTarget:self action:@selector(pushReduction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建推杆数成绩label
    UILabel *pushLabel=[[UILabel alloc] init];
    pushLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"shujudong"]];
    CGFloat totalLabelX=totalLabelMinusButtonX+totalLabelMinusButtonW+self.pushLabelView.frame.size.width*0.1;
    CGFloat totalLabelW=36;
    CGFloat totalLabelH=36;
    CGFloat totalLabelY=(self.pushLabelView.frame.size.height-totalLabelW)*0.5;
    pushLabel.frame=CGRectMake(totalLabelX, totalLabelY, totalLabelW, totalLabelH);
    
    pushLabel.textColor=ZCColor(240, 208, 122);
    pushLabel.textAlignment=NSTextAlignmentCenter;
    self.pushLabel=pushLabel;
    [self.pushLabelView addSubview:pushLabel];
    
    //创建加号按钮
    UIButton *totalLabelAddButton=[[UIButton alloc] init];
    CGFloat  totalLabelAddButtonX=self.pushLabelView.frame.size.width*0.1+totalLabelX+totalLabelW;
    
    CGFloat  totalLabelAddButtonW=29;//self.pushLabelView.frame.size.width*0.09;
    CGFloat  totalLabelAddButtonH=30;//self.pushLabelView.frame.size.height*0.483;
    CGFloat  totalLabelAddButtonY=(self.pushLabelView.frame.size.height-totalLabelAddButtonW)*0.5;
    totalLabelAddButton.frame=CGRectMake(totalLabelAddButtonX, totalLabelAddButtonY, totalLabelAddButtonW, totalLabelAddButtonH);
    [totalLabelAddButton setImage:[UIImage imageNamed:@"tiejia"] forState:UIControlStateNormal];
   // [totalLabelAddButton setImage:[UIImage imageNamed:@"A5dong_zengjia_anxia"] forState:UIControlStateHighlighted];
    
    [self.pushLabelView addSubview:totalLabelAddButton];
    
    [totalLabelAddButton addTarget:self action:@selector(pushAdd) forControlEvents:UIControlEventTouchUpInside];


}


//总干里面的内容
-(void)totalViewContent
{
    UILabel *totalLabelName=[[UILabel alloc] init];
    CGFloat  totalLabelNameX=0;
    CGFloat  totalLabelNameY=0;
    CGFloat  totalLabelNameW=self.totalView.frame.size.width*0.3125;
    CGFloat  totalLabelNameH=self.totalView.frame.size.height;
    totalLabelName.frame=CGRectMake(totalLabelNameX, totalLabelNameY, totalLabelNameW, totalLabelNameH);
    totalLabelName.text=@"总杆数";
    totalLabelName.textAlignment=NSTextAlignmentCenter;
    totalLabelName.font=[UIFont systemFontOfSize:22];
    totalLabelName.textColor=ZCColor(240, 208, 122);
    [self.totalView addSubview:totalLabelName ];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(totalLabelNameW, 0, 1, totalLabelNameH);
   // UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"A5dong_shuxian"]];
    bjView.backgroundColor=ZCColor(136, 119, 73);
    [self.totalView addSubview:bjView];
    
    //创建减号
    UIButton *totalLabelMinusButton=[[UIButton alloc] init];
    CGFloat  totalLabelMinusButtonX=self.totalView.frame.size.width*0.06+totalLabelNameW+1;
    
    CGFloat  totalLabelMinusButtonW=29;
    CGFloat  totalLabelMinusButtonH=30;
    CGFloat  totalLabelMinusButtonY=(self.totalView.frame.size.height-totalLabelMinusButtonW)*0.5;
    totalLabelMinusButton.frame=CGRectMake(totalLabelMinusButtonX, totalLabelMinusButtonY, totalLabelMinusButtonW, totalLabelMinusButtonH);
    [totalLabelMinusButton setImage:[UIImage imageNamed:@"jianshao"] forState:UIControlStateNormal];
   // [totalLabelMinusButton setImage:[UIImage imageNamed:@"A5dong_jianshao_anxia"] forState:UIControlStateHighlighted];
    [self.totalView addSubview:totalLabelMinusButton];
    [totalLabelMinusButton addTarget:self action:@selector(totaReduction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建总杆数成绩label
    UILabel *totalLabel=[[UILabel alloc] init];
    totalLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"shujudong"]];
    CGFloat totalLabelX=totalLabelMinusButtonX+totalLabelMinusButtonW+self.totalView.frame.size.width*0.1;
    CGFloat totalLabelW=36;
    CGFloat totalLabelH=36;
    CGFloat totalLabelY=(self.totalView.frame.size.height-totalLabelW)*0.5;
    totalLabel.frame=CGRectMake(totalLabelX, totalLabelY, totalLabelW, totalLabelH);
    
    totalLabel.textColor=ZCColor(240, 208, 122);
    totalLabel.textAlignment=NSTextAlignmentCenter;
     self.totalLabel=totalLabel;
    [self.totalView addSubview:totalLabel];
    
    //创建加号按钮
    UIButton *totalLabelAddButton=[[UIButton alloc] init];
    CGFloat  totalLabelAddButtonX=self.totalView.frame.size.width*0.1+totalLabelX+totalLabelW;
    
    CGFloat  totalLabelAddButtonW=29;//self.totalView.frame.size.width*0.09;
    CGFloat  totalLabelAddButtonH=30;//self.totalView.frame.size.height*0.483;
    CGFloat  totalLabelAddButtonY=(self.totalView.frame.size.height-totalLabelAddButtonW)*0.5;
    totalLabelAddButton.frame=CGRectMake(totalLabelAddButtonX, totalLabelAddButtonY, totalLabelAddButtonW, totalLabelAddButtonH);
    [totalLabelAddButton setImage:[UIImage imageNamed:@"tiejia"] forState:UIControlStateNormal];
    //[totalLabelAddButton setImage:[UIImage imageNamed:@"A5dong_zengjia_anxia"] forState:UIControlStateHighlighted];

    [self.totalView addSubview:totalLabelAddButton];
    
    [totalLabelAddButton addTarget:self action:@selector(totalAdd) forControlEvents:UIControlEventTouchUpInside];
}





//总杆数 点击加号
- (void)totalAdd {
    
    self.count++;
    //   self.count=self.pushcount+(self.punishcount) +1;
    self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    //点击后值是否改变
    
    
}
//总杆数 点击减号
- (void)totaReduction {
    if (self.count>1) {
        self.count--;
        
        if (self.count<(self.pushcount+(self.punishcount)*2)+1) {
            if (self.punishcount==0) {
                self.pushcount--;
                self.pushLabel.text=[NSString stringWithFormat:@"%d",self.pushcount];
            }else
            {
                self.punishcount--;
                self.punish.text=[NSString stringWithFormat:@"%d",self.punishcount];
            }
        }
        
    }
    
    
    self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    
    
    
}
//推杆数 点击加号
- (void)pushAdd {
    
    //    if (self.pushcount<=self.count-(self.punishcount*2)-1) {
    //        self.pushcount++;
    //    }else{
    //        //self.pushcount=10;
    //    }
    self.pushcount++;
    self.pushLabel.text=[NSString stringWithFormat:@"%d",self.pushcount];
    
    //
    if (self.count<(self.pushcount+(self.punishcount)*2)+1) {
        self.count=(self.pushcount+(self.punishcount)*2)+1;
        self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
    
    
}
//推杆数 点击减号
- (void)pushReduction {
    
    if (self.pushcount>0) {
        self.pushcount--;
    }else{
        self.pushcount=0;
    }
    
    self.pushLabel.text=[NSString stringWithFormat:@"%d",self.pushcount];
    
}
//罚杆数 点击加号
- (void)punishAdd {
    
    //    if (self.punishcount) {
    //        self.punishcount++;
    //    }else{
    //       // self.punishcount=10;
    //    }
    self.punishcount++;
    self.punish.text=[NSString stringWithFormat:@"%d",self.punishcount];
    
    
    if (self.count<(self.pushcount+(self.punishcount)*2)+1) {
        self.count=(self.pushcount+(self.punishcount)*2)+1;
        self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
    
    
}
//罚杆数 点击减号
- (void)punishReduction {
    if (self.punishcount>0) {
        self.punishcount--;
    }else{
        self.punishcount=0;
    }
    
    self.punish.text=[NSString stringWithFormat:@"%d",self.punishcount];
}


//注册观察者
-(void)registeredObservers
{
    [self.totalLabel addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
    [self.pushLabel addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
    [self.punish addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
    [self.distanceLabel addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
    [self.hitLabel addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
    
}

-(void)dealloc
{
    // 移除观察者
    [self.totalLabel removeObserver:self forKeyPath:@"text"];
    [self.pushLabel removeObserver:self forKeyPath:@"text"];
    [self.punish removeObserver:self forKeyPath:@"text"];
    [self.distanceLabel removeObserver:self forKeyPath:@"text"];
    [self.hitLabel removeObserver:self forKeyPath:@"text"];
    
}
//pickView到这个界面的默认值
-(void)pickerViewDefaultData
{
    [self pickerView:nil didSelectRow:40 inComponent:0];
    [self.pickView selectRow:40 inComponent:0 animated:YES];
    
    [self pickerView:nil didSelectRow:1 inComponent:1];
    [self.pickView selectRow:1 inComponent:1 animated:YES];
    
}


//判断<nill> 和（null）转换
- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}


//push到这个界面的默认值
-(void)defaultData
{
    ZCLog(@"%@",[self _valueOrNil:self.scorecard.score]);
   
    
    
    
    if ([self _valueOrNil:self.scorecard.score]==nil) {
        
        if ([self.scorecard.par isEqual:@"3"]) {
            self.totalLabel.text=@"3";
            
            self.punish.text=@"0";
            self.punishcount=0;
            self.pushLabel.text=@"2";
            self.pushcount=2;
            [self pickerViewDefaultData];
            
            self.count=3;
            self.punishcount=0;
            
        }else if ([self.scorecard.par isEqual:@"4"])
        {
            self.totalLabel.text=@"4";
            self.punish.text=@"0";
            self.pushLabel.text=@"2";
            self.punishcount=0;
            self.pushcount=2;
            self.count=4;
            [self pickerViewDefaultData];
            
        }else
        {
            self.totalLabel.text=@"5";
            self.punish.text=@"0";
            self.pushLabel.text=@"2";
            self.punishcount=0;
            self.pushcount=2;
            self.count=5;
            [self pickerViewDefaultData];
        }
        
    }else
    {
        self.totalLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.score]   ;
        self.punish.text=[NSString stringWithFormat:@"%@",self.scorecard.penalties];
        self.pushLabel.text= [NSString stringWithFormat:@"%@",self.scorecard.putts];
        
        // self.distanceLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.distance_from_hole_to_tee_box];
        
        
        if ([self.scorecard.direction isEqual:@"hook"]) {
            self.hitLabel.text=@"左侧";
            //[self pickerView:nil didSelectRow:1 inComponent:1];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
        }else if([self.scorecard.direction isEqual:@"slice"])
        {
            self.hitLabel.text=@"右侧";
            [self.pickView selectRow:1 inComponent:1 animated:YES];
        }else
        {
            self.hitLabel.text=@"命中";
            [self.pickView selectRow:2 inComponent:1 animated:YES];
        }
        
        // self.hitLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.direction];
        ZCLog(@"%@",self.scorecard.driving_distance);
        
        int distance=[self.scorecard.driving_distance intValue]/5;
        
        ZCLog(@"%@",self.scorecard.driving_distance);
        [self pickerView:nil didSelectRow:distance inComponent:0];
        [self.pickView selectRow:distance inComponent:0 animated:YES];
        //        [self pickerView:nil didSelectRow:40 inComponent:0];
        //        [self.pickView selectRow:40 inComponent:0 animated:YES];
        
        self.punishcount=[self.scorecard.penalties intValue];
        self.pushcount=[self.scorecard.putts intValue];
        self.count=[self.scorecard.score intValue];
        
        
        
        
    }
}






//点击保存后调用
-(void)saveOtherView
{
    
    
    //加载圈圈
    [MBProgressHUD showMessage:@"数据保存中..."];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    
    
    
    
    
    params[@"token"]=account.token;
    params[@"uuid"]=self.scorecard.uuid;
    params[@"score"]=self.totalLabel.text;
    params[@"putts"]=self.punish.text;
    params[@"penalties"]=self.pushLabel.text;
    params[@"driving_distance"]=self.distanceLabel.text;
    if ([self.hitLabel.text isEqualToString: @"左侧"]) {
        params[@"direction"]=@"hook";
    }else if ([self.hitLabel.text isEqual:  @"右侧"])
    {
        params[@"direction"]=@"slice";
        
    }else{
        params[@"direction"]=@"pure";
        
    }
    ZCLog(@"%@", params[@"direction"]);
    ///v1/scorecards.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"scorecards/simple.json"];
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        [MBProgressHUD hideHUD];
        
        // 1.关闭当前控制器
        [self.navigationController popViewControllerAnimated:YES];
        // 2.传递数据给上一个控制器(ZCScorecardTableViewController)
        // 2.通知代理
        
        if ([self.delegate respondsToSelector:@selector(ZCZCFillViewController:didSaveScorecardt:)]) {
            
            self.scorecard.score=self.totalLabel.text;
            self.scorecard.putts=self.punish.text;
            self.scorecard.penalties=self.pushLabel.text;
            self.scorecard.driving_distance=self.distanceLabel.text;
            self.scorecard.direction=self.hitLabel.text;
            [self.delegate ZCZCFillViewController:self didSaveScorecardt:self.scorecard];
            
            
        }
        
        
        
        ZCLog(@"成功");
        
        ZCLog(@"1111111%@--",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    
    
}
//点击返回按钮
-(void)dataToModify:(UIButton *)bth
{
    
    if (self.editor) {
        [self alert];
    }else
    {
        // 1.关闭当前控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}


//观察者调用方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // ZCLog(@"%@",change[@"new"]);
    self.editor=YES;
    
}

-(void)alert
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您已修改数据是否保存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self saveOtherView];
    }
    
    // 按钮的索引肯定不是0
    
}


-(NSArray *)pickArray
{
    if (_pickArray==nil) {
        _pickArray=[NSArray array];
        NSMutableArray *pickArray1=[NSMutableArray array];
        for (int i = 0; i < 81; i ++) {
            [pickArray1 addObject:[NSString stringWithFormat:@"%d",i*5]];
        }
        
        
        NSArray *pickArray2=[NSArray array];
        pickArray2=@[@"左侧",@"右侧",@"命中"];
        
        _pickArray=@[pickArray1,pickArray2];
        
    }
    
    return _pickArray;
}


#pragma mark - 数据源方法


/**
 *  一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickArray.count;
    
    
}

/**
 *  第component列显示多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *subfoods = self.pickArray[component];
    return subfoods.count;
}


/**
 *  第component列的第row行显示什么文字
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickArray[component][row];
}


/**
 *  选中了第component列的第row行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { //
        self.distanceLabel.text = self.pickArray[component][row];
    } else if (component == 1) { //
        self.hitLabel.text = self.pickArray[component][row];
    }
}

//改变pickview的字体颜色

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if (component==0) {
        title = [NSString stringWithFormat:@"%@码",self.pickArray[component][row]];
    }else{
     title = [NSString stringWithFormat:@"%@",self.pickArray[component][row]];
    }
   
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:ZCColor(240, 208, 122)}];
    
    return attString;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component == 1)
        return 80;
    return 120;
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    
//        //第一列返回一个Label组件
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 72, 44)];
//        //label.backgroundColor = [UIColor greenColor];
//        label.textColor = ZCColor(240, 208, 122);
//        if (component==0) {
//            label.text = [NSString stringWithFormat:@"%@码",self.pickArray[component][row]];
//        }else{
//            label.text = [NSString stringWithFormat:@"%@",self.pickArray[component][row]];
//       
//        }
//        return label;
//    }
//


//-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    
//    return 100;
//}
//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
