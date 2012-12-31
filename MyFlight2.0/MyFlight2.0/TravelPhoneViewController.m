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
    didFinish = NO;
    [self getData];
    phoneInfoArray = [[NSMutableArray alloc]initWithCapacity:0];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:215/255.0 blue:206/255.0 alpha:1];

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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 160, 32)];
    titlelabel.font = [UIFont systemFontOfSize:14];
    if ([phoneInfoArray count] == 0) {
        NSLog(@"phoneInfoArray count == 0");
    }else{
        NSDictionary * dic1 = [phoneInfoArray objectAtIndex:1];
        NSString * phoneStr = [dic1 objectForKey:@"department"];
        NSLog(@"phoneStr : %@",phoneStr);
        titlelabel.text = [[phoneInfoArray objectAtIndex:indexPath.row]objectForKey:@"department"];
    }
    
    
    titlelabel.backgroundColor = [UIColor clearColor];
    [cell addSubview:titlelabel];
    
    phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 4, 100, 32)];
    phoneLabel.font = [UIFont systemFontOfSize:14];
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
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_gray.png"]];
    imageView.frame = CGRectMake(0, 42, 320, 2);
    [cell addSubview:imageView];
    [imageView release];
    
    UIImageView * phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_tep_travel.png"]];
    phoneImage.frame = CGRectMake(290, 12, 20, 20);
    [cell addSubview:phoneImage];
    [phoneImage release];

    
    return cell;
        
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"AirportCommonlyPhone" forKey:@"RequestType"];
    [request setPostValue:self.subAirPortData.apEname forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];

        
        NSDictionary * dic = [str objectFromJSONString];
        NSLog(@"block before : %d",[[dic valueForKey:@"AirportCommonlyPhone"]count]);
        [phoneInfoArray addObjectsFromArray:[dic valueForKey:@"AirportCommonlyPhone"]];
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

-(void)dealloc{
    self.subAirPortData = nil;
    [titlelabel release];
    [phoneLabel release];
    [super dealloc];
}
@end
