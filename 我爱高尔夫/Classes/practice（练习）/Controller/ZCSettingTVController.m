//
//  ZCSettingTVController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSettingTVController.h"
#import "ZCChooseThePitchVViewController.h"
#import "ZCStadiumInformation.h"
#import "ZCChildStadium.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCSettingHeadView.h"
#import "ZCScorecardTableViewController.h"
#import "ZCTotalScorecards.h"
#import "ZCScorecardTableViewController.h"
@interface ZCSettingTVController ()<UITableViewDelegate,UITableViewDataSource,ZCSettingHeadViewDelegate>
@property(nonatomic,assign) int count;

@property(nonatomic,strong) ZCStadiumInformation *stadiumInformation;
//保存用户选择球场的uuid
@property(nonatomic,copy) NSString *uuid;
//保存用户选择球场的T台
@property(nonatomic,copy) NSString *tee_boxe;
//保存选中一个子场的数据
@property(nonatomic, strong) ZCChildStadium *childStadium;
//保存在选择9洞后 列出后9洞的子场
@property(nonatomic,strong) NSMutableArray *childStadiumMutableArray;
//保存用户选择后9洞的球场的uuid
@property(nonatomic,copy) NSString *lastUuid;
//保存选中后9洞子场的数据
@property(nonatomic, strong) ZCChildStadium *lastChildStadium;
//保存用户选择后9洞球场的T台
@property(nonatomic,copy) NSString *lastTee_boxe;
@property(nonatomic,assign) NSInteger index;
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;
@property (nonatomic, assign, getter = isOpened3) BOOL opened3;
@property (nonatomic, assign, getter = isOpened4) BOOL opened4;

@property(nonatomic, strong) ZCSettingHeadView *settingHeadView;
//保存选中的子场名字
@property(nonatomic,copy) NSString *firstChildName;
//保存选中的子场名字
@property(nonatomic,copy) NSString *lastChildName;

@property(nonatomic,weak) UIButton *startButton;

@end

@implementation ZCSettingTVController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuidStr;
    params[@"token"]=account.token;
    
    //发送请求/v1/courses/show.json
    [mgr GET:@"http://augusta.aforeti.me/api/v1/courses/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
 
        
        ZCStadiumInformation  *stadiumInformation=[ZCStadiumInformation stadiumInformationWithDict:responseObject];
        
        self.stadiumInformation=stadiumInformation;
        
        // 刷新表格
        [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"请求失败%@",error);
    }];
    

    
    

    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionHeaderHeight = 60;
    
    
    UIButton *startButton=[[UIButton alloc] init];
     CGFloat startButtonX=0;
    
     CGFloat startButtonW=SCREEN_WIDTH;
     CGFloat startButtonH=40;
    CGFloat startButtonY=SCREEN_HEIGHT-startButtonH;
    
    startButton.frame=CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    
    // startButton.frame=CGRectMake(0, 300, 317, 40);
    [startButton setTitle:@"开始回合" forState:UIControlStateNormal];
    startButton.backgroundColor=[UIColor redColor];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickDidStartButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:startButton];
   // startButton.userInteractionEnabled=NO;
    startButton.enabled=NO;
    self.startButton=startButton;
    
 

}
-(void)viewWillDisappear:(BOOL)animated
{
  self.startButton.hidden=YES;
    //[self.startButton removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.startButton.hidden=NO;
}


-(void)clickDidStartButton
{
    ZCLog(@"--------可以点击Button");
    ZCScorecardTableViewController *scorecardTableView=[[ZCScorecardTableViewController alloc] init];
    
//    scorecardTableView.uuid=self.uuid;
//    scorecardTableView.tee_box=self.tee_boxe;
//    scorecardTableView.lastUuid=self.lastUuid;
//    scorecardTableView.lastTee_box=self.lastTee_boxe;
//    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if (self.lastUuid==nil&&self.lastTee_boxe==nil) {
        params[@"group_uuids"]=self.uuid;
//        ZCLog(@"%@",self.uuid);
//        ZCLog(@"%@",self.tee_boxe);
        params[@"tee_boxes"]=self.tee_boxe;
    }else{
    params[@"group_uuids"]= [NSString stringWithFormat:@"%@,%@" , self.uuid,self.lastUuid ];
        params[@"tee_boxes"]=[NSString stringWithFormat:@"%@,%@" , self.tee_boxe,self.lastTee_boxe ];
    }
    params[@"token"]=account.token;
