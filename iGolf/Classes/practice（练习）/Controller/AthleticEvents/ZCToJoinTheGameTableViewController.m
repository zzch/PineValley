//
//  ZCToJoinTheGameTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCToJoinTheGameTableViewController.h"
#import "ZCChildStadium.h"
#import "ZCNameJoinTableViewCell.h"
#import "ZCModelTableViewCell.h"
#import "ZCNoteTableViewCell.h"
#import "ZCChildNameTableViewCell.h"
#import "ZCSettingHeadView.h"
#import "ZCCompetitiveScorecardTableViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
@interface ZCToJoinTheGameTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCSettingHeadViewDelegate>
@property(nonatomic,assign) int count;
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;
@property(nonatomic,weak)UIButton *startButton;

//保存用户选择前9洞的T台
@property(nonatomic,copy) NSString *firstTeeBox;
//保存用户选择后9洞的T台
@property(nonatomic,copy) NSString *lastTeeBox;

@end

@implementation ZCToJoinTheGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    [self addControls];
}


//添加控件
-(void)addControls
{
    UIButton *startButton=[[UIButton alloc] init];
    CGFloat startButtonX=0;
    
    CGFloat startButtonW=SCREEN_WIDTH;
    CGFloat startButtonH=50;
    CGFloat startButtonY=SCREEN_HEIGHT-startButtonH;
    
    startButton.frame=CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    
    // startButton.frame=CGRectMake(0, 300, 317, 40);
    [startButton setTitle:@"加入比赛" forState:UIControlStateNormal];
    startButton.backgroundColor=ZCColor(105, 178, 138);
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickDidStartButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:startButton];
    // startButton.userInteractionEnabled=NO;
    startButton.enabled=NO;
    self.startButton=startButton;
    
    
    
}

//点击加入比赛
-(void)clickDidStartButton
{
    ZCCompetitiveScorecardTableViewController *competitiveScorecardTableViewController=[[ZCCompetitiveScorecardTableViewController alloc] init];
   
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    params[@"uuid"]=self.athleticEventsModel.uuid;
    //ZCLog(@"%@",self.athleticEventsModel.uuid);
    params[@"token"]=account.token;
    params[@"password"]=self.athleticEventsModel.password;
    if (self.lastTeeBox==nil) {
        params[@"tee_boxes"]=self.firstTeeBox;
    }else
    {
       params[@"tee_boxes"]=[NSString stringWithFormat:@"%@,%@",self.firstTeeBox,self.lastTeeBox];
    }
    
    
    
    //发送请求/v1/matches/tournament/participate.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/tournament/participate.json"];

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        //传值
        competitiveScorecardTableViewController.uuid=self.athleticEventsModel.uuid;
        
        [self.navigationController pushViewController:competitiveScorecardTableViewController animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
    
    

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



//是否可以点击开始按钮
-(void)canStart
{
    
    
    
    self.startButton.enabled=NO;
    self.startButton.backgroundColor=ZCColor(105, 178, 138);
    //ZCLog(@"进入该方法了");
    
    ZCChildStadium *childStadium=self.athleticEventsModel.courses[0];
    
    if (childStadium.holes_count==18) {
        if (self.firstTeeBox) {
            
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(37, 176, 101);
            
        }
        

    }else if(childStadium.holes_count==9)
    {
        if (self.firstTeeBox &&self.lastTeeBox) {
            
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(37, 176, 101);
            
        }

    }
   
        
        
        
 }




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.count) {
        return self.count;
    }else
    {
        return 5;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return 1;
    }else if (section==2)
    {
        return 1;
    }else if (section==3)
    {
        return 1;
    }else if (section==4)
    {
        ZCChildStadium *ChildStadium=self.athleticEventsModel.courses[0];
        ZCLog(@"%lu",ChildStadium.tee_boxes.count);
      return (self.opened1? 0:ChildStadium.tee_boxes.count) ;
    }else if (section==5)
    {
        return 1;
    }else
    {
        ZCChildStadium *ChildStadium=self.athleticEventsModel.courses[1];
        return (self.opened2? 0:ChildStadium.tee_boxes.count) ;

       
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section==0) {
        ZCNameJoinTableViewCell *cell=[ZCNameJoinTableViewCell cellWithTable:tableView];
        cell.name=self.athleticEventsModel.name;
        return cell;
    }else if (indexPath.section==1)
    {
        ZCModelTableViewCell *cell=[ZCModelTableViewCell cellWithTable:tableView];
        return cell;
    }else if (indexPath.section==2)
    {
        ZCNoteTableViewCell *cell=[ZCNoteTableViewCell cellWithTable:tableView];
        cell.textStr=self.athleticEventsModel.remark;
        return cell;
    }else if (indexPath.section==3)
    {
        ZCChildNameTableViewCell *cell=[ZCChildNameTableViewCell cellWithTable:tableView];
         ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[0];
        if (ChildStadium.holes_count==18){
            cell.nameStr=@"18洞";
        }else
        {
        cell.nameStr=@"前9洞";
        }
        
        cell.childName=ChildStadium.name;
        
        
        return cell;
    }else if (indexPath.section==4)
    {
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }

        ZCChildStadium *childStadium=self.athleticEventsModel.courses[0];
         NSString *tee=childStadium.tee_boxes[indexPath.row];
        
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色T台";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色T台";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色T台";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色T台";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色T台";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }

        
        return cell;

        
        
    }else if (indexPath.section==5)
    {
        ZCChildNameTableViewCell *cell=[ZCChildNameTableViewCell cellWithTable:tableView];
        
        ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[1];
                   cell.nameStr=@"后9洞";
        
        
        cell.childName=ChildStadium.name;
        
        
        
        return cell;
    }else{
    
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }
        
        ZCChildStadium *childStadium=self.athleticEventsModel.courses[1];
        ZCLog(@"%@",childStadium.tee_boxes[2]);
        NSString *tee=childStadium.tee_boxes[indexPath.row];
        
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色T台";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色T台";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色T台";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色T台";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色T台";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }
        

    
    return cell;
    }
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        CGSize size = [self.athleticEventsModel.remark sizeWithFont:[UIFont systemFontOfSize:24] constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        

        if (size.height>50) {
            return size.height;
        }else
        {
            return 50;
        }
        
    }else
    {
        return 60;
    }
}









