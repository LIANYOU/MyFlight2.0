//
//  MyCheapViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "ServiceDelegate.h"
@interface MyCheapViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>

{
    
    
    SVSegmentedControl * segmented;
    
    
    
}


@property (retain, nonatomic) IBOutlet UITextField *tmpTextField;




//键盘 使用 

@property (retain, nonatomic) IBOutlet UIToolbar *textFieldAccView;




@property (retain, nonatomic) IBOutlet UITextField *captchNumberInput;


//优惠券 券号 
@property (retain, nonatomic) IBOutlet UIBarButtonItem *captchaNumberTextField;



//确定增加优惠券
- (IBAction)SureAddcaptchaBn:(id)sender;





@property (retain, nonatomic) IBOutlet UIView *tableFoot;

@property (retain, nonatomic) IBOutlet UIView *headerView;

@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

@property(nonatomic,retain)NSArray *uselistArray;
@property(nonatomic,retain)NSArray *noUseListArray;
@property(nonatomic,retain)NSArray  *outOfDateListArray;
@end
