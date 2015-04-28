//
//  ZCCompetitiveSetTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/22.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCompetitiveSetTableViewController.h"
#import "ZCAthleticEventTableViewCell.h"
#import "ZCCreateAGameTableViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCAthleticEventsModel.h"
#import "ZCUserModel.h"
#import "ZCToJoinTheGameTableViewController.h"
@interface ZCCompetitiveSetTableViewController ()
@property(nonatomic,strong)NSMutableArray *athleticEventsModelArray;
@property(nonatomic,weak)UIView *passwordView;
@property(nonatomic,weak)UITextField *TextField;
@property(nonatomic,strong)ZCAthleticEventsModel *athleticEventsModel;
@end

@implementation ZCCompetitiveSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton)];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=100;
    
    
    [self onlineData];
    
}


//网络加载
-(void)onlineData
{
  
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuidStr;
    params[@"token"]=account.token;
    
    
    
    //发送请求/v1/courses/show.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/matches/tournament.json"];
    
//    ZCLog(@"%@",self.uuidStr);
//    ZCLog(@"%@",account.token);
//    ZCLog(@"%@",url);
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      ZCLog(@"%@",responseObject);
        self.athleticEventsModelArray=[NSMutableArray array];
        
        for (NSDictionary *dict in responseObject) {
            ZCAthleticEventsModel *athleticEventsModel=[ZCAthleticEventsModel athleticEventsModelWithDict:dict];
            [self.athleticEventsModelArray addObject:athleticEventsModel];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}

//点击新建/v1/venues/matches/tournament.json
-(void)clickRightBarButton
{
    ZCCreateAGameTableViewController *createAGameTableViewController=[[ZCCreateAGameTableViewController alloc] init];
    createAGameTableViewController.uuidStr=self.uuidStr;
    [self.navigationController pushViewController:createAGameTableViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.athleticEventsModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCAthleticEventTableViewCell *cell=[ZCAthleticEventTableViewCell cellWithTable:tableView];
    cell.athleticEventsModel=self.athleticEventsModelArray[indexPath.row];
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.athleticEventsModel= self.athleticEventsModelArray[indexPath.row] ;
    
    
    UIView *passwordView=[[UIView alloc] init];
    passwordView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    
    
    passwordView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [passwordView addTarget:self action:@selector(clickpassView) forControlEvents:UIControlEventTouchUpOutside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)];
    [passwordView addGestureRecognizer:tap];
    
    self.passwordView=passwordView;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:passwordView];

    UITextField * TextField=[[UITextField alloc] init];
    TextField.backgroundColor=[UIColor redColor];
    TextField.frame=CGRectMake(30, 200, 200, 30);
    [passwordView addSubview:TextField];
    self.TextField=TextField;
    
    
    UIButton *button=[[UIButton alloc] init];
    button.backgroundColor=[UIColor redColor];
    button.frame=CGRectMake(50, 300, 50, 30);
    [button addTarget:self action:@selector(didclickButton) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:button];

}



-(void)didclickButton
{
    [self.passwordView removeFromSuperview];
    //  self.TextField.text
    if ([self.TextField.text isEqual:self.athleticEventsModel.password]) {
        
        ZCToJoinTheGameTableViewController *toJoinTheGameTableViewController=[[ZCToJoinTheGameTableViewController alloc] init];
        
        toJoinTheGameTableViewController.athleticEventsModel=self.athleticEventsModel;
        [self.navigationController pushViewController:toJoinTheGameTableViewController animated:YES];
        
    }
    
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//}




-(void)coverClick
{
    [self.passwordView removeFromSuperview];
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
