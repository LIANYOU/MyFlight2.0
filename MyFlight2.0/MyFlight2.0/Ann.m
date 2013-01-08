//
//  Ann.m
//  MyFlight2.0
//
//  Created by apple on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "Ann.h"

@implementation Ann
@synthesize myTitle = _myTitle,mySubtitle = _mySubtitle,longitude = _longitude,latitude = _latitude;
-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D center;
    center.longitude = self.longitude;
    center.latitude = self.latitude;
    return center;
}

-(NSString * )title{
    return self.myTitle;
}

-(NSString *)subtitle{
    return self.mySubtitle;
}



-(void)dealloc{
    self.myTitle = nil;
    self.mySubtitle = nil;
    [super dealloc];
}
@end
