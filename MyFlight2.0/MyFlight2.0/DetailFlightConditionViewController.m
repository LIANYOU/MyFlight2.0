//
//  DetailFlightConditionViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-13.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "DetailFlightConditionViewController.h"
#import "SMSViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "GetAttentionFlight.h"
#import "AttentionFlight.h"

#import "SearchFlightConditionController.h"
#import "UIButton+BackButton.h"
#import "Ann.h"

@interface DetailFlightConditionViewController ()
@property(nonatomic,retain) NSString *shareMsg;
@property(nonatomic,retain) NSString *shareMsgWithWeibo;
@end

@implementation DetailFlightConditionViewController
@synthesize btnMessage,btnMoreShare,btnPhone,btnShare,planeCode,planeCompanyAndTime,planeState,from,arrive,fromFirstTime,fromFirstTimeName,fromResult,fromSceTime,fromSceTimeName,fromT,fromWeather,arriveFirstTime,arriveFirstTimeName,arriveResult,arriveSecTime,arriveSecTimeName,arriveT,arriveWeather,attentionThisPlaneBtn,littlePlaneBtn;
@synthesize dic = _dic;
@synthesize engine;
@synthesize deptAirPortCode = _deptAirPortCode, arrAirPortCode = _arrAirPortCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //地图
    [self aboutMap];
    self.view.backgroundColor = BACKGROUND_COLOR;
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(backToDetail) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    
//    depWeatherDic = [[NSMutableDictionary alloc]init];
//    arrWeatherDic = [[NSMutableDictionary alloc]init];

    tempPicNameArray = [[NSArray alloc]initWithObjects:@"暴雪",@"暴雨",@"大雪",@"大雨",@"冻雨",@"多云",@"浮尘",@"雷阵雨",@"强沙尘暴",@"晴",@"沙尘暴",@"雾",@"小雪",@"小雨",@"阴",@"雨夹雪",@"阵雪",@"阵雨",@"中雪",@"中雨",@"雷阵雨伴有冰雹",nil];


    
    
    //注册微信号
    [WXApi registerApp:tencentWeChatAppID];
    // Do any additional setup after loading the view from its nib.
    

    
    //底部4个按钮
    [self.btnMessage addTarget:self action:@selector(btnMessageClick:) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer * toolSendTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnMessageClick:)];
    toolSendTap.numberOfTapsRequired = 1;
    toolSendTap.numberOfTouchesRequired =1;
    [self.toolSendLabel addGestureRecognizer:toolSendTap];
    [toolSendTap release];

    
    [self.btnPhone addTarget:self action:@selector(btnPhoneClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * toolPhoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnPhoneClick:)];
    toolPhoneTap.numberOfTapsRequired = 1;
    toolPhoneTap.numberOfTouchesRequired = 1;
    [self.toolPhoneLabel addGestureRecognizer:toolPhoneTap];
    self.toolPhoneLabel.userInteractionEnabled = YES;
    [toolPhoneTap release];
    
    
    [self.btnShare addTarget:self action:@selector(btnShareClick:) forControlEvents:UIControlEventTouchUpInside];
    self.toolWeixinLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * toolShareTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnShareClick:)];
    toolShareTap.numberOfTouchesRequired = 1;
    toolShareTap.numberOfTapsRequired = 1;
    [self.toolWeixinLabel addGestureRecognizer:toolShareTap];
    [toolShareTap release];

    
    [self.btnMoreShare addTarget:self action:@selector(btnMoreShareClick:) forControlEvents:UIControlEventTouchUpInside];
    self.toolShareLable.userInteractionEnabled = YES;
    UITapGestureRecognizer * toolMoreShareTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnMoreShareClick:)];
    toolMoreShareTap.numberOfTouchesRequired = 1;
    toolMoreShareTap.numberOfTapsRequired = 1;
    [self.toolShareLable addGestureRecognizer:toolMoreShareTap];
    [toolMoreShareTap release];
    
    UIView * myView = [self.view viewWithTag:999];
    myView.layer.cornerRadius = 5;
    myView.layer.masksToBounds = YES;
    
    
    myFlightConditionDetailData = [[FlightConditionDetailData alloc]initWithDictionary:self.dic];
    //标题
    self.title = [NSString stringWithFormat:@"%@-%@",myFlightConditionDetailData.deptAirport,myFlightConditionDetailData.arrAirport];
    
    flightLine.frame = CGRectMake(76, 111, 148, 51);
