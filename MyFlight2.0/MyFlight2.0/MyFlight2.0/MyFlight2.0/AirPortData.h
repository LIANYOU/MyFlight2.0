//
//  AirPortData.h
//  JOSNAndTableView
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortData : NSObject

@property(nonatomic,retain)NSString *apCode;
@property(nonatomic,retain)NSString *apName;
@property(nonatomic,retain)NSString *apEname;
@property(nonatomic,retain)NSString *apLName;
@property(nonatomic,retain)NSString *hotCity;
@property(nonatomic,retain)NSString *cityName;
@property(nonatomic,retain)NSString *air_x;
@property(nonatomic,retain)NSString *air_y;

- (id) initWithapCode:(NSString *) apCode apName:(NSString *) apName hotCity:(NSString *) hotCity cityName:(NSString *) cityName air_x:(NSString *)air_x air_y:(NSString *) air_y;

@end
