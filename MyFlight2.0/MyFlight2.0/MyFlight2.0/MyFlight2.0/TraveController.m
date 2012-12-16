//
//  TraveController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TraveController.h"

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
    
    noNeedBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    helpYourselfBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    post.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)noNeed:(id)sender {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    noNeedBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected.png"]];
    helpYourselfBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    post.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    
    self.postView.hidden = YES;
}

- (IBAction)helpYourself:(id)sender {
    noNeedBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    helpYourselfBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected.png"]];
    post.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    self.postView.hidden = YES;
}

- (IBAction)post:(id)sender {
    noNeedBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    helpYourselfBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default.png"]];
    post.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected.png"]];
    self.postView.hidden = NO;
}
- (void)dealloc {
    [_postView release];
    [noNeedBtn release];
    [helpYourselfBtn release];
    [post release];
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
    [super viewDidUnload];
}
@end
