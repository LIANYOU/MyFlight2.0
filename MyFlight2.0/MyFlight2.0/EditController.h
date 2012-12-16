//
//  EditController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditCell;
@interface EditController : UITableViewController
{
    EditCell *cell;
    void (^blocks) (NSString * name, NSString * gender ,NSString * address);
}
@property (retain,nonatomic) NSArray * titleArr;
@property (retain,nonatomic) NSString * name;
@property (retain,nonatomic) NSString * gender;
@property (retain,nonatomic) NSString * address;
-(void)getDate:(void (^) (NSString * name, NSString * gender ,NSString * address))string;
@end
