//
//  SendToFriendViewController.h
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "BasicViewController.h"
#import <MessageUI/MessageUI.h>

@interface SendToFriendViewController : BasicViewController <UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@end
