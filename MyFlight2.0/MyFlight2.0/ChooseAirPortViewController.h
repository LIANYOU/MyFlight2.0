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

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *) controlelr chooseType:(NSInteger ) choiceType didSelectAirPortInfo:(AirPortData *) airPort;

@end

@interface ChooseAirPortViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChooseAirPortViewControllerDelegate>



@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSArray *resultHotArray;
@property(nonatomic,retain)NSArray *allKeysArray;
//属性传值
@property(nonatomic,retain)NSString *startAirportName;
@property(nonatomic,retain)NSString *endAirPortName;
@property(nonatomic,assign)NSInteger choiceTypeOfAirPort;

@property(nonatomic,assign)id<ChooseAirPortViewControllerDelegate> delegate;

@end
