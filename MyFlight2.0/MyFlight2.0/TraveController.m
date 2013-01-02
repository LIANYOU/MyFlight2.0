//
//  TraveController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TraveController.h"
#import "UIQuickHelp.h"
#import "PostViewController.h"
#import "UIButton+BackButton.h"
@interface TraveController ()

@end

@implementation TraveController

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
    self.postView.hidden = YES;
    
    self.navigationItem.title = @"行程单配送";
    
    name.delegate = self;
    address.delegate = self;
    phone.delegate = self;
    city.delegate = self;
    
    UIButton * backBtn_ = [UIButton backButtonType:0 andTitle:@""];
    [backBtn_ addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn_];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton *histroyBut = [UIButton backButtonType:2 andTitle:@"确定"];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];

    [UIQuickHelp setRoundCornerForView:self.backView withRadius:8];
    
    noNeedBtn.tag = 1;
    helpYourselfBtn.tag = 2;
    post.tag = 3;
    

    [noNeedBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [helpYourselfBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [post setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0]; 

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)noNeed:(UIButton *)sender {

    _schedule_ = @"不需要行程单,低碳出行";
    
    btnTag = sender.tag;
    
    [noNeedBtn setBackgroundImage:[UIImage imageNamed:@"icon_Selected.png"] forState:0];
    [helpYourselfBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [post setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    
    self.postView.hidden = YES;
}

- (IBAction)helpYourself:(UIButton *)sender {
    _schedule_ = @"机场自取";
    
    btnTag = sender.tag;
   
    [noNeedBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [helpYourselfBtn setBackgroundImage:[UIImage imageNamed:@"icon_Selected.png"] forState:0];
    [post setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];

    self.postView.hidden = YES;
}

- (IBAction)post:(UIButton *)sender {
    _schedule_ = @"邮寄行程单";
    
    btnTag = sender.tag;
    
    [noNeedBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [helpYourselfBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    [post setBackgroundImage:[UIImage imageNamed:@"icon_Selected.png"] forState:0];

    self.postView.hidden = NO;
}
- (void)dealloc {
    [_postView release];
    [noNeedBtn release];
    [helpYourselfBtn release];
    [post release];
    [name release];
    [city release];
    [address release];
    [phone release];
    [type release];
    [_backView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPostView:nil];
    [noNeedBtn release];
    noNeedBtn = nil;
    [helpYourselfBtn release];
    helpYourselfBtn = nil;
    [post release];
    post = nil;
    [name release];
    name = nil;
    [city release];
    city = nil;
    [address release];
    address = nil;
    [phone release];
    phone = nil;
    [type release];
    type = nil;
    [self setBackView:nil];
    [super viewDidUnload];
}

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay, int chooseBtnIndex))string
{
    [blocks release];
    blocks = [string copy];

}

- (IBAction)postType:(id)sender {
    PostViewController * postT = [[PostViewController alloc] init];
    [postT getDate:^(NSString *idntity) {
        type.text = idntity;
    }];
    [self.navigationController pushViewController:postT animated:YES];
    [postT release];
}
-(void)back
{
  
    blocks(_schedule_,type.text,btnTag);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.frame.size.height/2;
    if (textField.center.y>20) {
        ce.y=ce.y- textField.center.y-20;
    }
    NSLog(@"%f",textField.center.y);
    [UIView beginAnimations:@"dsdf" context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.frame.size.height/2;

    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES ;
}

@end
