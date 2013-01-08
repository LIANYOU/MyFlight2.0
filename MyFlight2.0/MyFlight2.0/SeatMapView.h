//
//  SeatMapView.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SeatMapView : UIView
{
    NSInteger selectionX;
    NSInteger selectionY;
    
    NSInteger availableCount;
    
    UIImage *emergencyExit;
    UIImage *selected;
    UIImage *available;
    UIImage *occupied;
    
    UIButton *lastSelection;
    
    NSDictionary *map;
}

@property (assign, nonatomic) NSInteger sectionX;
@property (assign, nonatomic) NSInteger sectionY;

- (void) drawSeatMap:(NSDictionary *) seatMap;
- (void) click:(UIButton *) sender;
- (NSString *) currentSelected;

@end