//    flightLine.clipsToBounds = YES;
//    flightLine.contentMode = UIViewContentModeLeft;
    
    
    
    //判断提前还是晚点
    if ([myFlightConditionDetailData.realDeptTime isEqualToString:@"-"]) {
        NSLog(@"航班动态  时间中有“-”，还没到达 ---------------------");
        self.fromResult.text = @"";
        self.arriveResult.text = @"";
    }else{
        NSInteger firseTimeDiff = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.realDeptTime];
        firseTimeDiff = firseTimeDiff/60;
        NSInteger secTimeDiff = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedArrTime timeE:myFlightConditionDetailData.realArrTime];
        secTimeDiff = secTimeDiff/60;
        if (firseTimeDiff < 0) {
            NSString * relustFirst = [NSString stringWithFormat:@"比预计提前%d分钟",(-1)*firseTimeDiff];
            self.fromResult.text = relustFirst;
        }else{
            NSString * relustFirst = [NSString stringWithFormat:@"比预计晚点%d分钟",firseTimeDiff];
            self.fromResult.text = relustFirst;
        }
        
        if (secTimeDiff < 0) {
            NSString * relustSec = [NSString stringWithFormat:@"比预计提前%d分钟",(-1)*secTimeDiff];
            self.arriveResult.text = relustSec;
        }else{
            NSString * relustSec = [NSString stringWithFormat:@"比预计晚点%d分钟",secTimeDiff];
            self.arriveResult.text = relustSec;
        }
    }
    
#pragma mark - 设置阴影
    //UIView设置阴影
//    [[self.myAllBackView layer] setShadowOffset:CGSizeMake(1, 1)];
//    [[self.myAllBackView layer] setShadowRadius:5];
//    [[self.myAllBackView layer] setShadowOpacity:1];
//    [[self.myAllBackView layer] setShadowColor:[UIColor blackColor].CGColor];
    //UIView设置边框
    [[self.myAllBackView layer] setCornerRadius:5];
    [[self.myAllBackView layer] setBorderWidth:1];
    [[self.myAllBackView layer] setBorderColor:[UIColor colorWithRed:222/255.0 green:212/255.0 blue:201/255.0 alpha:1].CGColor];
    
    
    
    [self fillAllData];

    [self getArrWeatherData];
    [self getDepWeatherData];
    

    
#pragma mark - 判断是关注该航班还是取消关注
   
    if (self.isAttentionFlight == YES) {
        attentionBtnTextLabel.text = @"关注该航班";
    }else{
        attentionBtnTextLabel.text = @"取消关注";
    }
    
#pragma mark - viewDidLoadOver
}

-(void)isAttentionFlightOrNot{
   
}

-(void)deleteThisFlight{
    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;
    
    AttentionFlight * attention = [[AttentionFlight alloc] initWithMemberId:memberID
                                                               andorgSource:@"51YOU"
                                                                     andFno:myFlightConditionDetailData.flightNum
                                                                   andFdate:myFlightConditionDetailData.deptDate
                                                                     andDpt:myFlightConditionDetailData.flightDepcode
                                                                     andArr:myFlightConditionDetailData.flightArrcode
                                                                 andDptTime:myFlightConditionDetailData.deptTime
                                                                 andArrTime:myFlightConditionDetailData.arrTime
                                                                 andDptName:nil
                                                                 andArrName:nil
                                                                    andType:@"C"
                                                                  andSendTo:nil
                                                                 andMessage:nil
                                                                   andToken:hwID
                                                                  andSource:@"1"
                                                                    andHwId:hwID
                                                             andServiceCode:@"01"];
    
    
    
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDelFlightData:) name:@"关注航班" object:nil];
    [attention lookFlightAttention];
//    attention.delegate = self;
}

