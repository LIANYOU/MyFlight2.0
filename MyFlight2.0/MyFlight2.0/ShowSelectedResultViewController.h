//
//  ShowSelectedResultViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowSelectedResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *salesText;
    
    IBOutlet UIButton *nowDateBtn;
    IBOutlet UIButton *theDayAfterBtn;
    IBOutlet UIButton *theDayBeforeBtn;
    IBOutlet UIButton *cancelSalesText;
    
    IBOutlet UIButton *sortBtn;
    IBOutlet UILabel *backImagelabel;
    IBOutlet UIButton *siftBtn;
}
@property (retain, nonatomic) IBOutlet UITableView *showResultTableView;


- (IBAction)enterSales:(id)sender;        // 进入促销活动
- (IBAction)enterTheDayBefore:(id)sender; // 进入前一天的查询结果
- (IBAction)showCalendar:(id)sender;      // 显示日历，选择日期
- (IBAction)enterTheDayAfter:(id)sender;  //进入下一天的查询结果
- (IBAction)siftByAirPort:(id)sender;     // 按照航空公司进行筛选查询结果
- (IBAction)sortByDate:(id)sender;        // 对查询结果按时间进行排序


@end
