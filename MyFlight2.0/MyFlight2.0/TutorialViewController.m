//
//  TutorialViewController.m
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

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
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    
    scroller.clipsToBounds = YES;
    scroller.pagingEnabled = YES;
    scroller.delegate = self;
    scroller.contentSize = CGSizeMake(1280, [UIScreen mainScreen].bounds.size.height);
    
    UIImageView *image;
    
    for(int i = 0; i < 4; i++)
    {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tutorial_%d.jpg", i]]];
        
        image.frame = CGRectMake((320 * i), 0, 320, [UIScreen mainScreen].bounds.size.height);
        
        image.contentMode = (UIViewContentModeScaleAspectFill);
        
        if(i == 3)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 35, 320, 20)];
            
            label.text = @"现在开始使用";
            label.textAlignment = UITextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:20.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [image addSubview:label];
            [label release];
            
            quitTutorial = [UIButton buttonWithType:UIButtonTypeCustom];
            
            quitTutorial.frame = image.frame;
            
            [quitTutorial setImage:[UIImage imageNamed:@"tutorial_1.jpg"] forState:UIControlStateNormal];
            
            [quitTutorial addTarget:self action:@selector(quitTutorial) forControlEvents:UIControlEventTouchUpInside];
            
            [scroller addSubview:quitTutorial];
        }
        
        [scroller addSubview:image];
        [image release];
    }
    
    [self.view addSubview:scroller];
    [scroller release];
    
    dots_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dots_0.png"]];
    dots_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dots_1.png"]];
    dots_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dots_2.png"]];
    
    dots_0.frame = CGRectMake(135, [UIScreen mainScreen].bounds.size.height - 30, 50, 10);
    dots_1.frame = CGRectMake(135, [UIScreen mainScreen].bounds.size.height - 30, 50, 10);
    dots_2.frame = CGRectMake(135, [UIScreen mainScreen].bounds.size.height - 30, 50, 10);
    
    [self.view addSubview:dots_0];
    [self.view addSubview:dots_1];
    [self.view addSubview:dots_2];
    
    [dots_0 release];
    [dots_1 release];
    [dots_2 release];
    
    dots_0.hidden = NO;
    dots_1.hidden = YES;
    dots_2.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x < 320 && scrollView.contentOffset.x >= 0)
    {
        [UIView animateWithDuration:0.5f
                         animations:^(void){
                             dots_0.hidden = NO;
                             dots_1.hidden = YES;
                             dots_2.hidden = YES;
                         }];
    }
    else if(scrollView.contentOffset.x < 640 && scrollView.contentOffset.x >= 320)
    {
        [UIView animateWithDuration:0.5f
                         animations:^(void){
                             dots_0.hidden = YES;
                             dots_1.hidden = NO;
                             dots_2.hidden = YES;
                         }];
    }
    else if(scrollView.contentOffset.x < 960 && scrollView.contentOffset.x >= 640)
    {
        [UIView animateWithDuration:0.5f
                         animations:^(void){
                             dots_0.hidden = YES;
                             dots_1.hidden = YES;
                             dots_2.hidden = NO;
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.5f
                         animations:^(void){
                             dots_0.hidden = YES;
                             dots_1.hidden = YES;
                             dots_2.hidden = YES;
                         }];
    }
}

- (void) quitTutorial
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
