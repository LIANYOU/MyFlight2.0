//
//  FrequentFlyerIndexViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ITTDataRequest.h"
#import "NFrequentFlyerData.h"

@interface FrequentFlyerIndexViewController : UIViewController<DataRequestDelegate>{
     IBOutlet UILabel *_cardNumberLabel;
     IBOutlet UILabel *_milesLabel;
     IBOutlet UILabel *_nameLabel;
     IBOutlet UILabel *_sexLabel;
     IBOutlet UILabel *_addressLabel;
     IBOutlet UILabel *_telLabel;
     IBOutlet UITableView *_tableView;
     IBOutlet UIView *_contentView;
    
    NSMutableArray *_dataArray;
     BOOL isFirstInit;
    
    NFrequentFlyerData *frequentFlyerData;

}


-(IBAction)telAction:(id)sender;
@end
