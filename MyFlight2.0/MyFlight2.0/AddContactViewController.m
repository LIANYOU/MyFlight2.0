//
//  AddContactViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "AddContactViewController.h"
#import "LoginBusiness.h"
@interface AddContactViewController ()

@end

@implementation AddContactViewController





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
    self.title = @"添加乘机人";
    
    LoginBusiness *bis = [[LoginBusiness alloc] init];
    
    [bis addCommonPassengerWithPassengerName:@"代儿童" type:@"02" certType:@"9" certNo:@"2009-8-8" userDic:nil andDelegate:self];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_personTypeLabel release];
    [_personNameLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPersonTypeLabel:nil];
    [self setPersonNameLabel:nil];
    [super viewDidUnload];
}
- (IBAction)personInputInfoBn:(id)sender {
}

//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    
}




@end
