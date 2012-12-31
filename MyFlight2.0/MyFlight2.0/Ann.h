//
//  Ann.h
//  MyFlight2.0
//
//  Created by apple on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Ann : NSObject<MKAnnotation>{
    NSString * _myTitle;
    NSString * _mySubtitle;
    double _latitude;
    double _longitude;
}
@property (nonatomic,copy)NSString * myTitle;
@property (nonatomic,copy)NSString * mySubtitle;
@property (nonatomic,assign)double latitude;
@property (nonatomic,assign)double longitude;

@end
