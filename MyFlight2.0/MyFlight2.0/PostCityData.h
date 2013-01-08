//
//  PostCityData.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-8.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostCityData : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * pinyin;
@property (nonatomic, retain) NSString * hotcity;

-(id) initWithName:(NSString *)name
           andCode:(NSString *)code
         andPinyin:(NSString *)pinyin
        andHotcity:(NSString *)hotcity;


@end
