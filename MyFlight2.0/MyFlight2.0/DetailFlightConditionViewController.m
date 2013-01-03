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
   
    
    //注册微信号
    [WXApi registerApp:tencentWeChatAppID];
    // Do any additional setup after loading the view from its nib.
    
    [self.btnMessage addTarget:self action:@selector(btnMessageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPhone addTarget:self action:@selector(btnPhoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnShare addTarget:self action:@selector(btnShareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMoreShare addTarget:self action:@selector(btnMoreShareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView * myView = [self.view viewWithTag:999];
    myView.layer.cornerRadius = 6;
    myView.layer.masksToBounds = YES;
    
    
    myFlightConditionDetailData = [[FlightConditionDetailData alloc]initWithDictionary:self.dic];
    
    [flightLine setImage:[UIImage imageNamed:@"circle_green_change.png"]];
    flightLine.frame = CGRectMake(71, 111, 138, 33);
    flightLine.clipsToBounds = YES;
    flightLine.contentMode = UIViewContentModeLeft;
    
    //判断提前还是晚点
    if ([myFlightConditionDetailData.realDeptTime isEqualToString:@"-"]) {
        NSLog(@"---------------------");
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
    
    
    [self fillAllData];
    
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
    if ([myFlightConditionDetailData.flightState isEqualToString:@"起飞"]) {
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
        CGRect frame = flightLine.frame;
        frame.size.width=frame.size.width*(curTime/totalTime);
        flightLine.frame=frame;
    }
    self.shareMsg = [NSString stringWithFormat:@"%@#%@#航班，计划于%@从%@机场%@起飞[飞机]，%@抵达%@机场%@。",myFlightConditionDetailData.deptDate,myFlightConditionDetailData.flightNum,myFlightConditionDetailData.expectedDeptTime,myFlightConditionDetailData.deptAirport,myFlightConditionDetailData.flightHTerminal,myFlightConditionDetailData.expectedArrTime,myFlightConditionDetailData.arrAirport,myFlightConditionDetailData.flightTerminal];
    self.shareMsgWithWeibo = [NSString stringWithFormat:@"%@@my机票@新华旅行网",self.shareMsg];
    
}
//短信btn
-(void)btnMessageClick:(id)sender{
    
    SMSViewController * sendMessange = [[SMSViewController alloc]init];
    [self.navigationController pushViewController:sendMessange animated:YES];
    [sendMessange release];
}
-(void)btnPhoneClick:(id)sender{
    
}
-(void)btnShareClick:(id)sender{
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


#pragma mark - 所有地图相关初始化
-(void)aboutMap{
    
    myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 50, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 50)];
    myMapView.delegate = self;
  

}




//飞行地图
- (IBAction)littleFlightClick:(id)sender {
    [self getFlightMapData];
    myFlightView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)]autorelease];
    myFlightView.backgroundColor = [UIColor redColor];
    [myFlightView addSubview:myMapView];
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myBtn.frame = CGRectMake(0, 0, 50, 40);
    [myBtn addTarget:self action:@selector(backToDetail) forControlEvents:UIControlEventTouchUpInside];
    [myFlightView addSubview:myBtn];
    [UIView transitionFromView:self.view toView:myFlightView duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
        
    }];
}

-(void)backToDetail{
    [UIView transitionFromView:myFlightView toView:self.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL isFinish){
        
    }];
}





-(void)getFlightMapData{
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/flightRoute.jsp"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:self.deptAirPortCode forKey:@"dpt"];
    [request setPostValue:self.arrAirPortCode forKey:@"arr"];
    
    
    [request setPostValue:@"google" forKey:@"mapType"];
    
    [request setPostValue:myFlightConditionDetailData.realDeptTime forKey:@"deptTime"];
    
    [request setPostValue:myFlightConditionDetailData.realArrTime forKey:@"arrTime"];
    
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
    
   
    MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
    lineOne.title = @"blue";
    [overlays addObject:lineOne];
    [myMapView addOverlays:overlays];
    [lineOne release];
    [myMapView reloadInputViews];
}


#pragma mark - 大头针图片
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"myPin";
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
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


#pragma mark - dealloc
-(void)dealloc{
    
    [super dealloc];
}
@end
