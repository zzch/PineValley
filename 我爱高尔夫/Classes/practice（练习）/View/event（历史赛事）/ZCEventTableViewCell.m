//
//  ZCEventTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCEventTableViewCell.h"
@interface ZCEventTableViewCell()
/**
 总杆数uilabel
 
*/
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/**
 球场名称
 
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 开始的时间
 */
@property (weak, nonatomic) IBOutlet UILabel *startedAtLabel;
/**
 赛事的类型
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
/**
记录的记分卡数量
 */

@property (weak, nonatomic) IBOutlet UILabel *recorded_scorecards_count_label;

@end

@implementation ZCEventTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"tg";
    ZCEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZCEventTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


-(void)setEvent:(ZCEvent *)event
{
    _event=event;
//    if (![self.event.course.name isKindOfClass:[NSNull class]]) {
//         self.scoreLabel.text=self.event.score;
//        
//    }
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",self.event.score ];
;
    self.nameLabel.text=self.event.course.name;
    self.startedAtLabel.text=self.event.started_at;
    self.typeLabel.text=self.event.type;
   // if (![self.event.recorded_scorecards_count isKindOfClass:[NSNull class]]) {
    
   // }
self.recorded_scorecards_count_label.text=[NSString stringWithFormat:@"%@",self.event.recorded_scorecards_count ];
   
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
