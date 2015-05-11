//
//  ZCExitTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/5/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCExitTableViewController.h"
#import "ZCAccount.h"
#import "ZCregisterViewController.h"
@interface ZCExitTableViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>

@end

@implementation ZCExitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asd" forIndexPath:indexPath];
    
   
    static NSString *ID = @"exit";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    
    
    
    cell.textLabel.text=@"退出登录";
    

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"退出登录",nil];
    [sheet showInView:self.tableView];

}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if ([account.type isEqual:@"guest"]) {
            //提示
            [self alert];
           
        }else{
        //删除数据
            [self  deleteTheAccount];
            
        }
        
       
        
    
    }
    
}



//删除数据
-(void)deleteTheAccount
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    //删除文件
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
    
    
    ZCregisterViewController *registerViewController=[[ZCregisterViewController alloc] init];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    //去首页
    wd.rootViewController =registerViewController;

}


-(void)alert
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您当前未设置账号和密码请完善，否则您的数据将会丢失" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
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
        ZCLog(@"2222");
       // [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self deleteTheAccount];
    }
    
    // 按钮的索引肯定不是0
    
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
