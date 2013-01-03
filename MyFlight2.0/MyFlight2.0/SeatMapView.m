//
//  SeatMapView.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SeatMapView.h"

@implementation SeatMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawSeatMap
{
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [[touches anyObject] locationInView:self];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
