//
//  airportScreenViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-29.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportMainScreenSearchView.h"
#import "AirportMainScreenTitleView.h"
#import "ChooseAirPortViewController.h"
#import "AirPortData.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface AirportMainScreenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ChooseAirPortViewControllerDelegate>
{
    UITableView *screenTitle;
    UITableView *screenValue;
    
    AirportMainScreenTitleView *titlebar;
    AirportMainScreenSearchView *search;
    
    NSInteger pageNum;
    NSString *edition;
    
    __block NSDictionary *responseDictionary;
}

- (void) back;
- (void) refresh;
- (void) updatePageNumber;
- (void) requestForData:(NSString *) flightNo;
- (void) nextPage;
- (void) previousPage;
- (void) search:(NSString *) flightNo;
- (void) chooseAirPort:(NSString *) apName;

@end
