//
//  ZCSetupModeViewController.m
//  iGolf
//
//  Created by hh on 15/7/20.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCSetupModeViewController.h"
#import "ZCHoleView.h"
#import "ZCFightTheLandlordView.h"
#import "ZCLasVegasView.h"
#import "ZCHoleViewController.h"
#import "ZCDoudizhuGameViewController.h"
#import "ZCLasVegasViewController.h"
#import "ZCDatabaseTool.h"
#import "ZCDouModel.h"
#import "ZCEditView.h"
#import "ZCPracticeVController.h"
#import "ZCHistoricalRecordTableViewController.h"
@interface ZCSetupModeViewController ()<ZCHoleViewDelegate,ZCFightTheLandlordViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZCEditViewDelegate,ZCLasVegasViewDelegate>
@property(nonatomic,weak)ZCHoleView *holeView;
@property(nonatomic,weak)ZCFightTheLandlordView *fightTheLandlordView;
@property(nonatomic,weak)ZCLasVegasView *lasVegasView;
@property(nonatomic,assign)int index;
//开关
@property(nonatomic,strong)NSMutableDictionary *switchDict;
@property(nonatomic,strong)NSMutableDictionary *fightTheLandlordDict;

@property(nonatomic,weak)ZCEditView *editView;


@property(nonatomic,weak)UIButton *holeBtn;
@property(nonatomic,weak)UIButton *landlordsBtn;
@property(nonatomic,weak)UIButton *lasVegasBtn;
@end

@implementation ZCSetupModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"娱乐模式";
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick) target:self];
    
        UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"历史" style:UIBarButtonItemStyleDone target:self action:@selector(switchOtherView)];
        self.navigationItem.rightBarButtonItem = newBar;
    
    
    [self addControls];
    
    
}

