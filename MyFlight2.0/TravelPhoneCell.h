//
//  TravelPhoneCell.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelPhoneCell : UITableViewCell
{
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * phoneLabel;
}
@property(nonatomic,retain) IBOutlet UILabel * titleLabel;
@property(nonatomic,retain) IBOutlet UILabel * phoneLabel;
@end
