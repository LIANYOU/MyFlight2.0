//
//  ServiceShellDelegate.h
//  Camellia
//
//  Created by sss on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//协议 一些业务处理之后的 回调函数 
@protocol ServiceShellDelegate <NSObject>

//登陆成功后的回调函数 
-(void) loginDidComplete:(BOOL) isSucceeded;

@end
