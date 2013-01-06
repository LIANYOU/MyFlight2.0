//
//  SeatMapView.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatMapView : UIView
{
    NSInteger selectionX;
    NSInteger selectionY;
    
    char *map;
}

@property (assign, nonatomic) NSInteger sectionX;
@property (assign, nonatomic) NSInteger sectionY;

- (void) drawSeatMap:(NSDictionary *) responseDictionary;
- (NSString *) currentSeatChoosed:(NSDictionary *) responseDictionary;

@end
