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
    
    self.postArr  = [NSMutableArray arrayWithCapacity:5];

    self.postArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"TraveController"];
  
    if ([self.cellText isEqualToString:@"不需要行程单报销凭证"]) {
        self.flag = 1;
    }
    else{
        self.flag = [[self.postArr objectAtIndex:2] intValue];
    }
    
    
    
    NSArray * postInfoArr = [self.postArr objectAtIndex:3];
    
    name.text = [postInfoArr objectAtIndex:0];
    city.text = [postInfoArr objectAtIndex:1];
    address.text = [postInfoArr objectAtIndex:2];
    phone.text = [postInfoArr objectAtIndex:3];
    type.text = [postInfoArr objectAtIndex:4];
    
    
    noNeedBtn.tag = 1;
    helpYourselfBtn.tag = 2;
    post.tag = 3;
    
    [self.image1 setImage:[UIImage imageNamed:@"icon_Default.png"]];
    [self.image2 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
    [self.image3 setImage:[UIImage imageNamed:@"icon_Default.png"] ];

    
    if (self.flag == 1) {
        [self.image1 setImage:[UIImage imageNamed:@"icon_Selected.png"]];
        [self.image2 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
        [self.image3 setImage:[UIImage imageNamed:@"icon_Default.png"] ];

    }
    if (self.flag == 2) {
        [self.image1 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
        [self.image2 setImage:[UIImage imageNamed:@"icon_Selected.png"] ];
        [self.image3 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
        
    }
    if (self.flag == 3) {
        [self.image1 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
        [self.image2 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
        [self.image3 setImage:[UIImage imageNamed:@"icon_Selected.png"] ];
        
        self.postView.hidden = NO;
    }

    
    
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
    
    [self.image1 setImage:[UIImage imageNamed:@"icon_Selected.png"]];
    [self.image2 setImage:[UIImage imageNamed:@"icon_Default.png"]];
    [self.image3 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
    
    self.postView.hidden = YES;
}

- (IBAction)helpYourself:(UIButton *)sender {
    _schedule_ = @"机场自取";
    
    btnTag = sender.tag;
   
    [self.image1 setImage:[UIImage imageNamed:@"icon_Default.png"]];
    [self.image2 setImage:[UIImage imageNamed:@"icon_Selected.png"] ];
    [self.image3 setImage:[UIImage imageNamed:@"icon_Default.png"]];

    self.postView.hidden = YES;
}

- (IBAction)post:(UIButton *)sender {
    _schedule_ = @"邮寄行程单";
    
    btnTag = sender.tag;
    
    [self.image1 setImage:[UIImage imageNamed:@"icon_Default.png"]];
    [self.image2 setImage:[UIImage imageNamed:@"icon_Default.png"] ];
    [self.image3 setImage:[UIImage imageNamed:@"icon_Selected.png"]];


    
    
    
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
    [_image1 release];
    [_image2 release];
    [_image3 release];
    [_postName release];
    [_postCity release];
    [_postAddress release];
    [_postPhone release];
    [_postType release];
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
    [self setImage1:nil];
    [self setImage2:nil];
    [self setImage3:nil];
    [self setPostName:nil];
    [self setPostCity:nil];
    [self setPostAddress:nil];
    [self setPostPhone:nil];
    [self setPostType:nil];
    [super viewDidUnload];
}

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay, int chooseBtnIndex , NSArray * InfoArr))string
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
    NSArray * arr = [NSArray arrayWithObjects:name.text,city.text,address.text,phone.text,type.text, nil];
    

    
    if (btnTag != 0) {
        self.flag = btnTag;
    }
    if (btnTag == 0) {
        _schedule_ = [self.postArr objectAtIndex:0];
        type.text = [[self.postArr objectAtIndex:3] objectAtIndex:4];
        self.flag = [[self.postArr objectAtIndex:2] intValue];
    }
    
    
    blocks(_schedule_,type.text,self.flag, arr);  // type.text (快递）
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_schedule_ == nil) {
        _schedule_ = @"";
    }
    if (type.text == nil) {
        type.text = @"";
    }

    
    NSMutableArray * arrary = [NSMutableArray arrayWithObjects:_schedule_,type.text,[NSString stringWithFormat:@"%d",self.flag],arr,nil];
    [[NSUserDefaults standardUserDefaults] setObject:arrary forKey:@"TraveController"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