#pragma mark - 关注该航班按钮响应
- (IBAction)attentThisPlane:(id)sender {
    
    if (self.isAttentionFlight == NO) {
        [self deleteThisFlight];
    }else{
#pragma mark - 判断是否能关注该航班
    //关注btn是否可点击
    if ([myFlightConditionDetailData.flightState isEqualToString:@"到达"]) {
        isEnableAttent = NO;
 
    }else if ([myFlightConditionDetailData.flightState isEqualToString:@"取消"]){
        isEnableAttent = NO;
        
    }else{
        isEnableAttent = YES;

    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;

    //提醒的类型，P:PUSH,  M:短信,  PM:PUSH+短信，  C:取消
    NSString * pushType = @"P";
/*    
    要发送的人订制时必填
    手机接收格式, 多个手机号使用分号分割
    type-name-mobile
    type:J接机人 S:送机人
    name:姓名
    mobile:手机号
    
    NSString * sendTo = @"J-张三-13100000000";
*/
    AttentionFlight * attention = [[AttentionFlight alloc]initWithMemberId:memberID andorgSource:@"51YOU" andFno:myFlightConditionDetailData.flightNum andFdate:myFlightConditionDetailData.deptDate andDpt:myFlightConditionDetailData.flightDepcode andArr:myFlightConditionDetailData.flightArrcode andDptTime:myFlightConditionDetailData.deptTime andArrTime:myFlightConditionDetailData.arrTime andDptName:nil andArrName:nil andType:pushType andSendTo:nil andMessage:nil andToken:hwID andSource:@"1" andHwId:hwID andServiceCode:@"01"];
    
    
    NSLog(@"关注航班的条件 : %@, %@ , %@, %@ ,%@ , %@",myFlightConditionDetailData.flightNum,myFlightConditionDetailData.flightDepcode,myFlightConditionDetailData.flightArrcode,myFlightConditionDetailData.deptTime,myFlightConditionDetailData.arrTime,pushType);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDelFlightData:) name:@"关注航班" object:nil];
    [attention lookFlightAttention];
        
    //isEnableAttent = YES;
    }
    //self.isAttentionFlight == YES;
    }
}
-(void)receiveDelFlightData:(NSNotification *)not
{
    NSDictionary * array = [[not userInfo] objectForKey:@"arr"];
    NSString * string = [array objectForKey:@"message"];
    
    NSLog(@"-----%@",array);
    
    if (string == @"") {
        NSLog(@"关注航班成功");

        for (id obj in self.navigationController.childViewControllers) {
            if ([obj isKindOfClass:[SearchFlightConditionController class]]) {
                [(SearchFlightConditionController *)obj attentionTapEvent];
                [self.navigationController popToViewController:obj animated:YES];
            }
        }
      
    }
    
    else{
        NSLog(@"关注航班失败");
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self screenShot];
}

-(void)fillAllData{
    //    NSLog(@"%@",self.dic);
    
    self.planeCode.text = myFlightConditionDetailData.flightNum;
    self.planeCompanyAndTime.text = [NSString stringWithFormat:@"%@ %@",myFlightConditionDetailData.flightCompany,myFlightConditionDetailData.deptDate];
    self.planeState.text = myFlightConditionDetailData.flightState;
    self.from.text = myFlightConditionDetailData.deptAirport;
    self.arrive.text = myFlightConditionDetailData.arrAirport;
    self.fromWeather.text = nil;
    self.arriveWeather.text = nil;
    self.fromT.text = myFlightConditionDetailData.flightHTerminal;
    self.arriveT.text = myFlightConditionDetailData.flightTerminal;
    self.fromFirstTimeName.text = @"计划：";
    self.fromFirstTime.text = myFlightConditionDetailData.expectedDeptTime;
    self.fromSceTimeName.text = @"实际：";
    self.fromSceTime.text = myFlightConditionDetailData.realDeptTime;
    //    self.fromResult.text = @"";
    self.arriveFirstTimeName.text = @"计划：";
    self.arriveFirstTime.text = myFlightConditionDetailData.expectedArrTime;
    self.arriveSecTimeName.text = @"实际：";
    self.arriveSecTime.text = myFlightConditionDetailData.realArrTime;
    //    self.arriveResult.text = @"";
    
#pragma mark - 判断航班动态图片

    if ([myFlightConditionDetailData.flightState isEqualToString:@"起飞"]) {
        [self.arriveBackImage setImage:[UIImage imageNamed:@"icon_blue_bg.png"]];
        double totalTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.expectedArrTime];
        
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        NSLog(@"locationString : %@",locationString);
   
        double curTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.realDeptTime timeE:locationString];
        [dateformatter release];
 
        NSLog(@"起飞：%f",curTime);
        NSLog(@"total:%f",totalTime);
        NSLog(@"时间百分比：%f",curTime/totalTime);
