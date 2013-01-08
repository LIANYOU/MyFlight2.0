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




//访问网络失败
- (void) requestDidFailed:(NSDictionary *) info;


//访问成功 并且返回正确结果
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info;

//访问成功 但是返回的是错误信息
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info;



@end
