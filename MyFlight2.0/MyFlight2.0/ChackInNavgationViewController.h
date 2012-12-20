//
//  ChackInNavgationViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChackInNavgationViewController : UIViewController{
    UITableView * myTableView;
    NSMutableData * myData;
    NSString * _airPortCode;
    NSMutableArray * rootArray;
    NSString * _myTitle;
}
@property(nonatomic,retain) NSString * airPortCode;
@property(nonatomic,retain)NSString * myTitle;
@end
