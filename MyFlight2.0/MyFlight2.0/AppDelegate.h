//
//  AppDelegate.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#define sinaWeiboAppKey @"2087728917"
#define sinaWeiboAppSecret @"09a3a8e1e92ca58086e9c6258122fc59"
#define sinaWeiboAppRedirectURI @"http://m.51you.com"

#define tencentAppID @"100353306";
#define tencentAppSecret @"ff1dd29bda1584abfcfab78479dfa32f";
#define tencentAppRedirectURI @"www.qq.com";

#define tencentWeiboAppKey @"801285127"
#define tencentWeiboAppSecret @"aaa2aa75a21502e6c6abb0bbbf64cb99"
#define tencentWeiboAppRedirectURI @"http://www.51you.com/mobile/myflight.html"

#define tencentWeChatAppID @"wx5b721ecc8556f12c"
#define tencentWeChatAppKey @"fbfd760d82bcdee8a2500edda8cdd01d"

#import <UIKit/UIKit.h>

@class ViewController;//
@class SinaWeibo;

@interface AppDelegate : UIResponder  <UIApplicationDelegate>{
    SinaWeibo *sinaweibo;
    SinaWeibo *justWeibo;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (readonly, nonatomic) SinaWeibo *justWeibo;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
