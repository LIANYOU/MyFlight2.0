//
//  HistoryCheckInfoData.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryCheckInfoData : NSObject


@property(nonatomic,retain)NSString *startAirPortName;
@property(nonatomic,retain)NSString *endAirPortName;
@property(nonatomic,retain)NSString *startApCode;
@property(nonatomic,retain)NSString *endApCode;
@property(nonatomic,retain)NSString *flag;

- (void) setStartAirPortName:(NSString *)startAirPortName EndAirPortName:(NSString *)endAirPortName startApCode:(NSString *)startApCode endApCode:(NSString*) endApCode  searchFlag:(NSString *)flag;
 
@end
