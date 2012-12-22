//
//  HistoryCheckInfoData.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "HistoryCheckInfoData.h"

@implementation HistoryCheckInfoData


- (void) setStartAirPortName:(NSString *)startAirPortName EndAirPortName:(NSString *)endAirPortName startApCode:(NSString *)startApCode endApCode:(NSString*) endApCode  searchFlag:(NSString *)flag{
    
    self.startAirPortName = startAirPortName;
    self.endAirPortName = endAirPortName;
    self.startApCode = startApCode;
    self.endApCode = endApCode;
    self.flag = flag;
   
}
@end
