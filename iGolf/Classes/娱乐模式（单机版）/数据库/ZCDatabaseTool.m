//
//  ZCDatabaseTool.m
//  iGolf
//
//  Created by hh on 15/7/24.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCDatabaseTool.h"
#import "FMDB.h"
#import "ZCSingletonTool.h"
#import "ZCHoleModel.h"
#import "ZCSwitchModel.h"
#import "ZCFightTheLandlordModel.h"
#import "ZCOfflinePlayer.h"
#import "ZCDouModel.h"
@implementation ZCDatabaseTool


/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"status.sqlite"];
    ZCLog(@"%@",filename);
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_match (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,type INTEGER NOT NULL,played_at datetime ,birdie_x2 INTEGER NOT NULL,eagle_x4 INTEGER NOT NULL,double_par_x2 INTEGER NOT NULL,drau_to_next INTEGER NOT NULL,drau_to_win INTEGER NOT NULL ,earned INTEGER, par_1 INTEGER,par_2 INTEGER,par_3 INTEGER,par_4 INTEGER,par_5 INTEGER,par_6 INTEGER,par_7 INTEGER,par_8 INTEGER,par_9 INTEGER,par_10 INTEGER,par_11 INTEGER,par_12 INTEGER,par_13 INTEGER,par_14 INTEGER,par_15 INTEGER,par_16 INTEGER,par_17 INTEGER,par_18 INTEGER );"];
        result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_player (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,is_owner INTEGER NOT NULL,nickname TEXT,portrait TEXT,stroke_1 INTEGER,stroke_2 INTEGER,stroke_3 INTEGER,stroke_4 INTEGER,stroke_5 INTEGER,stroke_6 INTEGER,stroke_7 INTEGER,stroke_8 INTEGER,stroke_9 INTEGER,stroke_10 INTEGER,stroke_11 INTEGER,stroke_12 INTEGER,stroke_13 INTEGER,stroke_14 INTEGER,stroke_15 INTEGER,stroke_16 INTEGER,stroke_17 INTEGER,stroke_18 INTEGER,match_id INTEGER NOT NULL,CONSTRAINT fk_player_match FOREIGN KEY(match_id) REFERENCES t_match(id));"];
        
        if (result) {
            NSLog(@"成功创表");
            //INSERT INTO t_student(age, score, name) VALUES ('28', 100, 'jonathan');
        } else {
            NSLog(@"创表失败");
        }
    }
}


