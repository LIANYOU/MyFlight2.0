//
//  LocationAirPortWJ.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-14.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface LocationAirPortWJ : NSObject

@property (nonatomic, retain) NSString * x;
@property (nonatomic, retain) NSString * y;
@property (nonatomic, retain) NSString * mapType;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * codeType;
@property (nonatomic, assign) id<ServiceDelegate>delegate;
-(id)initWithX:(NSString * )x
          andY:(NSString * )y
    andMapType:(NSString *)mapType
       andCode:(NSString *)code
   andCodeType:(NSString *)codeType
   andDelegate:(id<ServiceDelegate>)delegate;
-(void)getLocationName;
@end
