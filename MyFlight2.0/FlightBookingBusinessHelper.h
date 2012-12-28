//
//  FlightBookingBusinessHelper.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
#import "payVo.h"
#import "flightPassengerVo.h"
#import "flightItineraryVo.h"
#import "flightContactVo.h"
#import "bookingGoFlightVo.h"
#import "bookingReturnFlightVo.h"
@interface FlightBookingBusinessHelper : NSObject


+ (void) flightBookingWithGoflight:(NSDictionary *) infoDic bookingGoFlightVo:(bookingGoFlightVo *)  bookingGoFlightVo bookingReturnFlightVo:(bookingReturnFlightVo *) bookingReturnFlightVo flightContactVo:(flightContactVo *) flightContactVo flightItineraryVo:(flightItineraryVo *) flightItineraryVo flightPassengerVo:(flightPassengerVo *)flightPassengerVo payVo:(payVo *)payVo delegate:(id<ServiceDelegate>) delegate ;

@end