//创建一场比洞比赛
+(BOOL)ToCreateAGame:(NSDictionary *)dict
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    ZCLog(@"%@",locationString);
    
    BOOL success1=[_db executeUpdate:@"INSERT INTO t_match(type,played_at, birdie_x2,eagle_x4,double_par_x2,drau_to_next,drau_to_win) VALUES (?,?,?,?,?,?,?);",dict[@"type"],senddate,dict[@"isOpen1"],dict[@"isOpen2"],dict[@"isOpen3"],dict[@"isOpen4"],dict[@"whoWin"]];
    
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    NSInteger lastId = [_db lastInsertRowId];
    tool.uuid=lastId;
    ZCLog(@"%ld",(long)lastId);
   BOOL success2=[_db executeUpdate:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (?,?,?,?);",dict[@"userDict"][@"isUser"],dict[@"userDict"][@"name"],dict[@"userDict"][@"personImage"],@(lastId)];
    NSInteger lastUserId = [_db lastInsertRowId];
    tool.userID=lastUserId;
    ZCLog(@"%ld",(long)lastUserId);
   BOOL success3=[_db executeUpdate:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (?,?,?,?);",dict[@"otherDict"][@"isUser"],dict[@"otherDict"][@"name"],dict[@"otherDict"][@"personImage"],@(lastId)];
    NSInteger lastOtherId = [_db lastInsertRowId];
    tool.otherID=lastOtherId;
    ZCLog(@"%ld",(long)lastOtherId);
    if (success1&&success2&&success3) {
        NSLog(@"更新成功");
        return YES;
    }else
    {
        NSLog(@"更新失败");
        return NO;
    }


}


//创建一场斗地主比赛
+(BOOL)ToCreateDoudizhuGame:(NSDictionary *)dict
{
    
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    
    
    ZCDouModel *player=dict[@"playerArray"][0];
    ZCDouModel *player1=dict[@"playerArray"][1];
    ZCDouModel *player2=dict[@"playerArray"][2];
    
//    // 获取路劲 取出图片
//    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
//    NSString *userImageName=@"personImage.png";
//    
    
    NSString *userImageName=[NSString stringWithFormat:@"person%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *userPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:userImageName];
    NSData *userdata=UIImagePNGRepresentation(player.personImage);
    [userdata writeToFile:userPath atomically:YES];

    NSString *otherImageName=[NSString stringWithFormat:@"person%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *otherPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:otherImageName];
    NSData *otherdata=UIImagePNGRepresentation(player1.personImage);
    [otherdata writeToFile:otherPath atomically:YES];
    
    NSString *anotherName=[NSString stringWithFormat:@"person%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *anotherDictPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:anotherName];
    NSData *anotherdata=UIImagePNGRepresentation(player2.personImage);
    [anotherdata writeToFile:anotherDictPath atomically:YES];
    
    //创建t_match 表的比赛记录
    BOOL success1=[_db executeUpdate:@"INSERT INTO t_match(type,played_at, birdie_x2,eagle_x4,double_par_x2,drau_to_next,drau_to_win) VALUES (?,?,?,?,?,?,?);",dict[@"type"],senddate,dict[@"isOpen1"],dict[@"isOpen2"],@(0),dict[@"isOpen3"],@(0)];
    
    NSInteger lastId = [_db lastInsertRowId];
    tool.uuid=lastId;

    
    NSString *sql2=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player.isUser,player.name ,userImageName,(long)tool.uuid];
  BOOL success2=[_db executeUpdate:sql2];
//    NSInteger lastUserId = [_db lastInsertRowId];
//    tool.userID=lastUserId;otherDict
    
    
    
    NSString *sql3=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player1.isUser,player1.name ,otherImageName,tool.uuid];
    
    BOOL success3=[_db executeUpdate:sql3];
 //  BOOL success3=[_db executeUpdate:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (?,?,?,?);",@([dict[@"otherDict"] isUser]),[dict[@"otherDict"] name] ,otherPath,@(tool.uuid)];
    
    
    NSString *sql4=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player2.isUser,player2.name ,anotherName,tool.uuid];
    BOOL success4=[_db executeUpdate:sql4];
   // BOOL success4=[_db executeUpdate:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (?,?,?,?);",@([dict[@"anotherDict"] isUser]),[dict[@"anotherDict"] name] ,anotherDictPath,@(tool.uuid)];
    
    
    if (success1&&success2&&success3&&success4) {
        return YES;
    }else{
    return NO;
    }
   
}



//创建一场拉斯维加斯比赛
+(BOOL)createALasVegasGame:(NSMutableArray*)array andSwitch:(NSMutableDictionary *)dict
{
    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    
    
    ZCDouModel *player=array[0];
    ZCDouModel *player1=array[1];
    ZCDouModel *player2=array[2];
    ZCDouModel *player3=array[3];

    NSString *userImageName=[NSString stringWithFormat:@"Lperson%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *userPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:userImageName];
    NSData *userdata=UIImagePNGRepresentation(player.personImage);
    [userdata writeToFile:userPath atomically:YES];
    
    NSString *otherImageName=[NSString stringWithFormat:@"Lperson%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *otherPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:otherImageName];
    NSData *otherdata=UIImagePNGRepresentation(player1.personImage);
    [otherdata writeToFile:otherPath atomically:YES];
    
    NSString *anotherName=[NSString stringWithFormat:@"Lperson%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *anotherDictPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:anotherName];
    NSData *anotherdata=UIImagePNGRepresentation(player2.personImage);
    [anotherdata writeToFile:anotherDictPath atomically:YES];
    
    NSString *lastPlayer=[NSString stringWithFormat:@"Lperson%dImage%d.png",arc4random_uniform(1000),arc4random_uniform(1000)];
    NSString *lastPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:lastPlayer];
    NSData *lastdata=UIImagePNGRepresentation(player3.personImage);
    [lastdata writeToFile:lastPath atomically:YES];

    
    //创建t_match 表的比赛记录
    BOOL success1=[_db executeUpdate:@"INSERT INTO t_match(type,played_at, birdie_x2,eagle_x4,double_par_x2,drau_to_next,drau_to_win) VALUES (?,?,?,?,?,?,?);",dict[@"type"],senddate,dict[@"isOpen1"],@(0),dict[@"isOpen2"],dict[@"isOpen3"],@(0)];
    
    NSInteger lastId = [_db lastInsertRowId];
    tool.uuid=lastId;

    NSString *sql2=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player.isUser,player.name ,userImageName,(long)tool.uuid];
    BOOL success2=[_db executeUpdate:sql2];

    
    NSString *sql3=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player1.isUser,player1.name ,otherImageName,tool.uuid];
    
    BOOL success3=[_db executeUpdate:sql3];
   
    
    
    NSString *sql4=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player2.isUser,player2.name ,anotherName,tool.uuid];
    BOOL success4=[_db executeUpdate:sql4];
    
    
    NSString *sql5=[NSString stringWithFormat:@"INSERT INTO t_player(is_owner,nickname,portrait,match_id) VALUES (%d,'%@','%@',%ld);",player3.isUser,player3.name ,lastPlayer,tool.uuid];
    BOOL success5=[_db executeUpdate:sql5];

    if (success1&&success2&&success3&&success4&&success5) {
        return YES;
    }else{
        
    return NO;
        
    }
    
    
}



