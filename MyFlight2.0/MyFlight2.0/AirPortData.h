//
//  AirPortData.h
//  JOSNAndTableView
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortData : NSObject

@property(nonatomic,retain)NSString *apCode; //机场三字码
@property(nonatomic,retain)NSString *apName; //机场名字
@property(nonatomic,retain)NSString *apEname; //机场名字拼音
@property(nonatomic,retain)NSString *apLName; //机场的长名字  XXXXX机场
@property(nonatomic,retain)NSString *hotCity; //是否是热门机场
@property(nonatomic,retain)NSString *cityName; //热门城市
@property(nonatomic,retain)NSString *air_x; //机场坐标 
@property(nonatomic,retain)NSString *air_y; 

- (id) initWithapCode:(NSString *) apCode apName:(NSString *) apName hotCity:(NSString *) hotCity cityName:(NSString *) cityName air_x:(NSString *)air_x air_y:(NSString *) air_y;

@end
