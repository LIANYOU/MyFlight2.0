//
//  ChooseAirPortCompanyViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPortCompanyData.h"
@class ChooseAirPortCompanyViewController;
@protocol ChooseAirPortCompanyViewControllerDelegate <NSObject>

@optional

- (void) ChooseAirPortCompanyViewController:(ChooseAirPortCompanyViewController *) controller DidChooseCompany:(AirPortCompanyData *) company;

@end


@interface ChooseAirPortCompanyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
}

@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

@property(nonatomic,assign)id<ChooseAirPortCompanyViewControllerDelegate> delegate;
@property(nonatomic,retain)NSString *selectedCompany;


@end