//添加洞成绩
+(BOOL)saveEveryHole:(ZCHoleModel *)holeModel
{
     ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    
    
    NSString *t_match_sql=[NSString stringWithFormat:@"UPDATE t_match SET par_%d=%d WHERE  id=%ld",holeModel.holeNumber,holeModel.par,(long)tool.uuid];
    BOOL success1=[_db executeUpdate:t_match_sql];
    
    
     NSString *t_player_sql=[NSString stringWithFormat:@"UPDATE t_player SET stroke_%d=%d WHERE  id=%ld",holeModel.holeNumber,holeModel.userScore,(long)tool.userID];
    BOOL success2=[_db executeUpdate:t_player_sql];
    
    NSString *t_player_sql2=[NSString stringWithFormat:@"UPDATE t_player SET stroke_%d=%d WHERE  id=%ld",holeModel.holeNumber,holeModel.otherScore,(long)tool.otherID];
    BOOL success3=[_db executeUpdate:t_player_sql2];
    if (success1&&success2&&success3) {
        return YES;
    }else
    {
    return NO;
    }
    
}




//添加斗地主成绩
+(BOOL)saveTheFightTheLandlord:(ZCFightTheLandlordModel *)fightTheLandlordModel  andHoleNumber:(int) holeNumber
{
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    NSString *t_match_sql=[NSString stringWithFormat:@"UPDATE t_match SET par_%d=%d WHERE  id=%ld",holeNumber+1,fightTheLandlordModel.par,(long)tool.uuid];
    BOOL success1=[_db executeUpdate:t_match_sql];
    
    
    //拿出三人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];

    
    NSString *t_player_sql=[NSString stringWithFormat:@"UPDATE t_player SET stroke_%d=%ld WHERE  id=%ld",holeNumber+1,play1.stroke,play1.player_id];
    BOOL success2=[_db executeUpdate:t_player_sql];

    NSString *t_player_sql2=[NSString stringWithFormat:@"UPDATE t_player SET stroke_%d=%ld WHERE  id=%ld",holeNumber+1,play2.stroke,play2.player_id];
    BOOL success3=[_db executeUpdate:t_player_sql2];

    
    NSString *t_player_sql3=[NSString stringWithFormat:@"UPDATE t_player SET stroke_%d=%ld WHERE  id=%ld",holeNumber+1,play3.stroke,play3.player_id];
    BOOL success4=[_db executeUpdate:t_player_sql3];


    if (success1&&success2&&success3&&success4) {
        return YES;
    }else
    {
        return NO;
    }

    
    
}




