//
//  CalendarView.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthSection.h"

@interface CalendarView : UIView {
    
    UIScrollView* scrollView;

}

-(void) setDate:(Date*) date;

@end
