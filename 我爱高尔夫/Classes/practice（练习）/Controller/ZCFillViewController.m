//
//  ZCFillViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCFillViewController.h"
#import "ZCScorecard.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
@interface ZCFillViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
//推杆
@property (weak, nonatomic) IBOutlet UILabel *pushLabel;
//罚杆
@property (weak, nonatomic) IBOutlet UILabel *punish;
//总杆数
@property(nonatomic,assign) int count;
//推杆数
@property(nonatomic,assign) int pushcount;
//罚杆数
@property(nonatomic,assign) int punishcount;

//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//命中
@property (weak, nonatomic) IBOutlet UILabel *hitLabel;

@property (strong,nonatomic) NSArray *pickArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
//是否改变值
@property (nonatomic, assign, getter = isEditor) BOOL editor;

@end

@implementation ZCFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultData];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@",self.scorecard.number];
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveOtherView)];
    self.navigationItem.rightBarButtonItem =newBar;
    
    // 修改下一个界面返回按钮的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //[self pickerView:self didSelectRow:5 inComponent:nil];
    
   

  
    
    //返回按钮
    UIBarButtonItem *blackButton= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dataToModify)];
    self.navigationItem.leftBarButtonItem=blackButton;
    
    
    //注册观察者
    [self registeredObservers];
    
//    
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
//push到这个界面的默认值
-(void)defaultData
{
    if (self.scorecard.score==nil) {
        
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
    [mgr PUT:@"http://augusta.aforeti.me/api/v1/scorecards.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
        
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
        
    }];
    

}
//点击返回按钮
-(void)dataToModify
{
    
    if (self.editor) {
        [self alert];
    }else
    {
        // 1.关闭当前控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

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
        for (int i = 0; i < 80; i ++) {
            [pickArray1 addObject:[NSString stringWithFormat:@"%d",i*5]];
        }

       
        NSArray *pickArray2=[NSArray array];
         pickArray2=@[@"左侧",@"右侧",@"命中"];
        
        _pickArray=@[pickArray1,pickArray2];
        
    }
    
    return _pickArray;
}




//总杆数 点击加号
- (IBAction)totalAdd {
    if (self.count<10) {
        self.count++;
    }else{
        self.count=10;
    }
    //   self.count=self.pushcount+(self.punishcount) +1;
    self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    //点击后值是否改变
    
    
}
//总杆数 点击减号
- (IBAction)totaReduction {
    
    if (self.count>1&& self.count>self.punishcount &&self.count>self.pushcount &&self.count>self.punishcount+self.pushcount) {
        self.count--;
    }
    self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];

    
    
}
//推杆数 点击加号
- (IBAction)pushAdd {
    
    if (self.pushcount<=self.count-(self.punishcount*2)-1) {
        self.pushcount++;
    }else{
        //self.pushcount=10;
    }
    
    self.pushLabel.text=[NSString stringWithFormat:@"%d",self.pushcount];
    
   //
    if (self.count<self.pushcount+(self.punishcount) +1) {
        self.count=self.pushcount+(self.punishcount) +1;
         self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
   
    
}
//推杆数 点击减号
- (IBAction)pushReduction {
    
    if (self.pushcount>0) {
        self.pushcount--;
    }else{
        self.pushcount=0;
    }
    
    self.pushLabel.text=[NSString stringWithFormat:@"%d",self.pushcount];

}
//罚杆数 点击加号
- (IBAction)punishAdd {
    
    if (self.punishcount<(self.count-self.pushcount-1)/2) {
        self.punishcount++;
    }else{
       // self.punishcount=10;
    }
    
    self.punish.text=[NSString stringWithFormat:@"%d",self.punishcount];
    

    if (self.count<self.pushcount+(self.punishcount) +1) {
        self.count=self.pushcount+(self.punishcount) +1;
        self.totalLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
    

}
//罚杆数 点击减号
- (IBAction)punishReduction {
    if (self.punishcount>0) {
        self.punishcount--;
    }else{
        self.punishcount=0;
    }
    
    self.punish.text=[NSString stringWithFormat:@"%d",self.punishcount];
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

//- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
//{
//    if (component == 0) { //
//        self.distanceLabel.text = self.pickArray[component][row];
//    } else if (component == 1) { //
//        self.hitLabel.text = self.pickArray[component][row];
//    }
//
//    
//}


-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
   
    return 130;
}

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