//查询开关属性
+(ZCSwitchModel *)querySwitchProperties
{
    ZCSwitchModel *switchModel=[[ZCSwitchModel alloc] init]
    ;
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    
    // 查询成功后会将查询到的数据都存储到FMResultSet中, 这个FMResultSet相当于列表
    FMResultSet *result = [_db executeQuery:@"SELECT id, birdie_x2, eagle_x4, double_par_x2,drau_to_next, drau_to_win FROM t_match WHERE id=?;",@(tool.uuid)];
    // 调用next依次出去查询出来的结果
    while ([result next]) {
        // 注意: 下面的0/1/2是查询语句中字段的索引
       // NSString *name = [result stringForColumn:@"name"];
        //int uuid = [result intForColumn:@"id"];
        switchModel.birdie_x2 = [result intForColumn:@"birdie_x2"];
        switchModel.eagle_x4 = [result intForColumn:@"eagle_x4"];
        switchModel.double_par_x2 = [result intForColumn:@"double_par_x2"];
        switchModel.drau_to_next = [result intForColumn:@"drau_to_next"];
        switchModel.drau_to_win = [result intForColumn:@"drau_to_win"];
       
        
    }

    
    return switchModel;
}

//数据库里拿出斗地主比赛的数据
+(NSMutableArray *)doudizhuGameData
{
    
    NSMutableArray *fightTheLandlordModelArray=[NSMutableArray array];
    
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    
    for (int j=1; j<19; j++) {
      ZCFightTheLandlordModel *fightTheLandlordModel=[[ZCFightTheLandlordModel alloc] init];
    
    NSString *par=[NSString stringWithFormat:@"par_%d",j];
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT %@ FROM t_match WHERE id=%ld;",par,(long)tool.uuid];
    FMResultSet *result = [_db executeQuery:sqlStr];
    
    while ([result next]){
        
    fightTheLandlordModel.par=[result intForColumn:par];
       
    }
     
    
    NSMutableArray *tempPlayerArray=[NSMutableArray array];
    NSString *strokeStr=[NSString stringWithFormat:@"stroke_%d",j];
    NSString *sqlStr1=[NSString stringWithFormat:@"SELECT id,nickname,portrait, %@ FROM t_player WHERE match_id=%ld;",strokeStr,(long)tool.uuid];
    
    FMResultSet *result1 = [_db executeQuery:sqlStr1];
    while ([result1 next]){
        ZCOfflinePlayer *OfflinePlayer=[[ZCOfflinePlayer alloc] init];
        OfflinePlayer.player_id=[result1 intForColumn:@"id"];
        OfflinePlayer.nickname=[result1 stringForColumn:@"nickname"];
        OfflinePlayer.portrait=[result1  stringForColumn:@"portrait"];
        OfflinePlayer.stroke=[result1 intForColumn:strokeStr];
        ZCLog(@"%ld",(long)OfflinePlayer.portrait);
        
        [tempPlayerArray addObject:OfflinePlayer];
        
        
//        NSMutableArray *tempArray=[NSMutableArray array];
//        for (int i=1; i<19; i++) {
//           // NSString *strokeStr=[NSString stringWithFormat:@"stroke_%d",i];
//            NSString *sqlStr2=[NSString stringWithFormat:@"SELECT stroke_%d  FROM t_player WHERE id=%ld",i,(long)tool.userID];
//            FMResultSet *result2 = [_db executeQuery:sqlStr2];
//            while ([result2 next]){
//                int stroke=[result2 intForColumn:strokeStr];
//                [tempArray addObject:@(stroke)];
//            }
//            
//           // ZCLog(@"%@",tempArray);
//            OfflinePlayer.strokes=tempArray;
//            
        
//            ZCLog(@"%@",OfflinePlayer.nickname);
        }
 
        fightTheLandlordModel.plays=tempPlayerArray;
    

        [fightTheLandlordModelArray addObject:fightTheLandlordModel];
    }
    ZCLog(@"%@",fightTheLandlordModelArray);
    return fightTheLandlordModelArray;
}


