//
//  SubTrfficViewController.h
//  MyFlight2.0
//
//  Created by apple on 13-1-13.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubTrfficViewController : UIViewController
{
    
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * priceLabel;
    IBOutlet UILabel * firstBus;
    IBOutlet UILabel * lastBus;
    IBOutlet UILabel * lineIntervalTime;
    IBOutlet UITextView * stops;
    IBOutlet UIImageView * titleImageView;
}
@property(nonatomic,retain)NSMutableDictionary * subDic;
@end