///v1/matches/practice.json
    [mgr POST:@"http://augusta.aforeti.me/api/v1/matches/practice.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // ZCLog(@"-------%@",responseObject);
        
        ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
        ZCLog(@"-------%@",totalScorecards.type);
        scorecardTableView.totalScorecards=totalScorecards;
        
        [self.navigationController pushViewController:scorecardTableView animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    
    
    
    
    
}



-(void)canStart
{
    
    
    if (self.childStadium.holes_count==18) {
        if (self.tee_boxe) {
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=[UIColor blueColor];
            
        }
    }else if (self.childStadium.holes_count==9)
    {
        if (self.tee_boxe) {
            if (self.lastChildName) {
                if (self.lastTee_boxe) {
                    self.startButton.enabled=YES;
                    self.startButton.backgroundColor=[UIColor blueColor];
                }
            }
        }
        
    }


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.count) {
        return self.count;
    }else if(self.stadiumInformation.groups.count==1)
    {
        //默认调用点击方法
        [self tableView:tableView didSelectRowAtIndexPath:nil];
        
        return 2;
    }else
    {
        return 1;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        
        return (self.opened1? 0:self.stadiumInformation.groups.count) ;
    }else if(section==1){
        
        NSLog(@"%zd",self.childStadium.tee_boxes.count);
        return (self.opened2? 0: self.childStadium.tee_boxes.count );
    }else if (section==2)
    {
        return  (self.opened3? 0: self.childStadiumMutableArray.count);
    }else //if(section==3)
    {
        return( self.opened4? 0:self.lastChildStadium.tee_boxes.count );
    }
    
   
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
    }
    
    if (indexPath.section==0) {
        ZCChildStadium *childStadium=self.stadiumInformation.groups[indexPath.row];
        cell.textLabel.text=childStadium.name;
       // cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:childStadium.holes_count]];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];
    }else if(indexPath.section==1)
    {
        NSString *tee=self.childStadium.tee_boxes[indexPath.row];
       
       
            cell.textLabel.text=tee;
            cell.imageView.image=[UIImage imageNamed:@"main_badge"];
       
        
    
    }else if (indexPath.section==2)
    {
        ZCChildStadium *childStadium=self.childStadiumMutableArray[indexPath.row];
        cell.textLabel.text=childStadium.name;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];
        
    }else
    {
        NSString *tee=self.lastChildStadium.tee_boxes[indexPath.row];
        
        
        cell.textLabel.text=tee;
        cell.imageView.image=[UIImage imageNamed:@"main_badge"];
    }
    

    return cell;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//     return @"1111111";
//
//}

// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个View
    ZCSettingHeadView *headerView=[ZCSettingHeadView headerViewWithTableView:tableView];
    headerView.delegate=self;
   // 把数据扔给自定义View
    if (section==0) {
        headerView.cleicedName=self.firstChildName;
      
        headerView.nameButton.tag=100;
        headerView.tag=1001;
        
        if (self.opened1) {
             headerView.imageName=@"navigationbar_arrow_down";
        }else
        {
           headerView.imageName=@"navigationbar_back_highlighted";
        }
        
        if (self.firstChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            if (self.childStadium.holes_count==18) {
                headerView.liftName=@"18洞";
            }else{
                headerView.liftName=@"前九洞";
            }

        }
        

        
}else if(section==1)
    {
        headerView.nameButton.tag=101;
        headerView.tag=1002;
        
        if (self.opened2) {
            headerView.imageName=@"navigationbar_arrow_down";
        }else
        {
            headerView.imageName=@"navigationbar_back_highlighted";
        }

        
        
        if (self.tee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }

        
        headerView.cleicedName=self.tee_boxe;
        
    }else if (section==2)
        
    {
        
        headerView.nameButton.tag=102;
        headerView.tag=1003;
        
        if (self.opened3) {
            headerView.imageName=@"navigationbar_arrow_down";
        }else
        {
            headerView.imageName=@"navigationbar_back_highlighted";
        }

        
        
        if (self.lastChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            headerView.liftName=@"后九洞";
        }

        
        
        headerView.cleicedName=self.lastChildName;
        
    }else{
        if (self.opened4) {
            headerView.imageName=@"navigationbar_arrow_down";
        }else
        {
            headerView.imageName=@"navigationbar_back_highlighted";
        }

        
        headerView.nameButton.tag=103;
        headerView.tag=1004;
        headerView.cleicedName=self.lastTee_boxe;
        if (self.lastTee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }

    }
   
   
    
    return headerView;
}

