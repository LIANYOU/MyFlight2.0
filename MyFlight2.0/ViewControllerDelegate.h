//
//  ViewControllerDelegate.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerDelegate <NSObject>

-(void) setYear:(int) year month:(int) month day:(int) day;

@end
