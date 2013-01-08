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
        
        leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftItem.frame = CGRectMake(10, 25, 40, 30);
        
        leftItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        leftItem.layer.borderWidth = 1.0f;
        leftItem.layer.cornerRadius = 10.0f;
        
        leftItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [leftItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [leftItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *icon;
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(0, 0, 40, 30);
        icon.backgroundColor = [UIColor clearColor];
        
        [leftItem addSubview:icon];
        [icon release];
        
        [self addSubview:leftItem];
        
        rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rightItem.frame = CGRectMake(270, 25, 40, 30);
        
        rightItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        rightItem.layer.borderWidth = 1.0f;
        rightItem.layer.cornerRadius = 10.0f;
        
        rightItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [rightItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [rightItem addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Refresh.png"]];
        
        icon.frame = CGRectMake(5, 0, 30, 30);
        icon.backgroundColor = [UIColor clearColor];
        
        [rightItem addSubview:icon];
        [icon release];
        
        [self addSubview:rightItem];
        
        pickAirPortItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        pickAirPortItem.frame = CGRectMake(70, 25, 100, 30);
        pickAirPortItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        pickAirPortItem.layer.borderWidth = 1.0f;
        pickAirPortItem.layer.cornerRadius = 10.0f;
        
        pickAirPortItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [pickAirPortItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [pickAirPortItem addTarget:self action:@selector(chooseAirport) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:pickAirPortItem];
        
        [self reloadApName];
        
        incoming = [UIButton buttonWithType:UIButtonTypeCustom];
        
        incoming.frame = CGRectMake(180, 25, 70, 30);
        incoming.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        incoming.layer.borderWidth = 1.0f;
        incoming.layer.cornerRadius = 10.0f;
        
        incoming.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
//        [incoming addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [incoming addTarget:self action:@selector(chooseIncoming) forControlEvents:UIControlEventTouchUpInside];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(45, 5, 20, 20);
        icon.backgroundColor = [UIColor clearColor];
        
        [incoming addSubview:icon];
        [icon release];
        
        UILabel *label;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 45, 20)];
        
        label.text = @"入港";
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.backgroundColor = [UIColor clearColor];
        
        [incoming addSubview:label];
        [label release];
        
        [self addSubview:incoming];
        
        outgoing = [UIButton buttonWithType:UIButtonTypeCustom];
        
        outgoing.frame = CGRectMake(180, 25, 70, 30);
        outgoing.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        outgoing.layer.borderWidth = 1.0f;
        outgoing.layer.cornerRadius = 10.0f;
        
        outgoing.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
//        [outgoing addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [outgoing addTarget:self action:@selector(chooseOutgoing) forControlEvents:UIControlEventTouchUpInside];
        
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        icon.frame = CGRectMake(45, 5, 20, 20);
        icon.backgroundColor = [UIColor clearColor];
        
        [outgoing addSubview:icon];
        [icon release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 45, 20)];
        
        label.text = @"出港";
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.backgroundColor = [UIColor clearColor];
        
        [outgoing addSubview:label];
        [label release];
        
        [self addSubview:outgoing];
        
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

- (void) back
{
    [self.delegate performSelector:@selector(back)];
}

- (void) refresh
{
    [self.delegate performSelector:@selector(requestForData:) withObject:nil];
    
//    [UIView animateWithDuration:0.25
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^(void){
//                         CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 0.5);
//                         UIImageView *view = [rightItem.subviews objectAtIndex:0];
//                         view.transform = transform;
//                     }
//                     completion:^(BOOL finished){
//                         [UIView animateWithDuration:0.25
//                                               delay:0.0
//                                             options:UIViewAnimationOptionCurveLinear
//                                          animations:^(void){
//                                              CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
//                                              UIImageView *view = [rightItem.subviews objectAtIndex:0];
//                                              view.transform = transform;
//                                          }
//                                          completion:^(BOOL finished){
//                                              [UIView animateWithDuration:0.25
//                                                                    delay:0.0
//                                                                  options:UIViewAnimationOptionCurveLinear
//                                                               animations:^(void){
//                                                                   CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 1.5);
//                                                                   UIImageView *view = [rightItem.subviews objectAtIndex:0];
//                                                                   view.transform = transform;
//                                                               }
//                                                               completion:^(BOOL finished){
//                                                                   [UIView animateWithDuration:0.25
//                                                                                         delay:0.0
//                                                                                       options:UIViewAnimationOptionCurveLinear
//                                                                                    animations:^(void){
//                                                                                        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
//                                                                                        UIImageView *view = [rightItem.subviews objectAtIndex:0];
//                                                                                        view.transform = transform;
//                                                                                    }
//                                                                                    completion:nil];
//                                                               }];
//                                          }];
//                     }];
}

- (void) chooseAirport
{
    [self.delegate performSelector:@selector(chooseAirPort:) withObject:self.apCode];
}

- (void) chooseIncoming
{
    if(!isChoosing)
    {
        incoming.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        
        if(!beginAnimation)
        {
            outgoing.hidden = NO;
            
            [UIView animateWithDuration:0.5
                             animations:^(void){
                                 beginAnimation = YES;
                                 incoming.frame = CGRectMake(180, 5, 70, 30);
                                 outgoing.frame = CGRectMake(180, 45, 70, 30);
                             }
                             completion:^(BOOL finished){
                                 beginAnimation = NO;
                                 isChoosing = YES;
                             }];
        }
    }
    else
    {
        incoming.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        outgoing.backgroundColor = [UIColor blackColor];
        
        if(!beginAnimation)
        {
            [UIView animateWithDuration:0.5
                             animations:^(void){
                                 beginAnimation = YES;
                                 [self bringSubviewToFront:incoming];
                                 incoming.frame = CGRectMake(180, 25, 70, 30);
                                 outgoing.frame = CGRectMake(180, 25, 70, 30);
                             }
                             completion:^(BOOL finished){
                                 incoming.backgroundColor = [UIColor blackColor];
                                 beginAnimation = NO;
                                 isChoosing = NO;
                                 self.isIncoming = YES;
                                 [self.delegate performSelector:@selector(requestForData:) withObject:nil];
                             }];
        }
    }
}

- (void) chooseOutgoing
{
    if(!isChoosing)
    {
        outgoing.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        
        if(!beginAnimation)
        {
            incoming.hidden = NO;
            
            [UIView animateWithDuration:0.5
                             animations:^(void){
                                 beginAnimation = YES;
                                 incoming.frame = CGRectMake(180, 5, 70, 30);
                                 outgoing.frame = CGRectMake(180, 45, 70, 30);
                             }
                             completion:^(BOOL finished){
                                 beginAnimation = NO;
                                 isChoosing = YES;
                             }];
        }
    }
    else
    {
        incoming.backgroundColor = [UIColor blackColor];
        outgoing.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        
        if(!beginAnimation)
        {
            [UIView animateWithDuration:0.5
                             animations:^(void){
                                 beginAnimation = YES;
                                 [self bringSubviewToFront:outgoing];
                                 incoming.frame = CGRectMake(180, 25, 70, 30);
                                 outgoing.frame = CGRectMake(180, 25, 70, 30);
                             }
                             completion:^(BOOL finished){
                                 outgoing.backgroundColor = [UIColor blackColor];
                                 beginAnimation = NO;
                                 isChoosing = NO;
                                 self.isIncoming = NO;
                                 [self.delegate performSelector:@selector(requestForData:) withObject:nil];
                             }];
        }
    }
}

- (void) highlight:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
    [sender performSelector:@selector(setBackgroundColor:) withObject:[UIColor blackColor] afterDelay:0.25];
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
