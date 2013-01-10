//
//  PersonInfotoShowViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfotoShowViewController : UIViewController



@property (retain, nonatomic) IBOutlet UIView *thisView;





@property (retain, nonatomic) IBOutlet UILabel *accountNameLabel;



@property (retain, nonatomic) IBOutlet UIButton *userNameLabel;

//用户姓名 
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;


//性别
@property (retain, nonatomic) IBOutlet UILabel *sexLabel;

//详细地址 
@property (retain, nonatomic) IBOutlet UILabel *detailAddressLabel;

- (IBAction)modifyPasswd:(id)sender;




@end
