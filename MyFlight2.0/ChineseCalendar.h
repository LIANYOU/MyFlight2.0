//
//  ChineseCalendar.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChineseCalendar : NSObject

+(void) load;

+(NSString*) findMonthWithYear: (int) year month: (int) month day: (int) day;
+(NSString*) findDayWithYear: (int) year month: (int) month day: (int) day;
+(NSString*) findFestivalOrDayWithYear: (int) year month: (int) month day: (int) day;

@end