#pragma mark - ZCSettingHeaderView的代理方法
-(void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button
{
    
    if (button.tag==100) {
        self.opened1=!self.opened1;

      
    }else if (button.tag==101)
    {
        
      self.opened2=!self.opened2;

    }else if (button.tag==102)
    {
        self.opened3=!self.opened3;

    
    }else
    {
      self.opened4=!self.opened4;

    }
    
    
    [self.tableView reloadData];
   
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section==0) {
        //点击第0组拿到的子场
        self.opened1=YES;
        self.opened2=NO;
        self.opened3=NO;
        self.opened4=NO;
//        ZCSettingHeadView *headView2= (ZCSettingHeadView *)[self.tableView viewWithTag:1002]   ;
//        headView2.cleicedName=nil;
//        
//        ZCSettingHeadView *headView3= (ZCSettingHeadView *)[self.tableView viewWithTag:1003]   ;
//        headView3.cleicedName=nil;
//        
//        ZCSettingHeadView *headView4= (ZCSettingHeadView *)[self.tableView viewWithTag:1004]   ;
//        headView4.cleicedName=nil;
        
        self.tee_boxe=nil;
        self.lastChildName=nil;
        self.lastTee_boxe=nil;
       
        self.count=2;
        ZCChildStadium *childStadium=self.stadiumInformation.groups[indexPath.row];
        self.childStadium = childStadium;
        NSString *uuidStr=childStadium.uuid;
        self.uuid=uuidStr;
        

        
        self.firstChildName=childStadium.name;
        ZCLog(@"%@",self.firstChildName);
       
        self.index=indexPath.row;

    }else if (indexPath.section==1)
    {//点击第1组拿到的子场的T台，并判断是否是18洞 是开始回合，不是增加一组在重新选择子场
        
        
      self.opened2=YES;
        self.opened3=NO;
        self.opened4=NO;
//        ZCSettingHeadView *headView3= (ZCSettingHeadView *)[self.tableView viewWithTag:1003]   ;
//        headView3.cleicedName=nil;
//        ZCSettingHeadView *headView4= (ZCSettingHeadView *)[self.tableView viewWithTag:1004]   ;
//        headView4.cleicedName=nil;


        self.lastTee_boxe=nil;
        self.lastChildName=nil;
        
        NSString *tee_boxe= self.childStadium.tee_boxes[indexPath.row];
        ZCLog(@"%@",tee_boxe);
        self.tee_boxe=tee_boxe;
        
        
        if (self.childStadium.holes_count==18) {
            ZCLog(@"----开始回合-----");
        }else
        {
            self.count=3;
            
            
            
            NSMutableArray *childStadiums=self.stadiumInformation.groups;
            for (ZCChildStadium *childStadium in childStadiums) {
                if (childStadium.holes_count==18) {
                    
                    [childStadiums removeObject:childStadium];
                }
                ZCLog(@"%lu",childStadiums.count);
                self.childStadiumMutableArray=childStadiums;
                
            }
            
        }
    
    }else if (indexPath.section==2)
    {
         self.opened3=YES;
        self.opened4=NO;
//        ZCSettingHeadView *headView4= (ZCSettingHeadView *)[self.tableView viewWithTag:1004]   ;
//        headView4.cleicedName=nil;
        self.lastTee_boxe=nil;

        //点击第3组时候保存子场uuid，并且增加一组选择T台
        self.count=4;
        
        //拿到选择后场的子场uuid
        ZCChildStadium *lastChildStadium=self.childStadiumMutableArray[indexPath.row];
        self.lastChildStadium=lastChildStadium;
        self.lastUuid=lastChildStadium.uuid;
        self.lastChildName=lastChildStadium.name;
    
    
    }else
    {
        self.opened4=YES;        //保存后9洞的T台
        NSString *houTee_box=self.lastChildStadium.tee_boxes[indexPath.row];
        self.lastTee_boxe=houTee_box;
        ZCLog(@"%@",houTee_box);
        
        ZCLog(@"开始回合------");
    
    
    }
    
    [self canStart];
    [self.tableView reloadData];
    
    
}





@end
