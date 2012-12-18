//
//  DetailFlightConditionViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-13.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FlightConditionDetailData.h"
@interface DetailFlightConditionViewController : UIViewController<UIActionSheetDelegate>{
    NSDictionary * _dic;
    FlightConditionDetailData * myFlightConditionDetailData;
    
    
    
    IBOutlet UIButton * btnMessage;
    IBOutlet UIButton * btnPhone;
    IBOutlet UIButton * btnShare;
    IBOutlet UIButton * btnMoreShare;
    
    IBOutlet UILabel * planeCode;   //飞机编号
    IBOutlet UILabel * planeCompanyAndTime; //飞机所属公司以及时间
    IBOutlet UILabel * planeState;  //飞机当前状态
    IBOutlet UILabel * from;    //起飞地点
    IBOutlet UILabel * arrive;      //终点
    IBOutlet UILabel * fromWeather;     //起飞地点气温
    IBOutlet UILabel * arriveWeather;   //目的地气温
    IBOutlet UILabel * fromT;   //起飞地点塔楼
    IBOutlet UILabel * arriveT; //目的地塔楼
    
    IBOutlet UILabel * fromFirstTimeName;   //起点状态（计划、延误、取消等）
    IBOutlet UILabel * fromFirstTime;       //状态的时间（起飞）
    IBOutlet UILabel * fromSceTimeName;     //起点实际状态（各种状态）
    IBOutlet UILabel * fromSceTime;         //实际时间（各种状态）
    IBOutlet UILabel * fromResult;          //比计划晚点30分钟（等之类的计算）
    
    
    IBOutlet UILabel * arriveFirstTimeName; //目的的状态
    IBOutlet UILabel * arriveFirstTime;
    IBOutlet UILabel * arriveSecTimeName;
    IBOutlet UILabel * arriveSecTime;
    IBOutlet UILabel * arriveResult;
    
    IBOutlet UIButton * littlePlaneBtn; //小飞机图标，不知道干嘛的
    
    IBOutlet UIButton * attentionThisPlaneBtn; //关注该航班
   
}

@property(nonatomic,retain) IBOutlet UIButton * btnMessage;
@property(nonatomic,retain) IBOutlet UIButton * btnPhone;
@property(nonatomic,retain) IBOutlet UIButton * btnShare;
@property(nonatomic,retain) IBOutlet UIButton * btnMoreShare;

@property(nonatomic,retain)IBOutlet UILabel * planeCode;   //飞机编号
@property(nonatomic,retain)IBOutlet UILabel * planeCompanyAndTime; //飞机所属公司以及时间
@property(nonatomic,retain)IBOutlet UILabel * planeState;  //飞机当前状态
@property(nonatomic,retain)IBOutlet UILabel * from;    //起飞地点
@property(nonatomic,retain)IBOutlet UILabel * arrive;      //终点
@property(nonatomic,retain)IBOutlet UILabel * fromWeather;     //起飞地点气温
@property(nonatomic,retain)IBOutlet UILabel * arriveWeather;   //目的地气温
@property(nonatomic,retain)IBOutlet UILabel * fromT;   //起飞地点塔楼
@property(nonatomic,retain)IBOutlet UILabel * arriveT; //目的地塔楼

@property(nonatomic,retain)IBOutlet UILabel * fromFirstTimeName;   //起点状态（计划、延误、取消等）
@property(nonatomic,retain)IBOutlet UILabel * fromFirstTime;       //状态的时间（起飞）
@property(nonatomic,retain)IBOutlet UILabel * fromSceTimeName;     //起点实际状态（各种状态）
@property(nonatomic,retain)IBOutlet UILabel * fromSceTime;         //实际时间（各种状态）
@property(nonatomic,retain)IBOutlet UILabel * fromResult;          //比计划晚点30分钟（等之类的计算）


@property(nonatomic,retain)IBOutlet UILabel * arriveFirstTimeName; //目的的状态
@property(nonatomic,retain)IBOutlet UILabel * arriveFirstTime;
@property(nonatomic,retain)IBOutlet UILabel * arriveSecTimeName;
@property(nonatomic,retain)IBOutlet UILabel * arriveSecTime;
@property(nonatomic,retain)IBOutlet UILabel * arriveResult;

@property(nonatomic,retain)IBOutlet UIButton * littlePlaneBtn; //小飞机图标，不知道干嘛的

@property(nonatomic,retain)IBOutlet UIButton * attentionThisPlaneBtn; //关注该航班
@property(nonatomic,retain)NSDictionary * dic;
@end
