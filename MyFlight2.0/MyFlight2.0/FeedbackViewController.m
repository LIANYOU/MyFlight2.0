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
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
    
    label.text = @"您的意见";
    label.textColor = FONT_COLOR_BIG_GRAY;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    
    [self.view addSubview:label];
    [label release];
    
    message = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 300, 120)];
    
    message.layer.borderColor = [BORDER_COLOR CGColor];
    message.layer.borderWidth = 1.0f;
    message.layer.cornerRadius = 10.0f;
    
    message.backgroundColor = [UIColor clearColor];
    
    message.delegate = self;
    
    [self.view addSubview:message];
    [message release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 185, 140, 20)];
    
    label.text = @"您的联系方式";
    label.textColor = FONT_COLOR_BIG_GRAY;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    
    [self.view addSubview:label];
    [label release];
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(10, 220, 300, 40)];
    
    address.layer.borderColor = [BORDER_COLOR CGColor];
    address.layer.borderWidth = 1.0f;
    address.layer.cornerRadius = 10.0f;
    
    address.delegate = self;
    
    [self.view addSubview:address];
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
    [request setPostValue:SOURCE_VALUE forKey:KEY_source];
    
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
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        NSLog(@"JSON Request Failed\n");
    }];
    
    [request setDelegate:self];
    [request startSynchronous];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    invisibleButton.frame = self.view.frame;
    
    [invisibleButton addTarget:textView action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invisibleButton];
    
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [invisibleButton removeFromSuperview];
    
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    invisibleButton.frame = self.view.frame;
    
    [invisibleButton addTarget:textField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invisibleButton];
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [invisibleButton removeFromSuperview];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
