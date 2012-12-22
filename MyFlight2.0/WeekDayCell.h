//
//  WeekDayCell.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekDayCell : UIView {

    UILabel* label;
    
    int _day;
}

-(int) day;
-(void) setDay:(int) day;

@end