#pragma mark - 换图
        double timePoint = curTime/totalTime;   //时间百分比
        if (timePoint > 0.6){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_4.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else if (timePoint > 0.4){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_3.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else if (timePoint > 0.2){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_2.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else{
            [flightLine setImage:[UIImage imageNamed:@"circle_state_1.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }
        
        
    }else if ([myFlightConditionDetailData.flightState isEqualToString:@"计划"]){
        [self.arriveBackImage setImage:[UIImage imageNamed:@"icon_blue_bg.png"]];
        [flightLine setImage:[UIImage imageNamed:@"circle_state_1.png"]];

    }else if ([myFlightConditionDetailData.flightState isEqualToString:@"到达"]){
        [self.arriveBackImage setImage:[UIImage imageNamed:@"icon_green_bg.png"]];
        [flightLine setImage:[UIImage imageNamed:@"circle_state_5.png"]];

    }else if ([myFlightConditionDetailData.flightState isEqualToString:@"取消"]){
        [self.arriveBackImage setImage:[UIImage imageNamed:@"icon_red_bg.png"]];
        [flightLine setImage:[UIImage imageNamed:@"circle_state_1.png"]];

    }else if ([myFlightConditionDetailData.flightState isEqualToString:@"延误"]){
        [self.arriveBackImage setImage:[UIImage imageNamed:@"icon_red_bg.png"]];
        
        double totalTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.expectedArrTime];
        
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        NSLog(@"locationString : %@",locationString);
        
        double curTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.realDeptTime timeE:locationString];
        [dateformatter release];
        
        NSLog(@"起飞：%f",curTime);
        NSLog(@"total:%f",totalTime);
        NSLog(@"时间百分比：%f",curTime/totalTime);
#pragma mark - 换图
        double timePoint = curTime/totalTime;   //时间百分比
        
        if (timePoint > 0.6){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_4.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else if (timePoint > 0.4){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_3.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else if (timePoint > 0.2){
            [flightLine setImage:[UIImage imageNamed:@"circle_state_2.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }else{
            [flightLine setImage:[UIImage imageNamed:@"circle_state_1.png"]];
            flightLine.frame = CGRectMake(76, 111, 148, 51);
        }

    }
    
    if ([myFlightConditionDetailData.flightState isEqualToString:@"起飞"]) {
        
        
//        CGRect frame = flightLine.frame;
//        frame.size.width = frame.size.width*(curTime/totalTime);
//        flightLine.frame = frame;
    }
    self.shareMsg = [NSString stringWithFormat:@"%@#%@#航班，计划于%@从%@机场%@起飞[飞机]，%@抵达%@机场%@。",myFlightConditionDetailData.deptDate,myFlightConditionDetailData.flightNum,myFlightConditionDetailData.expectedDeptTime,myFlightConditionDetailData.deptAirport,myFlightConditionDetailData.flightHTerminal,myFlightConditionDetailData.expectedArrTime,myFlightConditionDetailData.arrAirport,myFlightConditionDetailData.flightTerminal];
    self.shareMsgWithWeibo = [NSString stringWithFormat:@"%@@my机票@新华旅行网",self.shareMsg];
    
}
//短信btn
-(void)btnMessageClick:(id)sender{
    
    SMSViewController * sendMessange = [[SMSViewController alloc]init];
    if (myFlightConditionDetailData) {
        NSLog(@"myFlightConditionDetailData is ok");
    }else{
        NSLog(@"myFlightConditionDetailData is nil");
    }
    sendMessange.subMyFlightConditionDetailData = myFlightConditionDetailData;
    [self.navigationController pushViewController:sendMessange animated:YES];
    [sendMessange release];
}
-(void)btnPhoneClick:(id)sender{
    NSLog(@"打电话");
    UIActionSheet * callPhoneActionSheet = [[UIActionSheet alloc]initWithTitle:@"电话咨询" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"出发机场电话",@"到达机场电话",@"航班公司电话", nil];
    [callPhoneActionSheet showInView:self.view];
}
-(void)btnShareClick:(id)sender{
    NSLog(@"发微信");
    //发送内容给微信
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/capture.png",cachedictionary];
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[self getSmallImageFromOriginalImage:[UIImage imageWithContentsOfFile:filePath]]];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
    
    message.title = @"分享一张图片";
    message.mediaObject = ext;
    message.description = self.shareMsg;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    /**
     设定发送到场景，还是会话
     会话(WXSceneSession：0)或者朋友圈(WXSceneTimeline：1)
     **/
    //    req.scene = _scene;
    
    [WXApi sendReq:req];
}

#pragma mark -- 图片压缩
-(UIImage *) getSmallImageFromOriginalImage:(UIImage *)image{
    UIImage *originalImage = image;
    UIImage *smallImage = nil;
    CGSize originalSize = originalImage.size;
    CGSize smallSize = CGSizeMake(originalSize.width / 4, originalSize.height / 4);
    
    CGFloat originalWidth = originalSize.width;
    CGFloat originalHeigh = originalSize.height;
    CGFloat smallWidth = smallSize.width;
    CGFloat smallHeigh = smallSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = smallWidth;
    CGFloat scaleHeigh = smallHeigh;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(originalSize, smallSize) == NO) {
        CGFloat widthFactory = smallWidth / originalWidth;
        CGFloat heighFactory = smallHeigh / originalHeigh;
        
        if (widthFactory > heighFactory) {
            scaleFactor = widthFactory;
        }else {
            scaleFactor = heighFactory;
        }
        scaleWidth = originalWidth * scaleFactor;
        scaleHeigh = originalHeigh * scaleFactor;
        if (widthFactory > heighFactory) {
            thumbnailPoint.y = (smallHeigh - scaleHeigh) * 0.4;
        }else {
            thumbnailPoint.x = (smallWidth - scaleWidth) * 0.4;
        }
        UIGraphicsBeginImageContext(smallSize);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.height = scaleHeigh;
        thumbnailRect.size.width = scaleWidth;
        [originalImage drawInRect:thumbnailRect];
        smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return smallImage;
}


-(void)btnMoreShareClick:(id)sender{
    UIActionSheet * moreShare = [[UIActionSheet alloc]initWithTitle:@"更多分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到新浪微博",@"分享到腾讯微博",@"短信分享",@"邮件分享", nil];
    [moreShare showInView:self.view];
}
#pragma mark - actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([actionSheet.title isEqualToString:@"更多分享"]) {
        NSLog(@"actionsheet更多分享");
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachedictionary = [paths objectAtIndex:0];
        if (buttonIndex == 0) {
            //分享新浪微博
            SinaWeibo *sinaweibo = [self sinaweibo];
            if (![sinaweibo isAuthValid]) {
                [sinaweibo logIn];
            }else{
                [sinaweibo requestWithURL:@"statuses/upload.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           self.shareMsgWithWeibo,@"status",
                                           [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary]], @"pic", nil]
                               httpMethod:@"POST"
                                 delegate:self];
            }
        }else if(buttonIndex == 1){
            //分享到腾讯微博
            engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.51you.com/mobile/myflight.html"];
            
            if ([engine isAuthorizeExpired]) {
                [engine logInWithDelegate:self onSuccess:@selector(loginSucess) onFailure:@selector(loginFailed)];
            }else{
                [engine setRootViewController:self];
                [engine UIBroadCastMsgWithContent:self.shareMsgWithWeibo
                                         andImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary]]
                                      parReserved:nil
                                         delegate:self
                                      onPostStart:@selector(postStart)
                                    onPostSuccess:@selector(createSuccess:)
                                    onPostFailure:@selector(createFail:)];
            }
        }else if(buttonIndex == 2){
            //发短信
            Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
            if (messageClass != nil) {
                // Check whether the current device is configured for sending SMS messages
                if ([messageClass canSendText]) {
                    [self displaySMSComposerSheet];
                }
                else {
                    UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备没有短信功能" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                    [showMsg show];
                    [showMsg release];
                }
            }
            else {
                UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:@"提示" message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                [showMsg show];
                [showMsg release];
            }
            
        }else if(buttonIndex == 3){
            //发邮件
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            if ([MFMailComposeViewController canSendMail]) {
                [mc setSubject:@"航班信息分享"];
                [mc setMessageBody:self.shareMsg isHTML:NO];
                
                NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *cachedictionary = [paths objectAtIndex:0];
                NSString *path = [NSString stringWithFormat:@"%@/capture.png",cachedictionary];
                NSData *data = [NSData dataWithContentsOfFile:path];
                [mc addAttachmentData:data mimeType:@"image/png" fileName:@"blood_orange"];
                [self presentModalViewController:mc animated:YES];
                [mc release];
            }
        }else if(buttonIndex == 4){
            //取消
        }
    }else{
        
        
        if (buttonIndex == 0) {
            //出发机场电话
            NSString *deviceType = [UIDevice currentDevice].model;
            //NSString *deviceType = [UIDevice currentDevice].modellocalizedModel;
            
            if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }else{
                
//                NSString * temp = [NSString stringWithFormat:@"tel:%@",selectedPhoneNum];
//                UIWebView*callWebview =[[UIWebView alloc] init];
//                NSURL *telURL =[NSURL URLWithString:temp];// 貌似tel:// 或者 tel: 都行
//                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            }
            
            
        }else if (buttonIndex == 1){
            //到达机场电话
            
            NSString *deviceType = [UIDevice currentDevice].model;
            //NSString *deviceType = [UIDevice currentDevice].modellocalizedModel;
            
            if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }else{
//                NSString * temp = [NSString stringWithFormat:@"tel:%@",selectedPhoneNum];
//                UIWebView*callWebview =[[UIWebView alloc] init];
//                NSURL *telURL =[NSURL URLWithString:temp];// 貌似tel:// 或者 tel: 都行
//                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            }
            
            
            
            
        }else if (buttonIndex == 2){
            //航班公司电话
            
            NSString *deviceType = [UIDevice currentDevice].model;
            //NSString *deviceType = [UIDevice currentDevice].modellocalizedModel;
            
            if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }else{
//                  myFlightConditionDetailData.flightNum
//                NSString * temp = [NSString stringWithFormat:@"tel:%@",selectedPhoneNum];
//                UIWebView*callWebview =[[UIWebView alloc] init];
//                NSURL *telURL =[NSURL URLWithString:temp];// 貌似tel:// 或者 tel: 都行
//                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            }
            
            
            
        }
    }
    
    
    
}

