//
//  QueryLeijiViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "ChooseAirPortViewController.h"
#import "ChooseAirPortCompanyViewController.h"
@interface QueryLeijiViewController : UIViewController<ChooseAirPortViewControllerDelegate,ChooseAirPortCompanyViewControllerDelegate>
{
    
    SVSegmentedControl * segmented;
}


- (IBAction)chooseCompany:(id)sender;


@property (retain, nonatomic) IBOutlet UILabel *companyName;

- (IBAction)startAirPort:(id)sender;

- (IBAction)endAirport:(id)sender;


@property (retain, nonatomic) IBOutlet UILabel *startAirportLabel;

@property (retain, nonatomic) IBOutlet UILabel *endAirportLabel;



@property (retain, nonatomic) IBOutlet UITextView *secondNotice;


- (IBAction)queryInfo:(id)sender;



@property (retain, nonatomic) IBOutlet UIButton *noticeBn;


//兑换须知 
- (IBAction)goToNoticeWeb:(id)sender;


@property (retain, nonatomic) IBOutlet UITextView *showDetailTextView;


@end
