//
//  SelectResultCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectResultCell : UITableViewCell
{    
    IBOutlet UILabel *temporaryLabel;
    IBOutlet UILabel *airPort;
    IBOutlet UILabel *palntType;    
    IBOutlet UILabel *beginTime;    
    IBOutlet UILabel *endTime;
    IBOutlet UILabel *pay;    
    IBOutlet UILabel *discount;    
    IBOutlet UILabel *ticketCount;    
    IBOutlet UIImageView *arrowsImage;    
}
@end
