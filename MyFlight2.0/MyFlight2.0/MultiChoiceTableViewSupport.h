//
//  MultiChoiceTableViewSupport.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MultiChoiceTableViewSupport <NSObject>

- (void) didSelectItemWithTag:(NSInteger) tag;
- (void) didDeselectItemWithTag:(NSInteger) tag;

@end
