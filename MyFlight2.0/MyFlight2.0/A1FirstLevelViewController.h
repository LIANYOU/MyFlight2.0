//
//  A1FirstLevelViewController.h
//  SearchJob
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class A1FirstLevelViewController;    // 定义协议用于传值
@protocol A1FirstLevelViewControllerDelegate <NSObject>

-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectItem:(NSString *)item;// 其他选项传值
-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectTown:(NSString *)town;// 工作地点初值
-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectJob:(NSString *)job;  // 工作类型传值

@end


@interface A1FirstLevelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int index;   
    int section1;
    int ID;
    
    // 使用blocks传值。
    void (^blocks) (NSString * job);

}
@property (nonatomic,retain) UITableView  * tableView1;
@property (nonatomic,retain) UITableView  * tableView2;
@property (nonatomic,retain) UIView * view1;

@property (nonatomic,retain) NSMutableString * string;

@property (nonatomic,assign) id<A1FirstLevelViewControllerDelegate>delegate;


@property (nonatomic,assign) int selectRow; //判断选择是第几行


@property (nonatomic,retain) NSMutableArray * provienceArr ;//工作地点
@property (nonatomic,retain) NSMutableArray * provienceID ;
@property (nonatomic,retain) NSMutableArray * townArr;

@property (nonatomic,retain) NSMutableArray * jobArr ;//行业名称
@property (nonatomic,retain) NSMutableArray * jobIDArr ;
@property (nonatomic,retain) NSMutableArray * smallJobArr;

@property (nonatomic,retain) NSMutableArray * industryArr;//职位名称

@property (nonatomic,retain) NSMutableArray * publishDateArr;//发布时间

@property (nonatomic,retain) NSMutableArray * workEXPArr;//工作经验

@property (nonatomic,retain) NSMutableArray * educationArr;//学历要求

@property (nonatomic,retain) NSMutableArray * comptypeArr;//公司性质

@property (nonatomic,retain) NSMutableArray * compsizeArr;//公司规模

-(void)setDataFromA1FirstLevelViewController:(void (^) (NSString * job))controller;

@end