////拿出拉斯维加斯比赛数据
//+(NSMutableArray*)LasVegasData
//{
//    NSMutableArray *fightTheLandlordModelArray=[NSMutableArray array];
//    
//    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
//    
//    for (int j=1; j<19; j++) {
//        ZCFightTheLandlordModel *fightTheLandlordModel=[[ZCFightTheLandlordModel alloc] init];
//        
//        NSString *par=[NSString stringWithFormat:@"par_%d",j];
//        NSString *sqlStr=[NSString stringWithFormat:@"SELECT %@ FROM t_match WHERE id=%ld;",par,(long)tool.uuid];
//        FMResultSet *result = [_db executeQuery:sqlStr];
//        
//        while ([result next]){
//            
//            fightTheLandlordModel.par=[result intForColumn:par];
//            
//        }
//        
//        
//        NSMutableArray *tempPlayerArray=[NSMutableArray array];
//        NSString *strokeStr=[NSString stringWithFormat:@"stroke_%d",j];
//        NSString *sqlStr1=[NSString stringWithFormat:@"SELECT id,nickname,portrait, %@ FROM t_player WHERE match_id=%ld;",strokeStr,(long)tool.uuid];
//        
//        FMResultSet *result1 = [_db executeQuery:sqlStr1];
//        while ([result1 next]){
//            ZCOfflinePlayer *OfflinePlayer=[[ZCOfflinePlayer alloc] init];
//            OfflinePlayer.player_id=[result1 intForColumn:@"id"];
//            OfflinePlayer.nickname=[result1 stringForColumn:@"nickname"];
//            OfflinePlayer.portrait=[result1  stringForColumn:@"portrait"];
//            OfflinePlayer.stroke=[result1 intForColumn:strokeStr];
//            ZCLog(@"%ld",(long)OfflinePlayer.portrait);
//            
//            [tempPlayerArray addObject:OfflinePlayer];
//            
//            
//            //        NSMutableArray *tempArray=[NSMutableArray array];
//            //        for (int i=1; i<19; i++) {
//            //           // NSString *strokeStr=[NSString stringWithFormat:@"stroke_%d",i];
//            //            NSString *sqlStr2=[NSString stringWithFormat:@"SELECT stroke_%d  FROM t_player WHERE id=%ld",i,(long)tool.userID];
//            //            FMResultSet *result2 = [_db executeQuery:sqlStr2];
//            //            while ([result2 next]){
//            //                int stroke=[result2 intForColumn:strokeStr];
//            //                [tempArray addObject:@(stroke)];
//            //            }
//            //
//            //           // ZCLog(@"%@",tempArray);
//            //            OfflinePlayer.strokes=tempArray;
//            //
//            
//            //            ZCLog(@"%@",OfflinePlayer.nickname);
//        }
//        
//        fightTheLandlordModel.plays=tempPlayerArray;
//        
//        
//        [fightTheLandlordModelArray addObject:fightTheLandlordModel];
//    }
//    ZCLog(@"%@",fightTheLandlordModelArray);
//    return fightTheLandlordModelArray;
//
//}


@end
