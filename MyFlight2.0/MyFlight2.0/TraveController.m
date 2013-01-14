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
#import "PostCityViewController.h"
#import "AppConfigure.h"
@interface TraveController ()
{
    NSString * postCITY;
}
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
    self.backViewBlack.hidden = YES;
    
    self.navigationItem.title = @"行程单配送";
    
    self.postInfoArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    self.scrollView.delegate = self;
  
 
    
    self.postArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"TraveController"];

    btnTag = [[self.postArr objectAtIndex:2] intValue];

  
    if (self.postArr) {
        self.postInfoArr = [self.postArr objectAtIndex:3];
   
        if (self.postInfoArr.count != 1 ) {
            postCITY = [self.postInfoArr objectAtIndex:1];
        }
        
    }
    else{
        self.postInfoArr = [[[NSMutableArray alloc] init] autorelease];
    }
    
    
    if ([self.cellText isEqualToString:@"不需要行程单报销凭证"]) {
       
        self.flag = 1;
    }
    else{
        self.flag = [[self.postArr objectAtIndex:2] intValue];
        
    }
    

    
    name.delegate = self;
    address.delegate = self;
    phone.delegate = self;
    
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

    
    if (self.postInfoArr.count != 1) {
        name.text = [self.postInfoArr objectAtIndex:0];
        city.text = postCITY;
        address.text = [self.postInfoArr objectAtIndex:2];
        phone.text = [self.postInfoArr objectAtIndex:3];
        type.text = [self.postInfoArr objectAtIndex:4];
        
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

   city.text = postCITY;


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
    [city release];
    [_scrollView release];
    [_backViewBlack release];
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
    [city release];
    city = nil;
    [self setScrollView:nil];
    [self setBackViewBlack:nil];
    [super viewDidUnload];
}

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay, int chooseBtnIndex ,NSString * city, NSArray * InfoArr))string
{
    [blocks release];
    blocks = [string copy];

}

- (IBAction)postType:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择邮寄方式"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"快递,北京10元,其它地区20元(推荐)", @"平信(全国免费)", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view];
    [actionSheet release];
   

   
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
    switch(buttonIndex)
    {
        case 0:
        type.text = @"快递";
            break;
        case 1:
        type.text = @"平信";
            
            break;
        
            
        default:
            break;
    }
}
- (IBAction)getPostCity:(id)sender {
    
    
    PostCityViewController * post1 = [[PostCityViewController alloc] init];
    [self.navigationController pushViewController:post1 animated:YES];
    
    [post1 getDate:^(NSString *idntity) {
    
        postCITY = idntity;

    }];
    
    
    
    [post1 release];
    
}

- (IBAction)postFast:(id)sender {
    self.scrollView.scrollEnabled = YES;
    self.backViewBlack.hidden = YES;
 
}

- (IBAction)postSlow:(id)sender {
    self.scrollView.scrollEnabled = YES;
    self.backViewBlack.hidden = YES;

}
-(void)back
{
    NSArray * arr = nil;
    NSLog(@"self.flag    %d",self.flag);
    
    if (self.flag != 3) {
        arr = [NSArray arrayWithObjects:name.text,city.text,address.text,phone.text,@"平信", nil];
    }
    else{
        arr = [NSArray arrayWithObjects:name.text,city.text,address.text,phone.text,type.text, nil];
    }
        

    
    if (btnTag != 0) {
        self.flag = btnTag;
    }
    if (btnTag == 0) {
       
        _schedule_ = [self.postArr objectAtIndex:0];
        type.text = [[self.postArr objectAtIndex:3] objectAtIndex:4];
        self.flag = [[self.postArr objectAtIndex:2] intValue];
        
    }
    
    if (self.flag == 3) {
        _schedule_ = @"邮寄行程单";
        if (arr.count==1) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写邮寄方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            return;
        }
    }
    if (self.flag == 1) {
        _schedule_ = @"不需要行程单报销凭证";
    }
    if (self.flag == 2) {
        _schedule_ = @"机场自取";
    }
    NSLog(@"%@,%@,%d,%@",_schedule_,type.text,self.flag,postCITY);

    blocks(_schedule_,type.text,self.flag,postCITY,arr);  // type.text (快递）
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_schedule_ == nil) {
        _schedule_ = @"";
    }
    if (type.text == nil) {
        type.text = @"";
    }

    
    if (arr.count == 0) {
        arr = [NSArray arrayWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
    }
    
    NSMutableArray * arrary = [NSMutableArray arrayWithObjects:_schedule_,type.text,[NSString stringWithFormat:@"%d",self.flag],arr,nil];
    [[NSUserDefaults standardUserDefaults] setObject:arrary forKey:@"TraveController"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    
    
}

#pragma mark - 键盘回收

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGPoint ce=self.view.center;
    ce.y=self.view.frame.size.height/2;
    
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];

    
    [name resignFirstResponder];
    [address resignFirstResponder];
    [phone resignFirstResponder];

}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.bounds.size.height/2;
    if (textField.center.y>20) {
        ce.y=ce.y- textField.center.y-20;
    }
   
    [UIView beginAnimations:@"dsdf" context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.bounds.size.height/2;

    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES ;
}

@end
