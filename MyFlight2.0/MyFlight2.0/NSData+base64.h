//
//  NSData+base64.h
//  Caijing
//
//  Created by Darcy on 4/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (NSDataAdditions)
+ (NSData *) dataWithBase64EncodedString:(NSString *)string;
- (id) initWithBase64EncodedString:(NSString *)string;
- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(unsigned int)lineLength;
@end