#pragma mark --sendEmail functions
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -- sendSMS functions
-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.body = self.shareMsg;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}
#pragma mark -- sendSMS delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultSent:
            break;
        case MessageComposeResultFailed:{
            UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:@"提示" message:@"短信发送失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [showMsg show];
            [showMsg release];}
            break;
        default:
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark --SinaWeibo functions
- (SinaWeibo *)sinaweibo
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.justWeibo;
}

#pragma mark SinaWeibo Delegate
-(void) sinaweiboDidLogIn:(SinaWeibo *)sinaweiboLogined{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"statuses/upload.json"
                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               self.shareMsgWithWeibo,@"status",
                               [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary]], @"pic", nil]
                   httpMethod:@"POST"
                     delegate:self];
}

-(void) showShareResultMsg:(NSString *) message{
    UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [showMsg show];
    [showMsg release];
}
//截屏程序
-(void) screenShot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    [imageData writeToFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary] atomically:YES];
    
}

#pragma mark - tencentWeibo Share functions
- (void)postStart {
    NSLog(@"%s", __FUNCTION__);
    //    [self showAlertMessage:@"开始发送"];
}

- (void)createSuccess:(NSDictionary *)dict {
    [self showShareResultMsg:@"分享成功."];
}

- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    //    [self showAlertMessage:@"发送失败！"];
}

