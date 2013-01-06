//
//  WeatherViewController.m
//  MyFlight2.0
//
//  Created by apple on 13-1-5.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "WeatherViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "UIButton+BackButton.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

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
    
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
//    todayCount = whichDay(year, month, day);
    
    
//    hightArray = [NSArray alloc]initWithObjects:@"170", nil
    nsDateString = [NSString  stringWithFormat:@"%4d-%02d-%02d",year,month,day];
    [self getData];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height - 40 - 20) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:myTableView];
    myTableView.userInteractionEnabled = NO;
    myTableView.separatorColor = [UIColor clearColor];
}

-(void)getData{
    // Do any additional setup after loading the view from its nib.
    
    // NSString * myUrl = [NSString stringWithFormat:@"%@3gWeb/api/provision.jsp",BASE_Domain_Name];
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/newWeather.jsp"];
    
    // NSURL * url = [NSURL URLWithString:myUrl];
//    http://223.202.36.179:9580/web/phone/newWeather.jsp?city=101010100&type=PEK&edition=v1.0&date=2013-01-03
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"101010100" forKey:@"city"];
    [request setPostValue:nsDateString forKey:@"date"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"type"];
    [request setPostValue:@"v1.0" forKey:@"edition"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * temp1= [temp stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        myDic = [temp1 objectFromJSONString];
        myArray = [[NSMutableArray alloc]initWithArray:[myDic objectForKey:@"weatherList"]];
        NSLog(@"weatherList count : %d",[myArray count]);
        [myTableView reloadData];
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 170;
    }else{
        return 44;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"numberOfRowsInSection %d",[phoneInfoArray count]);
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UIColor * thisColor = [UIColor colorWithRed:197/255.0 green:187/255.0 blue:179/255.0 alpha:1];
    if (myArray) {
        myTableView.separatorColor = [UIColor whiteColor];
        
        if (indexPath.row == 0) {
            //左上角图片
//            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_green_bg.png"]];
//            imageView.frame = CGRectMake(10, 0, 140, 40);
            UIView * bottomViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 169, 320, 1)];
            bottomViewLine.backgroundColor = [UIColor colorWithRed:237/255.0 green:231/255.0 blue:226/255.0 alpha:1];;
            [cell addSubview:bottomViewLine];
            [bottomViewLine release];
            
            UIView * imagebgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 140, 40)];
            imagebgView.backgroundColor = BACKGROUND_COLOR_GREEN;
            imagebgView.layer.cornerRadius = 6;
            imagebgView.layer.masksToBounds = YES;
            UILabel * todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
            todayLabel.font = [UIFont systemFontOfSize:20];
            todayLabel.textColor = [UIColor whiteColor];
            [imagebgView addSubview:todayLabel];
            todayLabel.text = @"今天";
            todayLabel.backgroundColor = [UIColor clearColor];
            [todayLabel release];
            [cell addSubview:imagebgView];
            [imagebgView release];
            
            UILabel * dateDuLabel = [[UILabel alloc]initWithFrame:CGRectMake(46, 13, 94, 22)];
            dateDuLabel.backgroundColor = [UIColor clearColor];
            dateDuLabel.font = [UIFont systemFontOfSize:11];
            dateDuLabel.textColor = [UIColor whiteColor];
            [imagebgView addSubview:dateDuLabel];
            [dateDuLabel release];
            
            //大字气温
