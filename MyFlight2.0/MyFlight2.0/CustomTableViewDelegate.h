//
//  CustomTableViewDelegate.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomTableViewDelegate <NSObject>


-(void)delegateViewController:(id *)controller didSelectItem:(NSString *)item; // 其他选项传值


@end
