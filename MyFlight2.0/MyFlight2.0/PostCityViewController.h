//
//  PostCityViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-13.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    void (^blocks) (NSString * idntity);
}

@property (retain, nonatomic) IBOutlet UITableView *showPostcityTableView;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;


@property (retain, nonatomic) NSMutableDictionary * provinceDic;
@property (retain, nonatomic) NSMutableDictionary * derectDic;

@property (retain, nonatomic) NSMutableArray * siftArr;



@property (retain, nonatomic) NSMutableArray * scetionTitleArr;

-(void)getDate:(void (^) (NSString * idntity))string;
@end
