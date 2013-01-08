//
//  AirportMainScreenTitleView.h
//  MyFlight2.0
//
//  Created by lianyou on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AirportMainScreenTitleView : UIView
{
    UIButton *leftItem;
    UIButton *rightItem;
    UIButton *pickAirPortItem;
    UIButton *incoming;
    UIButton *outgoing;
    
    __block BOOL isChoosing;
    __block BOOL beginAnimation;
}

@property (assign) id delegate;
@property (retain, nonatomic) NSString *apCode;
@property (retain, nonatomic) NSString *apName;
@property (assign) BOOL isIncoming;

- (void) reloadApName;

- (void) back;
- (void) refresh;
- (void) chooseAirport;
- (void) chooseIncoming;
- (void) chooseOutgoing;

- (void) highlight:(UIButton *) sender;

@end