#pragma mark - tencentWeibo login Delegate
- (void)onSuccessLogin{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    
    engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.51you.com/mobile/myflight.html"];
    [engine setRootViewController:self];
    [engine UIBroadCastMsgWithContent:self.shareMsgWithWeibo
                             andImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary]]
                          parReserved:nil
                             delegate:self
                          onPostStart:@selector(postStart)
                        onPostSuccess:@selector(createSuccess:)
                        onPostFailure:@selector(createFail:)];
    [self showShareResultMsg:@"分享成功."];
}
- (void)onFailureLogin:(NSError *)error{
    
}

#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"]){
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"]){
    }
    else if ([request.url hasSuffix:@"statuses/update.json"]){
        [self showShareResultMsg:@"分享失败."];
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"]){
        [self showShareResultMsg:@"分享失败."];
    }
}

#pragma mark -- Tencent WeChat Delegate
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        //        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        [self viewContent:temp.message];
    }
}

- (void) viewContent:(WXMediaMessage *) msg
{
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"消息来自微信"];
    NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"]){
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"]){
    }
    else if ([request.url hasSuffix:@"statuses/update.json"]){
        [self showShareResultMsg:@"分享成功."];
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"]){
        [self showShareResultMsg:@"分享成功."];
    }
}

#pragma mark - 算时间差
- (double)mxGetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE
{
    double timeDiff = 0.0;
    
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"HH:mm"];
    NSDate *dateS = [formatters dateFromString:timeS];
    
    NSDateFormatter *formatterE = [[NSDateFormatter alloc]init];
    [formatterE setDateFormat:@"HH:mm"];
    NSDate *dateE = [formatterE dateFromString:timeE];
    
    timeDiff = [dateE timeIntervalSinceDate:dateS ];
    
    return timeDiff;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取天气（出发和到达的）
-(void)getWeather{
    
}



#pragma mark - 所有地图相关初始化
-(void)aboutMap{
    
    myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 44)];
    myMapView.delegate = self;
  

}



#pragma mark - 小飞机点击事件翻到地图
//飞行地图
- (IBAction)littleFlightClick:(id)sender {
    [self getFlightMapData];
    myFlightView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)]autorelease];
    myFlightView.backgroundColor = [UIColor redColor];
    [myFlightView addSubview:myMapView];
//    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    myBtn.frame = CGRectMake(0, 0, 50, 40);
//    [myBtn addTarget:self action:@selector(backToDetail) forControlEvents:UIControlEventTouchUpInside];
//    [myFlightView addSubview:myBtn];
    [UIView transitionFromView:self.view toView:myFlightView duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
        if (isFinish) {
            isMap = YES;
            
        }
    }];
}

-(void)backToDetail{
    if (isMap == NO) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [UIView transitionFromView:myFlightView toView:self.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL isFinish){
            if (isFinish) {
                isMap = NO;
                self.title = @"航班详情";
//                [myMapView removeAnnotations:myMapView.annotations];
            }
        }];
    }
}





