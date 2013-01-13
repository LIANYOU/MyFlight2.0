//
//  AirPortCompanyData.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortCompanyData : NSObject

@property(nonatomic,retain)NSString *shortName;
@property(nonatomic,retain)NSString *longName;
@property(nonatomic,retain)NSString *code;
@property(nonatomic,retain)NSString *tel;

- (id) initWithCode:(NSString *) code shortName:(NSString *) shortName longName:(NSString *) longName tel:(NSString *) tel;

@end
