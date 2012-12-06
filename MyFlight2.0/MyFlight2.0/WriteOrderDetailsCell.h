//
//  WriteOrderDetailsCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteOrderDetailsCell : UITableViewCell
{    
    IBOutlet UIButton *addPerson;
    IBOutlet UILabel *phoneNumber;
    IBOutlet UILabel *personName;
}
@property (retain, nonatomic) IBOutlet UILabel *personName;
@property (retain, nonatomic) IBOutlet UILabel *phoneNumber;
@property (retain, nonatomic) IBOutlet UILabel *person;
@property (retain, nonatomic) IBOutlet UILabel *phone;
@property (retain, nonatomic) IBOutlet UIButton *addPerson;

@end
