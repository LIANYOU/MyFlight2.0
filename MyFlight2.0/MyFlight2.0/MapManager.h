//
//  MapManager.h
//  MyMap
//
//  Created by qianfeng on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
@interface MapManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager * _locationManager ;
}
@property (nonatomic,retain)CLLocationManager * locationManager ;
-(id)initMyManager;

@end
