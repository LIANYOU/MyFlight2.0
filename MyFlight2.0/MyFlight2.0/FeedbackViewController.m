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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 300, 120)];
    
    textView.layer.borderColor = [BORDER_COLOR CGColor];
    textView.layer.borderWidth = 1.0f;
    textView.layer.cornerRadius = 10.0f;
    
    textView.backgroundColor = [UIColor clearColor];
    
    textView.delegate = self;
    
    [self.view addSubview:textView];
    [textView release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 185, 140, 20)];
    
    label.text = @"您的联系方式";
    label.textColor = FONT_COLOR_BIG_GRAY;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    
    [self.view addSubview:label];
    [label release];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 220, 300, 40)];
    
    textField.layer.borderColor = [BORDER_COLOR CGColor];
    textField.layer.borderWidth = 1.0f;
    textField.layer.cornerRadius = 10.0f;
    
    [textField addTarget:self action:@selector(userBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(userEndEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:textField];
    [textField release];
    
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
    NSURL *url = [[NSURL alloc] initWithString:GET_RIGHT_URL_WITH_Index(@"/web/phone/feedback.jsp")];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:textView.text forKey:@"feedMessage"];
    [request setPostValue:textField.text forKey:@"contacts"];
    [request setPostValue:@"" forKey:@"name"];
    [request setPostValue:EDITION_VALUE forKey:@"version"];
    [request setPostValue:SOURCE_VALUE forKey:KEY_source];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
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

- (void) userBeginEdit:(UITextField *)sender
{
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    invisibleButton.frame = self.view.frame;
    
    [invisibleButton addTarget:self action:@selector(userEndEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invisibleButton];
}

- (void) userEndEdit:(id)sender
{
    [textField resignFirstResponder];
    [textView resignFirstResponder];
    
    [invisibleButton removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
