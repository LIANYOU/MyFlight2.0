//
//  BaggageViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaggageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableData * myData;
    NSString * _myAirPortCode;  
    NSMutableArray * array_section_open;//存储每个section的打开状态
    BOOL sectionIsOpen;     //section开还是关
    NSArray * sectionCount; //一共有多少个section
   
}
@property(nonatomic,retain)NSString * myAirPortCode;
@end
