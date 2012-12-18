//
//  ServiceDelegate.h
//  MyFirstApp
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceDelegate <NSObject>

@optional

- (void)requestDidFinished:(NSDictionary *) info;

- (void) requestDidFailed:(NSDictionary *) info;



@end
