//
//  ZCEntertainmentRankingTableViewController.m
//  iGolf
//
//  Created by hh on 15/8/10.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//排行榜

#import "ZCEntertainmentRankingTableViewController.h"
#import "ZCEntertainmentRankingCell.h"
@interface ZCEntertainmentRankingTableViewController ()
@property(nonatomic,strong)NSMutableArray *rankingArray;
@end

@implementation ZCEntertainmentRankingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=100;

    
    
    //self.dataArray
    
    NSMutableArray *teamArray=[[NSMutableArray alloc] init];
    //冒泡排序  个数大的时候请勿使用
    for (int i=0; i<self.dataArray.count; i++) {
        for (int j=0; j<self.dataArray.count-1; j++) {
            if ([self.dataArray[j] score] < [self.dataArray[j+1] score]) {
                ZCOfflinePlayer *teamPlayer=[[ZCOfflinePlayer alloc] init];
                teamPlayer=self.dataArray[j];
                self.dataArray[j]=self.dataArray[j+1];
                self.dataArray[j+1]=teamPlayer;
            }
        }
    }

   // ZCLog(@"%ld,%ld,%ld",(long)[self.dataArray[0] score],[self.dataArray[1] score],[self.dataArray[2] score]);
    int j=1;
    //排名字
    for (int i=0; i<self.dataArray.count-1; i++) {
        if ([self.dataArray[i] score]>[self.dataArray[i+1] score]) {
            
            [teamArray addObject:@(j)];
            j++;
        }else
        {
            [teamArray addObject:@(j)];
        }
    }
    
   
    if (self.dataArray[self.dataArray.count-1]==self.dataArray[self.dataArray.count-2]) {
        [teamArray addObject:@(j)];
    }else
    {
    [teamArray addObject:@(j++)];
    }
     ZCLog(@"%@",teamArray);
    self.rankingArray=teamArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCEntertainmentRankingCell *cell=[ZCEntertainmentRankingCell cellWithTable:tableView];
    
    cell.player=self.dataArray[indexPath.row];
    cell.ranking=[self.rankingArray[indexPath.row] intValue];
    return cell;
}





@end
