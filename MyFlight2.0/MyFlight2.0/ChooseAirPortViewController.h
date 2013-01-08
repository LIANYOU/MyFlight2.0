//
//  ChooseAirPortViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseAirPortViewController;
@class  AirPortData;
@protocol ChooseAirPortViewControllerDelegate <NSObject>

@optional

//选择机场的代理 
- (void) ChooseAirPortViewController:(ChooseAirPortViewController *) controlelr chooseType:(NSInteger ) choiceType didSelectAirPortInfo:(AirPortData *) airPort;



@end

@interface ChooseAirPortViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChooseAirPortViewControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>



@property (retain, nonatomic) IBOutlet UISearchBar *searchBar; //搜索条

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSArray *resultHotArray;
@property(nonatomic,retain)NSArray *allKeysArray;
//属性传值 
@property(nonatomic,retain)NSString *startAirportName; //出发机场
@property(nonatomic,retain)NSString *endAirPortName; //到达机场 
@property(nonatomic,assign)NSInteger choiceTypeOfAirPort; //选择的类型 单程 还是往返





@property(nonatomic,assign)id<ChooseAirPortViewControllerDelegate> delegate;

@property(nonatomic,retain)NSMutableArray *filterArray;


@end