//点击历史
-(void)switchOtherView
{
    ZCHistoricalRecordTableViewController *vc=[[ZCHistoricalRecordTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

//返回
-(void)liftBthClick
{
    for (id vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ZCPracticeVController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }

}

//添加控件
-(void)addControls
{
    UIButton *holeBtn=[[UIButton alloc] init];
    CGFloat  holeBtnX=0;
    CGFloat  holeBtnY=0;
    CGFloat  holeBtnW=(SCREEN_WIDTH)/3;
    CGFloat  holeBtnH=40;
    holeBtn.frame=CGRectMake(holeBtnX, holeBtnY, holeBtnW, holeBtnH);
    
    [holeBtn setTitle:@"比洞" forState:UIControlStateNormal];
    
    [holeBtn setBackgroundImage:[UIImage imageNamed:@"xuanxiangka_bj"] forState:UIControlStateSelected];
    [holeBtn setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [holeBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [holeBtn addTarget:self action:@selector(clickTheHoleBtn) forControlEvents:UIControlEventTouchUpInside];
    holeBtn.selected=YES;
    [self.view addSubview:holeBtn];
    self.holeBtn=holeBtn;
    
    
    UIButton *landlordsBtn=[[UIButton alloc] init];
    CGFloat  landlordsBtnX=holeBtnW;
    CGFloat  landlordsBtnY=0;
    CGFloat  landlordsBtnW=(SCREEN_WIDTH)/3;
    CGFloat  landlordsBtnH=40;
    landlordsBtn.frame=CGRectMake(landlordsBtnX, landlordsBtnY, landlordsBtnW, landlordsBtnH);
    [landlordsBtn setTitle:@"斗地主" forState:UIControlStateNormal];
    [landlordsBtn setBackgroundImage:[UIImage imageNamed:@"xuanxiangka_bj"] forState:UIControlStateSelected];
    [landlordsBtn setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [landlordsBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [landlordsBtn addTarget:self action:@selector(clickTheLandlordsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landlordsBtn];
    self.landlordsBtn=landlordsBtn;
    
    UIButton *lasVegasBtn=[[UIButton alloc] init];
    CGFloat  lasVegasBtnX=holeBtnW+holeBtnW;
    CGFloat  lasVegasBtnY=0;
    CGFloat  lasVegasBtnW=(SCREEN_WIDTH)/3;
    CGFloat  lasVegasBtnH=40;
    lasVegasBtn.frame=CGRectMake(lasVegasBtnX, lasVegasBtnY, lasVegasBtnW, lasVegasBtnH);
    [lasVegasBtn setTitle:@"拉斯维加斯" forState:UIControlStateNormal];
    [lasVegasBtn setBackgroundImage:[UIImage imageNamed:@"xuanxiangka_bj"] forState:UIControlStateSelected];
    [lasVegasBtn setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [lasVegasBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [lasVegasBtn addTarget:self action:@selector(clickTheLasVegasBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lasVegasBtn];
    self.lasVegasBtn=lasVegasBtn;
    
    
    self.index=1;
    ZCHoleView *holeView=[[ZCHoleView alloc] init];
    //ZCFightTheLandlordView *holeView=[[ZCFightTheLandlordView alloc ] init];
    CGFloat holeViewX=0;
    CGFloat holeViewY=40;
    CGFloat holeViewW=SCREEN_WIDTH;
    CGFloat holeViewH=SCREEN_HEIGHT-150;
    holeView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
    holeView.delegate=self;
    [self.view addSubview:holeView];
    self.holeView=holeView;
    //让View 把默认值穿件来
    [self.holeView theDefaultValue];
    
   

    UIButton *startBtn=[[UIButton alloc] init];
    startBtn.backgroundColor=ZCColor(9, 133, 12);
    CGFloat startBtnX=0;
    CGFloat startBtnY=self.view.frame.size.height-108;
    CGFloat startBtnW=SCREEN_WIDTH;
    CGFloat startBtnH=45;
    startBtn.frame=CGRectMake(startBtnX, startBtnY, startBtnW, startBtnH);
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    
    
    
}

//点击开始
-(void)clickTheStartBtn
{
    
    
    if (self.index==1) {
        NSMutableArray *array=[self.holeView obtainCompetitorInformation];
        self.switchDict[@"playerArray"]=array;
        //创建比赛，讲比赛保存到数据库
        BOOL success=[ZCDatabaseTool ToCreateAGame:self.switchDict];
        if (success) {
            ZCHoleViewController *hole=[[ZCHoleViewController alloc] init];
            [self.navigationController pushViewController:hole animated:YES];
        }
        
      
      
        
    }else if (self.index==2)
    {
       NSMutableArray *array= [self.fightTheLandlordView obtainCompetitorInformation];
        self.fightTheLandlordDict[@"playerArray"]=array;
        //创建比赛，讲比赛保存到数据库
        BOOL success=[ZCDatabaseTool ToCreateDoudizhuGame:self.fightTheLandlordDict];
        if (success) {
            ZCDoudizhuGameViewController *vc=[[ZCDoudizhuGameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }else if (self.index==3)
    {
        //获得参赛者信息
        NSMutableArray *array=[self.lasVegasView obtainCompetitorInformation];
        //获得开关状态
        NSMutableDictionary *dict=[self.lasVegasView TheStateOfTheSwitch];
        dict[@"type"]=@(self.index);
        //创建比赛 ，保存比赛到数据库
        BOOL success=[ZCDatabaseTool createALasVegasGame:array andSwitch:dict ];
        if (success) {
            ZCLasVegasViewController *vc=[[ZCLasVegasViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}


//比洞模式
-(void)clickTheHoleBtn
{
    self.holeBtn.selected=YES;
    self.landlordsBtn.selected=NO;
    self.lasVegasBtn.selected=NO;
    self.index=1;
    self.holeView.hidden=NO;
    self.fightTheLandlordView.hidden=YES;
    self.lasVegasView.hidden=YES;
}


//斗地主模式
-(void)clickTheLandlordsBtn
{
    self.holeBtn.selected=NO;
    self.landlordsBtn.selected=YES;
    self.lasVegasBtn.selected=NO;
    self.index=2;
    if (self.fightTheLandlordView==nil) {
        self.holeView.hidden=YES;
        self.lasVegasView.hidden=YES;
        ZCFightTheLandlordView *fightTheLandlordView=[[ZCFightTheLandlordView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=40;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT-150;
        fightTheLandlordView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
        [self.view addSubview:fightTheLandlordView];
        fightTheLandlordView.delegate=self;
        //让View 把默认值穿件来
        [fightTheLandlordView theDefaultValue];
        self.fightTheLandlordView=fightTheLandlordView;

    }else
    {
      self.holeView.hidden=YES;
        self.lasVegasView.hidden=YES;
      self.fightTheLandlordView.hidden=NO;
    }
    
}


//拉斯维加斯
-(void)clickTheLasVegasBtn
{
    self.holeBtn.selected=NO;
    self.landlordsBtn.selected=NO;
    self.lasVegasBtn.selected=YES;
    //self.lasVegasView
    
    self.index=3;
    if (self.lasVegasView==nil) {
        self.holeView.hidden=YES;
        self.fightTheLandlordView.hidden=YES;
        ZCLasVegasView *lasVegasView=[[ZCLasVegasView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=40;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT-150;
        lasVegasView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
        [self.view addSubview:lasVegasView];
        lasVegasView.delegate=self;
        self.lasVegasView=lasVegasView;
    }else
    {
        self.holeView.hidden=YES;
        self.fightTheLandlordView.hidden=YES;
        self.lasVegasView.hidden=NO;

    
    }
    
}



//ZCHoleViewDelegate 方法
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3 andSwitch4:(int)isOpen4 andSwitch5:(int)isOpen5 andWhoWin:(int)whoWin andUserDict:(NSMutableDictionary *)userDict andOtherDict:(NSMutableDictionary *)otherDict
{
   // ZCLog(@"%@",userDict);
    
   NSMutableDictionary *switchDict = [NSMutableDictionary dictionary];
    switchDict[@"isOpen1"]=@(isOpen1);
    switchDict[@"isOpen2"]=@(isOpen2);
    switchDict[@"isOpen3"]=@(isOpen3);
    switchDict[@"isOpen4"]=@(isOpen4);
    switchDict[@"isOpen5"]=@(isOpen5);
    switchDict[@"whoWin"]=@(whoWin);
    switchDict[@"type"]=@(self.index);
//    switchDict[@"userDict"]=userDict;
//    switchDict[@"otherDict"]=otherDict;
    self.switchDict=switchDict;
    
    //ZCLog(@"%@",self.switchDict[@"userDict"]);
    
}



//ZCFightTheLandlordView 代理方法
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3 andUserDict:(ZCDouModel *)userModel andOtherDict:(ZCDouModel *)otherModel andAnotherDict:(ZCDouModel *)anotherModel
{
    
    
    NSMutableDictionary *switchDict = [NSMutableDictionary dictionary];
    switchDict[@"isOpen1"]=@(isOpen1);
    switchDict[@"isOpen2"]=@(isOpen2);
    switchDict[@"isOpen3"]=@(isOpen3);
    switchDict[@"type"]=@(self.index);
    
    self.fightTheLandlordDict=switchDict;
    
    
}


//-(NSMutableDictionary *)switchDict
//{
//
//    if (_switchDict==nil) {
//        //用户不操作时默认状态
//        _switchDict = [NSMutableDictionary dictionary];
//        _switchDict[@"isOpen1"]=@(1);
//        _switchDict[@"isOpen2"]=@(1);
//        _switchDict[@"isOpen3"]=@(1);
//        _switchDict[@"isOpen4"]=@(1);
//        _switchDict[@"isOpen5"]=@(0);
//        _switchDict[@"whoWin"]=@(0);
//        _switchDict[@"type"]=@(self.index);
//       
//    }
//    return _switchDict;
//    
//    
//}


-(void)viewWillAppear:(BOOL)animated
{
    self.editView.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
  self.editView.hidden=YES;
}
//ZCHoleViewDelegate代理方法
-(void)buttonIsClicker:(NSString *)nameStr
{
    ZCEditView *editView=[[ZCEditView alloc] init];
    editView.frame=[UIScreen mainScreen].bounds;
    editView.delegate=self;
    editView.nameStr=nameStr;
    UIWindow *wd=[[UIApplication sharedApplication].delegate window];
    [wd addSubview:editView];
    self.editView=editView;


}

// 斗地主代理方法
-(void)buttonIsClickerForFightTheLandlordView:(NSString *)nameStr
{
    ZCEditView *editView=[[ZCEditView alloc] init];
    editView.frame=[UIScreen mainScreen].bounds;
    editView.delegate=self;
    editView.nameStr=nameStr;
    UIWindow *wd=[[UIApplication sharedApplication].delegate window];
    [wd addSubview:editView];
    self.editView=editView;
    
}

-(void)buttonIsClickerForLasVegasView:(NSString *)nameStr
{

    ZCEditView *editView=[[ZCEditView alloc] init];
    editView.frame=[UIScreen mainScreen].bounds;
    editView.delegate=self;
    editView.nameStr=nameStr;
    UIWindow *wd=[[UIApplication sharedApplication].delegate window];
    [wd addSubview:editView];
    self.editView=editView;
}


//ZCEditView代理方法
-(void)editViewButtonIsClicked:(UIButton *)btn
{
    if (btn.tag==20995) {
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 1. 实例化
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            //类型
            pick.sourceType=UIImagePickerControllerSourceTypeCamera;
            // [pick setAllowsEditing:YES];
            pick.delegate=self;
            pick.allowsEditing = YES;
            // 3. 展现
            [self presentViewController:pick animated:YES completion:nil];
            
        }else{
            ZCLog(@"相ji不可用");
            
        }
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            // 1. 实例化
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            // 2. 设置代理
            pick.delegate = self;
            [pick setAllowsEditing:YES];
            // 3. 展现
            [self presentViewController:pick animated:YES completion:nil];
        }else{
            ZCLog(@"相ce不可用");
            
            // [FXJDyTool showAlertViewWithMessage:@"相册不可用" delegate:self];
        }
   

    }
}



//ZCEditView代理方法
-(void)editViewPersonalInformation:(UIImage *)image andName:(NSString *)nameStr
{
    if (self.index==1) {
        //将值传给比洞赛
        [self.holeView acceptPersonalInformation:image andName:nameStr];
        
    }else if (self.index==2){
        [self.fightTheLandlordView acceptPersonalInformationForFightTheLandlordView:image andName:nameStr];
    }else
    {
    [self.lasVegasView acceptPersonalInformationForFightTheLandlordView:image andName:nameStr];
    }
}


#pragma mark - 照片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.editView.image=info[UIImagePickerControllerEditedImage];
    //整个图片
    //  self.photoView.image=info[UIImagePickerControllerOriginalImage];
    //裁剪后的图片
    //self.photoView.image=info[UIImagePickerControllerEditedImage];
    
    //ZCLog(@"%@",[self.photoView.image class]);
    // 关闭视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // [self saveImage:info[UIImagePickerControllerOriginalImage] WithName:nil];
    //[self pictureUpload];
    
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
