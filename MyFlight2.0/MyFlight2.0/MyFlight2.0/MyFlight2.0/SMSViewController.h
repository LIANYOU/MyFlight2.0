//
//  SMSViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton * sendMessageButton;

}
@property(nonatomic,retain)IBOutlet UIButton * sendMessageButton;

@end
