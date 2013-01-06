//
//  FlightCompanyDistrubuteViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPortData.h"
#import <MapKit/MapKit.h>
#import "MapManager.h"
#import "Ann.h"
@interface FlightCompanyDistrubuteViewController : UIViewController<MKMapViewDelegate,UIWebViewDelegate>
{
//    NSString * _airPortCode;
    AirPortData * _subAirPortData;
    NSMutableData * myData;
    UILabel * myTextView;
    UILabel * myTitleLabel;
    UIView * myView;
    
    MKMapView * myMapView;
    MapManager * myMapManager;
    MKAnnotationView * myPlaneImageView;
    NSMutableArray * airportCoordinateArray;//经纬度
    UIScrollView * scrollView;
    UIWebView * myWebView;
    BOOL isWebView;
}
//@property(nonatomic,retain) NSString * airPortCode;
@property(nonatomic,retain)AirPortData * subAirPortData;

@end
