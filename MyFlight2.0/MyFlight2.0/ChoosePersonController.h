//
//  ChoosePersonController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-12.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@class ChoosePersonCell;
@interface ChoosePersonController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{
    BOOL selectedSign; //是否已选中的标记位
    
    void (^blocks) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableDictionary *flightPassengerIdDic,NSMutableDictionary * certTypeDic,NSMutableArray * arr);
    
}
@property (nonatomic,retain) NSMutableArray * dataArr;

@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet ChoosePersonCell *choosePersonCell;

@property (retain, nonatomic) NSMutableArray * indexArr;

@property (retain, nonatomic) NSMutableArray * selectArr;

@property (retain, nonatomic) IBOutlet UIButton *addBtn;


@property (retain, nonatomic) NSMutableDictionary * nameDic;  // 姓名
@property (retain, nonatomic) NSMutableDictionary * typeDic;  // 类型
@property (retain, nonatomic) NSMutableDictionary * identityNumberDic; // 证件号
@property (retain, nonatomic) NSMutableDictionary * flightPassengerIdDic; //常用乘机人ID
@property (retain, nonatomic) NSMutableDictionary * certTypeDic; // 证件类型


- (IBAction)addPerson:(UIButton *)sender;

-(void)getDate:(void (^) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableDictionary *flightPassengerIdDic,NSMutableDictionary * certTypeDic,NSMutableArray * arr))string;
@end