#pragma mark - ZCSettingHeaderView的代理方法
-(void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button
{
    
    if (button.tag==3333) {
        self.opened1=!self.opened1;
        
        
     }else if(button.tag==4444)
    {
        self.opened2=!self.opened2;
        
    }
    
    
    [self.tableView reloadData];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==4) {
        return 60;
    }else if (section==6)
    {
        return 60;
    }else
    {
        return 0;
    }
}



// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个View
    ZCSettingHeadView *headerView=[ZCSettingHeadView headerViewWithTableView:tableView];
    headerView.delegate=self;

    if (section==4) {
        
        
        
        if (self.opened1) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        
        headerView.nameButton.tag=3333;
       // headerView.tag=1004;
        headerView.cleicedName=self.firstTeeBox;
        if (self.firstTeeBox==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }
//        
//        if (self.tee_boxe==nil) {
//            headerView.liftName=@"请选择T台";
//        }else
//        {
//            headerView.liftName=@"开球T台";
//        }
        
        
        headerView.cleicedName=self.firstTeeBox;
       // return  headerView;
    }else if (section==6)
    {
        
        headerView.nameButton.tag=4444;
       // headerView.tag=1003;
        
        if (self.opened2) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        
        
        if (self.lastTeeBox==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }
        
        
        headerView.cleicedName=self.lastTeeBox;

        
       // return  headerView;
    
    }
    return  headerView;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==4)
    {
        self.opened1=YES;
        self.opened2=NO;
        
        
       ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[0];
        NSString *tee_boxe= ChildStadium.tee_boxes[indexPath.row];
        self.firstTeeBox= tee_boxe;
        
        if (ChildStadium.holes_count==18) {
            ZCLog(@"开始回合");
        }else
        {
        self.count=7;
        
        }
    }else if (indexPath.section==6)
    {
    
        ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[1];
        NSString *tee_boxe= ChildStadium.tee_boxes[indexPath.row];
        self.lastTeeBox= tee_boxe;

        self.opened2=YES;
        
    }
    
    
     [self.tableView reloadData];
    [self canStart];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
