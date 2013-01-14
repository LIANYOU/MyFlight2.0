//
//  FeedbackViewController.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "FeedbackViewController.h"
@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"意见反馈";
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 14)];
    
    label.text = @"您的意见";
    label.textColor = FONT_COLOR_DEEP_GRAY;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:label];
    [label release];
    
    UIView *block;
    
    block = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 120)];
    
    block.layer.borderColor = [BORDER_COLOR CGColor];
    block.layer.borderWidth = 1.0f;
    block.layer.cornerRadius = CORNER_RADIUS;
    
    block.backgroundColor = FOREGROUND_COLOR;
    
    [self.view addSubview:block];
    [block release];
    
    message = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 290, 110)];
    
    message.textColor = FONT_COLOR_GRAY;
    message.backgroundColor = [UIColor clearColor];
    message.font = [UIFont systemFontOfSize:14.0f];
    
    [block addSubview:message];
    [message release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 140, 14)];
    
    label.text = @"您的联系方式";
    label.textColor = FONT_COLOR_DEEP_GRAY;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:label];
    [label release];
    
    block = [[UIView alloc] initWithFrame:CGRectMake(10, 220, 300, 40)];
    
    block.layer.borderColor = [BORDER_COLOR CGColor];
    block.layer.borderWidth = 1.0f;
    block.layer.cornerRadius = CORNER_RADIUS;
    
    block.backgroundColor = FOREGROUND_COLOR;
    
    [self.view addSubview:block];
    [block release];
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
    
    address.backgroundColor = [UIColor clearColor];
    address.textColor = FONT_COLOR_GRAY;
    address.font = [UIFont systemFontOfSize:14.0f];
    
    [address addTarget:self action:@selector(endInput) forControlEvents:UIControlEventEditingDidEndOnExit];
    [address addTarget:self action:@selector(repositionText) forControlEvents:UIControlEventEditingDidBegin];
    
    [block addSubview:address];
    [address release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(10, 280, 300, 40);
    
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"orange_btn.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"orange_btn_click.png"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endInput)];
    UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(endInput)];
    
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:swipe];
    
    [tap release];
    [swipe release];
}

- (void) send:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"/web/phone/feedback.jsp")];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:message.text forKey:@"feedMessage"];
    [request setPostValue:address.text forKey:@"contacts"];
    [request setPostValue:@"" forKey:@"name"];
    [request setPostValue:EDITION_VALUE forKey:@"version"];
    
    [request setPostValue:HWID_VALUE forKey:KEY_hwId];
    [request setPostValue:SOURCE_VALUE forKey:KEY_source];
    [request setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [request setPostValue:EDITION_VALUE forKey:KEY_edition];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
        NSString *string = [request responseString];
        NSLog(@"%@",string);
        
        NSError *error = nil;
        
        NSDictionary *responseDictionary = [response objectFromJSONDataWithParseOptions:JKParseOptionNone error:&error];
        
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
            }
            else
            {
                alertMessage = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"resultCode"] message:[result objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertMessage show];
                [alertMessage release];
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        alertMessage = [[UIAlertView alloc] initWithTitle:@"" message:@"网络无响应，请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertMessage show];
        [alertMessage release];
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void) repositionText
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 150, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) repositionView
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 150, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) endInput
{
    if([message isFirstResponder])
    {
        [message resignFirstResponder];
    }
    
    if([address isFirstResponder])
    {
        [self repositionView];
        [address resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
