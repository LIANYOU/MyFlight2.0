//
//  PostViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-21.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UITableViewController
{
    void (^blocks) (NSString * idntity);;
}

-(void)getDate:(void (^) (NSString * idntity))string;
@end
