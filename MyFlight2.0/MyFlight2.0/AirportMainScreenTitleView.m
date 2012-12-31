//
//  AirportMainScreenTitleView.m
//  MyFlight2.0
//
//  Created by lianyou on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AirportMainScreenTitleView.h"

@implementation AirportMainScreenTitleView

@synthesize apCode;
@synthesize apName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        isChoosing = NO;
        
        self.backgroundColor = [UIColor blackColor];
        
        leftItem = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 40, 30)];
        
        leftItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        leftItem.layer.borderWidth = 1.0f;
        leftItem.layer.cornerRadius = 10.0f;
        
        leftItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        UIImageView *icon;
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(0, 0, 40, 30);
        icon.backgroundColor = [UIColor clearColor];
        
        [leftItem addSubview:icon];
        [icon release];
        
        [self addSubview:leftItem];
        [leftItem release];
        
        rightItem = [[UIView alloc] initWithFrame:CGRectMake(270, 30, 40, 30)];
        
        rightItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        rightItem.layer.borderWidth = 1.0f;
        rightItem.layer.cornerRadius = 10.0f;
        
        rightItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Refresh.png"]];
        
        icon.frame = CGRectMake(5, 0, 30, 30);
        icon.backgroundColor = [UIColor clearColor];
        
        [rightItem addSubview:icon];
        [icon release];
        
        [self addSubview:rightItem];
        [rightItem release];
        
        pickAirPortItem = [[UIView alloc] initWithFrame:CGRectMake(70, 30, 100, 30)];
        
        pickAirPortItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        pickAirPortItem.layer.borderWidth = 1.0f;
        pickAirPortItem.layer.cornerRadius = 10.0f;
        
        pickAirPortItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [self addSubview:pickAirPortItem];
        [pickAirPortItem release];
        
        [self reloadApName];
        
        incoming = [[UIView alloc] initWithFrame:CGRectMake(180, 30, 70, 30)];
        
        incoming.layer.borderColor = [[UIColor whiteColor] CGColor];
        incoming.layer.borderWidth = 1.0f;
        incoming.layer.cornerRadius = 10.0f;
        
        incoming.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(5, 5, 20, 20);
        icon.backgroundColor = [UIColor clearColor];
        
        [incoming addSubview:icon];
        [icon release];
        
        UILabel *label;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 45, 20)];
        
        label.text = @"入港";
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.backgroundColor = [UIColor clearColor];
        
        [incoming addSubview:label];
        [label release];
        
        [self addSubview:incoming];
        [incoming release];
        
        outgoing = [[UIView alloc] initWithFrame:CGRectMake(180, 30, 70, 30)];
        
        outgoing.layer.borderColor = [[UIColor whiteColor] CGColor];
        outgoing.layer.borderWidth = 1.0f;
        outgoing.layer.cornerRadius = 10.0f;
        
        outgoing.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(5, 5, 20, 20);
        icon.backgroundColor = [UIColor clearColor];
        
        [outgoing addSubview:icon];
        [icon release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 45, 20)];
        
        label.text = @"出港";
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.backgroundColor = [UIColor clearColor];
        
        [outgoing addSubview:label];
        [label release];
        
        [self addSubview:outgoing];
        [outgoing release];
        
        if(self.isIncoming)
        {
            [self bringSubviewToFront:incoming];
        }
        else
        {
            [self bringSubviewToFront:outgoing];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *leftTouches = [event touchesForView:leftItem];
    NSSet *rightTouches = [event touchesForView:rightItem];
    NSSet *centerTouches = [event touchesForView:pickAirPortItem];
    NSSet *inTouches = [event touchesForView:incoming];
    NSSet *outTouches = [event touchesForView:outgoing];
    
    if([leftTouches count] != 0)
    {
        [self.delegate performSelector:@selector(back)];
    }
    else if([rightTouches count] != 0)
    {
        [self.delegate performSelector:@selector(requestForData:) withObject:nil];
    }
    else if([centerTouches count] != 0)
    {
        [self.delegate performSelector:@selector(chooseAirPort:) withObject:self.apCode];
        
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
                             UIImageView *view = [rightItem.subviews objectAtIndex:0];
                             view.transform = transform;
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.5
                                              animations:^(void){
                                                  CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
                                                  UIImageView *view = [rightItem.subviews objectAtIndex:0];
                                                  view.transform = transform;
                                              }];
                         }];
    }
    else if([inTouches count] != 0)
    {
        if(!isChoosing)
        {
            if(!beginAnimation)
            {
                outgoing.hidden = NO;
                
                [UIView animateWithDuration:0.5
                                 animations:^(void){
                                     beginAnimation = YES;
                                     incoming.frame = CGRectMake(180, 20, 70, 30);
                                     outgoing.frame = CGRectMake(180, 50, 70, 30);
                                 }
                                 completion:^(BOOL finished){
                                     beginAnimation = NO;
                                     isChoosing = YES;
                                 }];
            }
        }
        else
        {
            if(!beginAnimation)
            {
                [UIView animateWithDuration:0.5
                                 animations:^(void){
                                     beginAnimation = YES;
                                     [self bringSubviewToFront:incoming];
                                     incoming.frame = CGRectMake(180, 30, 70, 30);
                                     outgoing.frame = CGRectMake(180, 30, 70, 30);
                                 }
                                 completion:^(BOOL finished){
                                     beginAnimation = NO;
                                     isChoosing = NO;
                                     self.isIncoming = YES;
                                     [self.delegate performSelector:@selector(requestForData:) withObject:nil];
                                 }];
            }
        }
    }
    else if([outTouches count] != 0)
    {
        if(!isChoosing)
        {
            if(!beginAnimation)
            {
                incoming.hidden = NO;
                
                [UIView animateWithDuration:0.5
                                 animations:^(void){
                                     beginAnimation = YES;
                                     incoming.frame = CGRectMake(180, 20, 70, 30);
                                     outgoing.frame = CGRectMake(180, 50, 70, 30);
                                 }
                                 completion:^(BOOL finished){
                                     beginAnimation = NO;
                                     isChoosing = YES;
                                 }];
            }
        }
        else
        {
            if(!beginAnimation)
            {
                [UIView animateWithDuration:0.5
                                 animations:^(void){
                                     beginAnimation = YES;
                                     [self bringSubviewToFront:outgoing];
                                     incoming.frame = CGRectMake(180, 30, 70, 30);
                                     outgoing.frame = CGRectMake(180, 30, 70, 30);
                                 }
                                 completion:^(BOOL finished){
                                     beginAnimation = NO;
                                     isChoosing = NO;
                                     self.isIncoming = NO;
                                     [self.delegate performSelector:@selector(requestForData:) withObject:nil];
                                 }];
            }
        }
    }
}

- (void) reloadApName
{
    for(UIView *view in [pickAirPortItem subviews])
    {
        [view removeFromSuperview];
    }
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 90, 20)];
    
    label.text = self.apName;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [pickAirPortItem addSubview:label];
    [label release];
}

@end
