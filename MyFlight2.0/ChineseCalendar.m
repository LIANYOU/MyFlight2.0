//
//  ChineseCalendar.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChineseCalendar.h"

static NSMutableDictionary* items;

@implementation ChineseCalendar

+(void) load {
    
    @autoreleasepool {
        
    

    if (!items) {
        
        items = [[NSMutableDictionary alloc] init];
        [items retain];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"calendar" ofType:@"txt"];
        NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
        for (NSString* line in lines) {
            
            if (!line || line.length == 0) {
                continue;
            }
            
            NSArray *sections = [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            
            [items setValue:sections forKey:[sections objectAtIndex:0]];
        }
    }
    }
}

+(NSString*) findMonthWithYear: (int) year month: (int) month day: (int) day {

    NSString* date = [NSString stringWithFormat:@"%d-%d-%d", year, month, day];
    return [(NSArray*)[items objectForKey:date] objectAtIndex:1];
}

+(NSString*) findDayWithYear: (int) year month: (int) month day: (int) day {
    
    NSString* date = [NSString stringWithFormat:@"%d-%d-%d", year, month, day];
    return [(NSArray*)[items objectForKey:date] objectAtIndex:2];
}

+(NSString*) findFestivalOrDayWithYear: (int) year month: (int) month day: (int) day {
    
    
    NSString* date = [NSString stringWithFormat:@"%d-%d-%d", year, month, day];
    
    NSArray* sections = (NSArray*)[items objectForKey:date];
    return [sections objectAtIndex:[sections count] - 1];
}

@end
