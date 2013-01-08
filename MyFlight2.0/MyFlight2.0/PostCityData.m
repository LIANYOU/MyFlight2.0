//
//  PostCityData.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-8.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "PostCityData.h"

@implementation PostCityData

-(id) initWithName:(NSString *)name
           andCode:(NSString *)code
         andPinyin:(NSString *)pinyin
        andHotcity:(NSString *)hotcity
{
    if ([super init]) {
        self.name = name;
        self.code = code;
        self.pinyin = pinyin;
        self.hotcity = hotcity;
    }
    return self;
}

@end
