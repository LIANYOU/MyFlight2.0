//
//  MultiChoiceCell.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-11.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiChoiceTableViewSupport.h"

@interface MultiChoiceCell : UITableViewCell
{
    UILabel *service;
    UILabel *user;
    UIButton *selection;
}

@property (assign, nonatomic) id <MultiChoiceTableViewSupport> delegate;
@property (assign, nonatomic) BOOL choosed;

- (void) setServiceName:(NSString *) string;
- (void) setUserName:(NSString *) string;
- (void) click;

@end
