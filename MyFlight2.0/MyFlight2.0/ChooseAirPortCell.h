//
//  ChooseAirPortCell.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAirPortCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *apCodeLabel;

@property (retain, nonatomic) IBOutlet UILabel *airPortNameLabel;

@property (retain, nonatomic) IBOutlet UIImageView *flightState;


//类型 
@property (retain, nonatomic) IBOutlet UIView *thisStateView;

//是出发 还是到达
@property (retain, nonatomic) IBOutlet UILabel *labelState;




@end