-(void)getFlightMapData{
    NSString * urlStr = [NSString stringWithFormat:@"%@/web/phone/prod/flight/flightRoute.jsp",BASE_Domain_Name];
    //王浩链接
//    NSString * urlStr = [NSString stringWithFormat:@"%@/Flight/GetFlightRoute.json",BASE_Domain_Name];
//    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/flightRoute.jsp"];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    
    [request setPostValue:self.deptAirPortCode forKey:@"dpt"];
    [request setPostValue:self.arrAirPortCode forKey:@"arr"];
    
    
    [request setPostValue:@"google" forKey:@"mapType"];
    
    [request setPostValue:myFlightConditionDetailData.deptTime forKey:@"deptTime"];
    
    [request setPostValue:myFlightConditionDetailData.arrTime forKey:@"arrTime"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        
        NSDictionary * myDic = [str objectFromJSONString];
        NSLog(@"dic : %@",myDic);
        
        [self fillMapPoint:myDic];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)fillMapPoint:(NSDictionary *)dic{
    NSMutableArray *overlays = [[NSMutableArray alloc] init];

    CLLocationCoordinate2D centerDept;
    NSArray * pointArray = [dic objectForKey:@"routeList"];
    centerDept.latitude = ([[[pointArray objectAtIndex:0] objectForKey:@"latitude"]doubleValue] + [[[pointArray objectAtIndex:2] objectForKey:@"latitude"]doubleValue])/2.0;
    centerDept.longitude = ([[[pointArray objectAtIndex:0] objectForKey:@"longitude"]doubleValue] + [[[pointArray objectAtIndex:2] objectForKey:@"longitude"]doubleValue])/2.0;
    
    MKCoordinateSpan span;
    span.latitudeDelta = 25;
    span.longitudeDelta = 25;
    
    MKCoordinateRegion region = {
        centerDept,span
    };
    myMapView.region = region;
    
    //画线数组
    CLLocationCoordinate2D pointsToUse[2];
    CLLocationCoordinate2D coords;
    coords.latitude = [[[pointArray objectAtIndex:0] objectForKey:@"latitude"]doubleValue];
    coords.longitude = [[[pointArray objectAtIndex:0] objectForKey:@"longitude"]doubleValue];
    pointsToUse[0] = coords;
    NSLog(@"1 : %f,%f",coords.latitude,coords.longitude);
    
    coords.latitude = [[[pointArray objectAtIndex:2] objectForKey:@"latitude"]doubleValue];
    coords.longitude = [[[pointArray objectAtIndex:2] objectForKey:@"longitude"]doubleValue];
    pointsToUse[1] = coords;
    NSLog(@"2 : %f,%f",coords.latitude,coords.longitude);
    
    
#pragma mark - 添加大头针
    //出发机场
    Ann * pin1 = [[Ann alloc]init];
    [pin1 setLatitude:[[[pointArray objectAtIndex:0] objectForKey:@"latitude"]doubleValue]];
    [pin1 setLongitude:[[[pointArray objectAtIndex:0] objectForKey:@"longitude"]doubleValue]];
    [pin1 setMyTitle:[NSString stringWithFormat:@"%@",myFlightConditionDetailData.deptAirport ]];
    [myMapView addAnnotation:pin1];
    
    
    
    //到达机场
    Ann * pin2 = [[Ann alloc]init];
    [pin2 setLatitude:[[[pointArray objectAtIndex:2] objectForKey:@"latitude"]doubleValue]];
    [pin2 setLongitude:[[[pointArray objectAtIndex:2] objectForKey:@"longitude"]doubleValue]];
    [pin2 setMyTitle:[NSString stringWithFormat:@"%@",myFlightConditionDetailData.arrAirport]];
    [myMapView addAnnotation:pin2];
    
   
    
     x1 = [[[pointArray objectAtIndex:0] objectForKey:@"latitude"]doubleValue];
     y1 = [[[pointArray objectAtIndex:0] objectForKey:@"longitude"]doubleValue];
     x2 = [[[pointArray objectAtIndex:2] objectForKey:@"latitude"]doubleValue];
     y2 = [[[pointArray objectAtIndex:2] objectForKey:@"longitude"]doubleValue];
    
    double totalTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.expectedArrTime];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"locationString : %@",locationString);
    
    double curTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.realDeptTime timeE:locationString];
    [dateformatter release];
    double timePoint1 = curTime/totalTime;
    
    //小飞机
    Ann * pin3 = [[Ann alloc]init];
    
    [pin3 setLatitude:(x2 - x1) * timePoint1 + x1];
    [pin3 setLongitude:(y2 - y1) * timePoint1 + y1];
    NSLog(@"pin3.latitude : %f,pin3.longitude : %f",pin3.latitude,pin3.longitude);
    [pin3 setMyTitle:@"ok"];
    [pin3 setMyTitle:@"飞机"];
    [myMapView addAnnotation:pin3];
    
    
    
    //线
    MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
    lineOne.title = @"blue";
    [overlays addObject:lineOne];
    [myMapView addOverlays:overlays];
//    [lineOne release];
    [myMapView reloadInputViews];
}


