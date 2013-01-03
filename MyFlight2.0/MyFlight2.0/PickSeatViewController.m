//
//  PickSeatViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-27.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "PickSeatViewController.h"

@interface PickSeatViewController ()

@end

@implementation PickSeatViewController

@synthesize tktno;
@synthesize segIndex;
@synthesize passName;
@synthesize airline;
@synthesize orgId;
@synthesize org;
@synthesize symbols;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) requestForData
{
    NSURL *url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/huet/getSeatMapHandler.jsp"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:self.tktno forKey:@"tktno"];
    [request setPostValue:self.segIndex forKey:@"segIndex"];
    [request setPostValue:self.passName forKey:@"passName"];
    [request setPostValue:self.airline forKey:@"airline"];
    [request setPostValue:self.orgId forKey:@"orgId"];
    [request setPostValue:self.org forKey:@"org"];
    [request setPostValue:self.symbols forKey:@"symbols"];
    [request setPostValue:@"1" forKey:@"source"];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
        NSError *error = nil;
        
        [responseDictionary release];
        
        responseDictionary = [[response objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:&error] retain];
        
        if(error != nil)
        {
            NSLog(@"JSON Parse Failed\n");
        }
        else
        {
            NSLog(@"JSON Parse Succeeded\n");
            
            NSDictionary *result = [responseDictionary objectForKey:@"result"];
            
            if([[result objectForKey:@"resultCode"] isEqualToString:@""])
            {
                for(NSString *string in [responseDictionary allKeys])
                {
                    NSLog(@"%@\n",string);
                }
                for(NSString *string in [responseDictionary allValues])
                {
                    NSLog(@"%@\n",string);
                }
                
                [self updateTitle];
                [map drawSeatMap];
            }
            else
            {
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        NSLog(@"JSON Request Failed\n");
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestForData];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    header.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.85f alpha:1.0f];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, 320, 14)];

    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:14.0f];
    title.textAlignment = UITextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    [self.view addSubview:header];
    [header release];
    
    map = [[SeatMapView alloc] initWithFrame:CGRectMake(10, 55, [UIScreen mainScreen].bounds.size.height < 500 ? 325:400, 400)];
    
    [self.view addSubview:map];
    [map release];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 340:420, 300, 25)];
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
    
    label.text = @"紧急出口";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    [footer addSubview:label];
    [label release];
    
    UIImageView *icon;
    
    icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"e.png"]];
    
    icon.frame = CGRectMake(65, 0, 25, 25);
    icon.contentMode = UIViewContentModeScaleAspectFit;
    
    [footer addSubview:icon];
    [icon release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 40, 25)];
    
    label.text = @"可选";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    [footer addSubview:label];
    [label release];
    
    icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seat1.png"]];
    
    icon.frame = CGRectMake(135, 0, 25, 25);
    icon.contentMode = UIViewContentModeScaleAspectFit;
    
    [footer addSubview:icon];
    [icon release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(165, 0, 40, 25)];
    
    label.text = @"已占";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    [footer addSubview:label];
    [label release];
    
    icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_seat.png"]];
    
    icon.frame = CGRectMake(205, 0, 25, 25);
    icon.contentMode = UIViewContentModeScaleAspectFit;
    
    [footer addSubview:icon];
    [icon release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(235, 0, 40, 25)];
    
    label.text = @"选中";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    [footer addSubview:label];
    [label release];
    
    icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pitch_on.png"]];
    
    icon.frame = CGRectMake(275, 0, 25, 25);
    icon.contentMode = UIViewContentModeScaleAspectFit;
    
    [footer addSubview:icon];
    [icon release];
    
    [self.view addSubview:footer];
    [footer release];
    
    UIButton *checkIn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    checkIn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 370:450, 300, 40);
    
    checkIn.backgroundColor = [UIColor orangeColor];
    checkIn.layer.borderColor = [[UIColor grayColor] CGColor];
    checkIn.layer.borderWidth = 1.0;
    checkIn.layer.cornerRadius = 5.0;
    
    [checkIn setTitle:@"确定" forState:UIControlStateNormal];
    [checkIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkIn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    checkIn.titleLabel.font = [UIFont systemFontOfSize:20];
    checkIn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [checkIn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkIn];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    [responseDictionary release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateTitle
{
    title.text = [NSString stringWithFormat:@"%@  %@-%@-%@  %@-%@",[[responseDictionary objectForKey:@"segment"] objectForKey:@"flightNo"], [[[responseDictionary objectForKey:@"segment"] objectForKey:@"depTime"] objectForKey:@"year"], [[[responseDictionary objectForKey:@"segment"] objectForKey:@"depTime"] objectForKey:@"month"], [[[responseDictionary objectForKey:@"segment"] objectForKey:@"depTime"] objectForKey:@"day"], [[responseDictionary objectForKey:@"segment"] objectForKey:@"depAirportCode"], [[responseDictionary objectForKey:@"segment"] objectForKey:@"arrAirportCode"]];
}

- (void) checkIn
{
    NSURL *url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/huet/getPaHandler.jsp"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary;
    
    dictionary = [responseDictionary objectForKey:@"cussRequest"];
    
    [request setPostValue:[responseDictionary objectForKey:@"tktno"] forKey:@"tktno"];
    [request setPostValue:[responseDictionary objectForKey:@"segIndex"] forKey:@"segIndex"];
    [request setPostValue:[responseDictionary objectForKey:@"passName"] forKey:@"passName"];
    [request setPostValue:[responseDictionary objectForKey:@"org"] forKey:@"org"];
    [request setPostValue:[responseDictionary objectForKey:@"airline"] forKey:@"airline"];
    [request setPostValue:[responseDictionary objectForKey:@"orgId"] forKey:@"orgId"];
    [request setPostValue:[responseDictionary objectForKey:@"etNo"] forKey:@"symbols"];
    
    [request setPostValue:[responseDictionary objectForKey:@"recNo"] forKey:@"nameCh"];
    [request setPostValue:[responseDictionary objectForKey:@"pwId"] forKey:@"name"];
    [request setPostValue:[responseDictionary objectForKey:@"org"] forKey:@"ffpNumber"];
    [request setPostValue:[responseDictionary objectForKey:@"orgId"] forKey:@"seatNo"];
    [request setPostValue:[responseDictionary objectForKey:@"passName"] forKey:@"um"];
    
    [request setPostValue:[responseDictionary objectForKey:@"idNo"] forKey:@"depAirportCode"];
    [request setPostValue:[responseDictionary objectForKey:@"etNo"] forKey:@"arrAirportCode"];
    [request setPostValue:[responseDictionary objectForKey:@"pwId"] forKey:@"depTime"];
    [request setPostValue:[responseDictionary objectForKey:@"org"] forKey:@"flightNo"];
    [request setPostValue:[responseDictionary objectForKey:@"orgId"] forKey:@"cabin"];
    
    [request setPostValue:[responseDictionary objectForKey:@"passName"] forKey:@"seatNos"];
    [request setPostValue:[responseDictionary objectForKey:@"idNo"] forKey:@"ffpAirline"];
    [request setPostValue:[responseDictionary objectForKey:@"etNo"] forKey:@"ffpNum"];
    [request setPostValue:[responseDictionary objectForKey:@"recNo"] forKey:@"baseCabin"];
    [request setPostValue:[responseDictionary objectForKey:@"pwId"] forKey:@"idInfoType"];
    [request setPostValue:[responseDictionary objectForKey:@"org"] forKey:@"idInfo"];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
        NSError *error = nil;
        
        NSDictionary *responseDict = [response objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:&error];
        
        if(error != nil)
        {
            NSLog(@"JSON Parse Failed\n");
        }
        else
        {
            NSLog(@"JSON Parse Succeeded\n");
            
            NSDictionary *result = [responseDict objectForKey:@"result"];
            
            if([[result objectForKey:@"resultCode"] isEqualToString:@""])
            {
                for(NSString *string in [responseDict allKeys])
                {
                    NSLog(@"%@\n",string);
                }
                for(NSString *string in [responseDict allValues])
                {
                    NSLog(@"%@\n",string);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        NSLog(@"JSON Request Failed\n");
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

@end
