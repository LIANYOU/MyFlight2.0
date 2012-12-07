//
//  DNWrapper.h
//  test接口
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNWrapper : NSObject

+ (NSString *)getMD5String:(NSString *)url;

+(NSString *)md5:(NSString *)str;

@end