//            UILabel * templatLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120 - 20 - 44, 120, 44)];
//            templatLabel.backgroundColor = [UIColor clearColor];
//            templatLabel.font = [UIFont systemFontOfSize:30];
//            templatLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//            [cell addSubview:templatLabel];
//            [templatLabel release];
            
            
            //大气温图片
            UIImageView * bigPicImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
            bigPicImageView.frame = CGRectMake(185, 27, 115, 115);
            [cell addSubview:bigPicImageView];
            [bigPicImageView release];
            
            //-12*/0*
            UILabel * templaName = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 140, 21)];
            templaName.backgroundColor = [UIColor clearColor];
            templaName.font = [UIFont systemFontOfSize:22];
            templaName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0  blue:51/255.0  alpha:1];
            templaName.textAlignment = NSTextAlignmentRight;
            [cell addSubview:templaName];
            [templaName release];
            
            //晴转多云
            UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 89, 140, 21)];
            label1.font = [UIFont systemFontOfSize:17];
            label1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [cell addSubview:label1];
            [label1 release];
            label1.backgroundColor = [UIColor clearColor];
            label1.textAlignment = NSTextAlignmentRight;
            
            //风级描述
            UILabel * windLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 140, 21)];
            windLabel.font = [UIFont systemFontOfSize:17];
            windLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [cell addSubview:windLabel];
            [windLabel release];
            windLabel.backgroundColor = [UIColor clearColor];
            windLabel.textAlignment = NSTextAlignmentRight;
            
            //加数据
            NSString * dateAndDu = [NSString stringWithFormat:@"%@%@",[[myArray objectAtIndex:0]objectForKey:@"date"],[[myArray objectAtIndex:0]objectForKey:@"week"]];
            dateDuLabel.text = dateAndDu;
            
//            templatLabel.text = [[myArray objectAtIndex:0]objectForKey:@"temp"];
            
            templaName.text = [[myArray objectAtIndex:0]objectForKey:@"temp"];
            
            label1.text = [[myArray objectAtIndex:0]objectForKey:@"weather"];
            
            windLabel.text = [NSString stringWithFormat:@"%@%@",[[myArray objectAtIndex:0]objectForKey:@"wind"],[[myArray objectAtIndex:0]objectForKey:@"fl"]];
        }else{
            
            UIView * bottomViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42, 320, 1)];
            bottomViewLine.backgroundColor = [UIColor colorWithRed:237/255.0 green:231/255.0 blue:226/255.0 alpha:1];
            [cell addSubview:bottomViewLine];
            [bottomViewLine release];
            
            //左边第一张图片背景   “明天”的背景
            UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(12, 9, 51, 25)];
//            firstView.backgroundColor = BACKGROUND_COLOR_GREEN;
            firstView.layer.cornerRadius = 4;
            firstView.layer.masksToBounds = YES;
            UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 2, 42, 21)];
            firstLabel.backgroundColor = [UIColor clearColor];
            firstLabel.font = [UIFont systemFontOfSize:14];
            firstLabel.textColor = [UIColor whiteColor];
            if (indexPath.row == 1) {
                firstLabel.text = @"明天";
                firstView.backgroundColor = BACKGROUND_COLOR_GREEN;
            }else if (indexPath.row == 2){
                firstLabel.text = @"后天";
                firstView.backgroundColor = thisColor;

            }else{
                firstLabel.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"week"];
                firstView.backgroundColor = thisColor;

            }
            
            [firstView addSubview:firstLabel];
            [firstLabel release];
            [cell addSubview:firstView];
            [firstView release];
            
            //小图
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(69, 14, 22, 22)];
            [imageView setImage:[UIImage imageNamed:@""]];
            [cell addSubview:imageView];
            [imageView release];
            
            //晴转多云 + 气温
            UILabel * secLabel = [[UILabel alloc]initWithFrame:CGRectMake(107, 12, 193, 25)];
            secLabel.font = [UIFont systemFontOfSize:14];
            secLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [cell addSubview:secLabel];
            [secLabel release];
            secLabel.backgroundColor = [UIColor clearColor];
            //加数据
            secLabel.text = [NSString stringWithFormat:@"%@%@",[[myArray objectAtIndex:indexPath.row]objectForKey:@"weather"],[[myArray objectAtIndex:indexPath.row]objectForKey:@"temp"]];
        }
    }

    
    return cell;
    
}
-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
