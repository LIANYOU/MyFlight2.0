//
//  MapManager.m
//  MyMap
//
//  Created by qianfeng on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapManager.h"

@implementation MapManager
@synthesize locationManager = _locationManager;

-(id)initMyManager{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"servies is not enabled");
        }else{
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //设置距离筛选器distanceFilter，下面表示设备至少移动500米，才通知delegate
            self.locationManager.distanceFilter = 500;
            //或者没有筛选器的默认设置：
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            //启动请求
            [self.locationManager startUpdatingLocation];
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation 
{ 
    
} 

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error {
    NSLog(@"get location failed");
}


-(void)dealloc{
    [super dealloc];
    self.locationManager  = nil;
}

@end
