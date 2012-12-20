//
//  ChoosePersonController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-12.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChoosePersonCell;
@interface ChoosePersonController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL selectedSign; //是否已选中的标记位
    
    void (^blocks) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableArray * arr);
    
}
@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet ChoosePersonCell *choosePersonCell;

@property (retain, nonatomic) NSMutableArray * indexArr;

@property (retain, nonatomic) NSMutableArray * selectArr;

@property (retain, nonatomic) IBOutlet UIButton *addBtn;


@property (retain, nonatomic) NSMutableDictionary * nameDic;
@property (retain, nonatomic) NSMutableDictionary * typeDic;
@property (retain, nonatomic) NSMutableDictionary * identityNumberDic;

- (IBAction)addPerson:(UIButton *)sender;

-(void)getDate:(void (^) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableArray * arr))string;
@end
