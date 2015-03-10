//
//  ZCSwitchTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSwitchTableViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "MJExtension.h"
#import "ZCCity.h"
#import "ZCCityStadium.h"



@interface ZCSwitchTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

//@property (nonatomic, strong) NSArray *citys;
//搜索栏
@property (nonatomic , strong)UISearchDisplayController *mySearchDisplayController;
@property(strong,nonatomic) UISearchBar *mySearchBar;
@property(strong,nonatomic) UITableView *tableView;
//数据源
@property(strong,nonatomic) NSMutableArray *dataArray;
//搜索结果数据
@property(strong,nonatomic) NSMutableArray *resultsData;


@end

@implementation ZCSwitchTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    _resultsData = [NSMutableArray array];
    
    [self onlineData];
    //搜索
    [self initMysearchBarAndMysearchDisPlay];
    
    }


//获取网络请求数据，城市列表 AFHTTPRequestOperationManager  /v1/courses/sectionalized_by_province.json
-(void)onlineData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"token"]=account.token;
    
    
    [mgr GET:@"http://augusta.aforeti.me/api/v1/courses/sectionalized_by_province.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 将字典数组转为模型数组(
        //self.citys = [ZCCity objectArrayWithKeyValuesArray:responseObject];
        // 将字典数据转为模型数据
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            //创建模型
            ZCCity *city=[ZCCity citysWithDict:dict];
//                        NSLog(@"---city.name---%@",city.name);
//                        NSLog(@"---city.courses.count---%zd",city.courses.count);
            //添加模型
            [self.dataArray addObject:city];
        }
        // ZCLog(@"---self.dataArray---%zd",self.dataArray.count);
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"数据请求失败%@",error);
    }];
}






#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    if(tableView == _mySearchDisplayController.searchResultsTableView)

    {
        return 1;
    }else
    {
    return self.dataArray.count;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  
    //searchDisplayController自身有一个searchResultsTableView，所以在执行操作的时候首先要判断是否是搜索结果的tableView，如果是显示的就是搜索结果的数据，如果不是，则显示原始数据。
    if(tableView == _mySearchDisplayController.searchResultsTableView)
    {
        tableView.frame = CGRectMake(0, 20, 320, SCREEN_HEIGHT-20);
        //解决上面空出的20个像素
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        if (is_IOS_7)
            //分割线的位置不带偏移
            tableView.separatorInset = UIEdgeInsetsZero;
        
        return _resultsData.count;

    }else{

    ZCCity *city= self.dataArray[section];
    return city.courses.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *myCell = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    
    
    if (tableView == _mySearchDisplayController.searchResultsTableView)
    {
        //ZCCity *city= self.resultsData[indexPath.section];
        ZCCityStadium *stadium = self.resultsData[indexPath.row];
        cell.textLabel.text = stadium.name;
        cell.detailTextLabel.text= [NSString stringWithFormat:@"address===%zd",indexPath.row];
        
    }
    else
    {
        ZCCity *city= self.dataArray[indexPath.section];
        ZCCityStadium *stadium = city.courses[indexPath.row];
        cell.textLabel.text = stadium.name;
        cell.detailTextLabel.text= [NSString stringWithFormat:@"address===%zd",indexPath.row];

    }
    
    return cell;

    
    
    
    

    
  
}

#pragma mark - Table view delegate source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        if(tableView == _mySearchDisplayController.searchResultsTableView)
        {
            return nil;
        }else{
    
    ZCCity *city=self.dataArray[section];
    return city.name;
        }
}




-(void)initMysearchBarAndMysearchDisPlay
{
    _mySearchBar = [[UISearchBar alloc] init];
    _mySearchBar.delegate = self;
    //    //设置选项
        //[_mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
    [_mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_mySearchBar sizeToFit];
    _mySearchBar.backgroundColor = RGBACOLOR(249,249,249,1);
    _mySearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_mySearchBar.bounds.size];
    //加入列表的header里面
    self.tableView.tableHeaderView = _mySearchBar;
    
    _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
    _mySearchDisplayController.delegate = self;
    // searchResultsDataSource 就是 UITableViewDataSource
    _mySearchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    _mySearchDisplayController.searchResultsDelegate = self;
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods

//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (is_IOS_7) {
        subViews = [(_mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = _mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
   
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20);
    }];
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, is_IOS_7?64:44, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchString:(NSString *)searchString

{
//    if(self.tableView == _mySearchDisplayController.searchResultsTableView)
//    {
//        self.tableView.sectionHeaderHeight = 0;
//    }else{
//        self.tableView.sectionHeaderHeight = 40;
//    }

    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:searchString
                               scope:[_mySearchBar scopeButtonTitles][_mySearchBar.selectedScopeButtonIndex]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    //如果设置了选项，当Scope Button选项有變化的时候，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:_mySearchBar.text
                               scope:_mySearchBar.scopeButtonTitles[searchOption]];
    
    return YES;
}

//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < _dataArray.count; i++) {
       
        NSMutableArray *coursesArrays=[_dataArray[i] courses];
        for (int j=0; j<coursesArrays.count; j++) {
            ZCCityStadium *cityStadium=coursesArrays[j];
            NSString *storeString =cityStadium.name;
            
            NSRange storeRange = NSMakeRange(0, storeString.length);
            NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
            if (foundRange.length) {
                [tempResults addObject:cityStadium];
            }

        }
            }
    
    [_resultsData removeAllObjects];
    [_resultsData addObjectsFromArray:tempResults];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _mySearchDisplayController.searchResultsTableView)
    {
        //[self myAlertViewAccording:[_resultsData[indexPath.row] name]];
        [self myAlertViewAccording:@"haha"];
    }
    else
    {
        //NSMutableArray *cityStadium=_dataArray[indexPath.section];
       // [self myAlertViewAccording:[cityStadium[indexPath.row] name]];
        
        [self myAlertViewAccording:@"hehe"];
    }
}

-(void)myAlertViewAccording:(NSString *)content
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"cell－content" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}



//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
