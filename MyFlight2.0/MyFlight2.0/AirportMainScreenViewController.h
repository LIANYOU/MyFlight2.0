//
//  airportScreenViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-29.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportMainScreenSearchView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface AirportMainScreenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *screenTitle;
    UITableView *screenValue;
    
    AirportMainScreenSearchView *search;
    
    NSInteger barCount;
    
    NSString *apName;
    BOOL isIncoming;
    NSInteger pageNum;
    NSString *edition;
    
    __block NSDictionary *responseDictionary;
}

- (void) refresh;
- (void) updatePageNumber;
- (void) requestForData:(NSString *) flightNo;
- (void) nextPage;
- (void) previousPage;
- (void) search:(NSString *) flightNo;

@end
