//
//  SeatMapView.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatMapView : UIView

@property (assign, nonatomic) NSInteger selectionX;
@property (assign, nonatomic) NSInteger selectionY;

- (void) drawSeatMap;

@end
