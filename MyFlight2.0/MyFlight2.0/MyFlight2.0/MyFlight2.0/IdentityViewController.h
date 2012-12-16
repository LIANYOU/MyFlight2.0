//
//  IdentityViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentityViewController : UITableViewController
{
    void (^blocks) (NSString * idntity);
}
@property (nonatomic, retain) NSArray  * arr;
@property (nonatomic, retain) NSArray  * identityCardArr;
@property (nonatomic, assign) int flag;  
-(void)getDate:(void (^) (NSString * idntity))string;
@end
