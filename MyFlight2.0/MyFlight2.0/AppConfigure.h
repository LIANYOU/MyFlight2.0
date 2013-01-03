//
//  AppConfigure.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_AppConfigure_h
#define MyFlight2_0_AppConfigure_h

#import "PublicConstUrls.h"
#import "AirPortsUility.h"
#import "TicketCheckUility.h"
#import "MyCenterUility.h"
#import "ColorUility.h"

#import "flightBookingUility.h"
#import "FrequentFlyUility.h"


#define ScreenHeight [[UIScreen mainScreen] bounds].size.height  //屏幕高度

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width //屏幕宽度

#define StateBarHeight 20.000000  //状态栏高度
#define NavgationBarHeight 44.000000 //导航栏高度 

#define MainHeight  ScreenHeight-StateBarHeight //主高度

#define MainWidth ScreenWidth //主宽度

#define  MainHeight_withoutNavBar MainHeight-NavgationBarHeight

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#endif
