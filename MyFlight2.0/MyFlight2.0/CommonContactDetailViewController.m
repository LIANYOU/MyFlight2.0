//
//  CommonContactDetailViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/25/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "CommonContactDetailViewController.h"
#import "LoginBusiness.h"
#import "AppConfigure.h"
#import "CommonContact.h"
@interface CommonContactDetailViewController ()

@end

@implementation CommonContactDetailViewController



//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    NSString *message = [info objectForKey:KEY_message];
    
    UIAlertView *viewAlert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [viewAlert show];
    [viewAlert release];

    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    UIAlertView *viewAlert = [[UIAlertView alloc] initWithTitle:@"删除联系人成功" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [viewAlert show];
    [viewAlert release];
    
}

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
    
    CommonContact *contact = [[CommonContact alloc] initWithName:@"李测试" type:@"01" certType:@"0" certNo:@"555555555555555" contactId:@"2de69decad604966abbc8b802677dc82"];
    
    
    
    LoginBusiness *bis =[[LoginBusiness alloc] init];
    
//    [bis deleteCommonPassengerWithPassengerId:nil userDic:nil andDelegate:self];
    
    [bis editCommonPassengerWithPassengerData:contact andDelegate:self];
    
    [bis release];
    [contact release];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