#pragma mark - 大头针图片
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKPinAnnotationView *pinView = nil;
    static NSString *defaultPinID = @"myPin";
 
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
    if ([[annotation title]isEqualToString:@"飞机"]) {
        NSLog(@"[[annotation title]isEqualToString:@\"飞机\"]");
        [pinView setImage:[UIImage imageNamed:@"icon_loading.png"]];
        pinView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        CGAffineTransform rotate = CGAffineTransformMakeRotation(M_1_PI - atan((x1-x2)/(y1-y2)));
        CGAffineTransform rotate;
        if (x1>x2) {
            rotate = CGAffineTransformMakeRotation(tan((x1-x2)/(y1-y2)));
        }else{
            rotate = CGAffineTransformMakeRotation(M_2_PI - tan((x1-x2)/(y1-y2)));
        }
         
        
        [pinView setTransform:rotate];
        
//        pinView.frame = CGRectMake(0, 0, 40, 40);
    }else{
        pinView.pinColor = MKPinAnnotationColorRed;
    }
    pinView.canShowCallout = YES;
    pinView.animatesDrop = NO;
    return pinView;
}

#pragma mark - 地图画线
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        NSLog(@"yes");
        MKPolylineView *lineview=[[[MKPolylineView alloc] initWithOverlay:overlay] autorelease];
        lineview.strokeColor=[[UIColor blueColor] colorWithAlphaComponent:1];
        lineview.lineWidth=4.0;
        return lineview;
    }
    return nil;
}

#pragma mark - 获取天气
-(void)getDepWeatherData{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/web/phone/newWeather.jsp",BASE_Domain_Name];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    if (self.depAirPortData.weatherCode.length < 1) {
        [request setPostValue:@"101010100" forKey:@"city"];
    }else{
        [request setPostValue:self.depAirPortData.weatherCode forKey:@"city"];
    }
    
    
    [request setPostValue:myFlightConditionDetailData.deptDate forKey:@"date"];
    [request setPostValue:self.depAirPortData.apCode forKey:@"type"];
    [request setPostValue:@"v1.0" forKey:@"edition"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * temp1= [temp stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        NSDictionary * dic = [temp1 objectFromJSONString];
        self.depWeatherDic = [[dic objectForKey:@"weatherList"]objectAtIndex:0];
        
#pragma mark - 天气判断并填充        
        NSMutableString * littlePicName = [self.depWeatherDic objectForKey:@"weather"];
        NSMutableString * selectPicName = [[NSMutableString alloc]initWithCapacity:0];
        for (int i = 0; i < [tempPicNameArray count]; i++) {
            if ([littlePicName hasSuffix:[tempPicNameArray objectAtIndex:i]]) {
                NSString * myStr = [tempPicNameArray objectAtIndex:i];
                
                [selectPicName setString:myStr];
                
            }
        }
        
        NSLog(@"小图 ：%@",selectPicName);
        NSString * str = [NSString stringWithFormat:@"%@.png",selectPicName];
        NSLog(@"image name :%@",str);
        [self.depWeatherImageView setImage:[UIImage imageNamed:str]];
        self.fromWeather.text = [self.depWeatherDic objectForKey:@"temp"];
#pragma mark -
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)getArrWeatherData{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/web/phone/newWeather.jsp",BASE_Domain_Name];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    if (self.depAirPortData.weatherCode.length < 1) {
        [request setPostValue:@"101010100" forKey:@"city"];
    }else{
        [request setPostValue:self.arrAirPortData.weatherCode forKey:@"city"];
    }
    
    
    [request setPostValue:myFlightConditionDetailData.deptDate forKey:@"date"];
    [request setPostValue:self.arrAirPortData.apCode forKey:@"type"];
    [request setPostValue:@"v1.0" forKey:@"edition"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * temp1= [temp stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        NSDictionary * dic = [temp1 objectFromJSONString];
        self.arrWeatherDic = [[dic objectForKey:@"weatherList"]objectAtIndex:0];
       
        
#pragma mark - 天气判断并填充
        NSMutableString * littlePicName = [self.arrWeatherDic objectForKey:@"weather"];
        NSMutableString * selectPicName = [[NSMutableString alloc]initWithCapacity:0];
        for (int i = 0; i < [tempPicNameArray count]; i++) {
            if ([littlePicName hasSuffix:[tempPicNameArray objectAtIndex:i]]) {
                NSString * myStr = [tempPicNameArray objectAtIndex:i];
                
                [selectPicName setString:myStr];
                
            }
        }
        
        NSLog(@"小图 ：%@",selectPicName);
        NSString * str = [NSString stringWithFormat:@"%@.png",selectPicName];
        NSLog(@"image name :%@",str);
        [self.arrWeatherImageView setImage:[UIImage imageNamed:str]];
        self.arriveWeather.text = [self.arrWeatherDic objectForKey:@"temp"];
        NSLog(@"");
#pragma mark -
       
        
        
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

#pragma mark - dealloc
-(void)dealloc{
    
    [super dealloc];
}
@end
