//
//  TravelPhoneViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TravelPhoneViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "UIButton+BackButton.h"

@interface TravelPhoneViewController ()

@end

@implementation TravelPhoneViewController
//@synthesize airPort = _airPort;
@synthesize subAirPortData = _subAirPortData;
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
    // Do any additional setup after loading the view from its nib.
    self.title = @"常用电话";
    self.view.backgroundColor = FOREGROUND_COLOR;
    selectedPhoneNum = [[NSMutableString alloc]initWithCapacity:0];
    
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    
    didFinish = NO;
    [self getData];
    phoneInfoArray = [[NSMutableArray alloc]initWithCapacity:0];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:myTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection %d",[phoneInfoArray count]);
    return [phoneInfoArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString * title = [[phoneInfoArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    NSString * phoneNum = [[phoneInfoArray objectAtIndex:indexPath.row]objectForKey:@"phone"];
//    UIAlertView * phoneAlert = [[UIAlertView alloc]initWithTitle:title message:phoneNum delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
//    [phoneAlert show];
//    [phoneAlert release];
//    [selectedPhoneNum setString:@""];
    [selectedPhoneNum setString:phoneNum];
//    NSLog(@"%@",selectedPhoneNum);
//    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
//    [actionSheet addButtonWithTitle:phoneNum];
//    [actionSheet addButtonWithTitle:@"取消"];
//    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
//    [actionSheet showInView:self.navigationController.view];
//    [actionSheet release];
    
#pragma mark - 判断设备是否能打电话
    NSString *deviceType = [UIDevice currentDevice].model;
    //NSString *deviceType = [UIDevice currentDevice].modellocalizedModel;
    
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil];
         [alert show];
         [alert release];
        
    }else{
        NSString * temp = [NSString stringWithFormat:@"tel:%@",selectedPhoneNum];
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:temp];// 貌似tel:// 或者 tel: 都行
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 160, 32)];
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = FONT_COLOR_BIG_GRAY;
        if ([phoneInfoArray count] == 0) {
            NSLog(@"phoneInfoArray count == 0");
        }else{
            NSDictionary * dic1 = [phoneInfoArray objectAtIndex:1];
            NSString * phoneStr = [dic1 objectForKey:@"title"];
            NSLog(@"phoneStr : %@",phoneStr);
            titlelabel.text = [[phoneInfoArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        }
        UIView * myBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        myBackgroundView.backgroundColor = BACKGROUND_COLOR;
        cell.selectedBackgroundView = myBackgroundView;
        [myBackgroundView release];
        
        UIImageView * bottomLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42, 320, 1)];
        bottomLineImageView.backgroundColor = Line_COLOR_GRAY;
        [cell addSubview:bottomLineImageView];
        [bottomLineImageView release];
        
        UIImageView * bottomLineImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
        bottomLineImageView1.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bottomLineImageView1];
        [bottomLineImageView1 release];

        
        titlelabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:titlelabel];
        
        phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 100, 32)];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        phoneLabel.textColor = FONT_COLOR_BIG_GRAY;
        if ([phoneInfoArray count] == 0) {
            NSLog(@"phoneInfoArray count == 0");
        }else{
            NSDictionary * dic1 = [phoneInfoArray objectAtIndex:1];
            NSString * phoneStr = [dic1 objectForKey:@"phone"];
            NSLog(@"phoneStr : %@",phoneStr);
            phoneLabel.text = [[phoneInfoArray objectAtIndex:indexPath.row]objectForKey:@"phone"];
        }
        phoneLabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:phoneLabel];
        
//        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_gray.png"]];
//        imageView.frame = CGRectMake(0, 42, 320, 2);
//        [cell addSubview:imageView];
//        [imageView release];
        
        UIImageView * phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_tep_travel.png"]];
        phoneImage.frame = CGRectMake(290, 17, 10, 10);
        [cell addSubview:phoneImage];
        [phoneImage release];
        
//        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        myBtn.frame = cell.bounds;
//        myBtn.tag = indexPath.row;
//        [myBtn addTarget:self action:@selector(btnInCellClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:myBtn];

    }
    
    return cell;
        
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/tel.jsp"];
    
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.subAirPortData.apCode forKey:@"airportCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    [request setPostValue:@"1" forKey:@"edition"];


    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"电话str : %@",str);
        
        NSDictionary * dic = [str objectFromJSONString];
        NSLog(@"block before : %d",[[dic valueForKey:@"airportPhone"]count]);
        [phoneInfoArray addObjectsFromArray:[dic valueForKey:@"airportPhone"]];
        didFinish = YES;
        [myTableView reloadData];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setHeadersReceivedBlock:^(NSDictionary * headDic){
       allLength = [[headDic objectForKey:@"Content-Length"]doubleValue];
        NSLog(@"allLength : %f",allLength);
    }];

//    [request setDataReceivedBlock:^(NSData * addData){
//        if (addLength == 0) {
//            addLength = [addData length];
//        }else{
//            addLength = addLength + [addData length];
//        }
//        NSLog(@"addLength : %f",addLength);
//        lengthPoint = addLength/allLength;
//        NSLog(@"lengthPoint : %f",lengthPoint);
//        [myData appendData:addData];
//    }];
    
    [request setDelegate:self];
    [request startAsynchronous];

}

-(void)btnInCellClick:(UIButton *)btn{
    
    
}

#pragma mark - actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //buttonIndex == 0 拨打电话
    if (buttonIndex == 0) {
//        NSString * temp = [NSString stringWithFormat:@"tel:%@",selectedPhoneNum];
//        UIWebView*callWebview =[[UIWebView alloc] init];
//        NSURL *telURL =[NSURL URLWithString:temp];// 貌似tel:// 或者 tel: 都行
//        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];

         
         
    }

}

#pragma mark - alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
       
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:temp]];
        
        
        
        /*
         
         2、调用 电话phone
         05	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8008808888"]];
         06	iOS应用内拨打电话结束后返回应用
         07	一般在应用中拨打电话的方式是：
         08	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://123456789"]];
         09
         10	使用这种方式拨打电话时，当用户结束通话后，iphone界面会停留在电话界面。
         11	用如下方式，可以使得用户结束通话后自动返回到应用：
         12	UIWebView*callWebview =[[UIWebView alloc] init];
         13	NSURL *telURL =[NSURL URLWithString:@"tel:10086"];// 貌似tel:// 或者 tel: 都行
         14	[callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
         15	//记得添加到view上
         16	[self.view addSubview:callWebview];
         
         
         
         */
    }
}


-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    self.subAirPortData = nil;
    [titlelabel release];
    [phoneLabel release];
    [super dealloc];
}
@end
