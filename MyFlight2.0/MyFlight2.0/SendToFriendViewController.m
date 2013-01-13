//
//  SendToFriendViewController.m
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SendToFriendViewController.h"

@interface SendToFriendViewController ()

@end

@implementation SendToFriendViewController

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
    
    self.navigationItem.title = @"推荐给好友安装";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 214)];
    
    view.backgroundColor = FOREGROUND_COLOR;
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    image.frame = CGRectMake(75, 15, 170, 170);
    
    [view addSubview:image];
    [image release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 12)];
    
    label.text = @"扫描二维码，立即得到 APP STORE 下载地址";
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = FONT_COLOR_LIGHT_GRAY;
    label.font = [UIFont systemFontOfSize:12.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [view addSubview:label];
    [label release];
    
    UIView *line;
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, (view.frame.size.height - 1), view.frame.size.width, 1)];
    
    line.backgroundColor = LINE_COLOR;
    
    [view addSubview:line];
    [line release];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, (view.frame.size.height - 2), view.frame.size.width, 1)];
    
    line.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:line];
    [line release];
    
    [self.view addSubview:view];
    [view release];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(10, 224, 300, 176) style:UITableViewStylePlain];
    
    table.rowHeight = 44.0f;
    table.backgroundColor = FOREGROUND_COLOR;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    table.layer.borderColor = [BORDER_COLOR CGColor];
    table.layer.borderWidth = 1.0f;
    table.layer.cornerRadius = 10.0f;
    
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    
    [self.view addSubview:table];
    [table release];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIView *line;
    
    if(indexPath.row != 0)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
        
        line.backgroundColor = [UIColor whiteColor];
        
        [cell addSubview:line];
        [line release];
    }
    
    if(indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.rowHeight - 1, tableView.frame.size.width, 1)];
        
        line.backgroundColor = LINE_COLOR;
        
        [cell addSubview:line];
        [line release];
    }
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 14)];
    
    switch(indexPath.row)
    {
        case 0:
            label.text = @"发短信给好友，告诉地址";
            break;
        case 1:
            label.text = @"发微博给好友，告诉地址";
            break;
        case 2:
            label.text = @"发微信给好友，告诉地址";
            break;
        case 3:
            label.text = @"发邮件给好友，告诉地址";
            break;
        default:
            break;
    }
    
    label.textColor = FONT_COLOR_DEEP_GRAY;
    label.font = [UIFont systemFontOfSize:14.0f];
    
    label.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:label];
    [label release];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    
    arrow.frame = CGRectMake(276, 16, 9, 12);
    
    [cell addSubview:arrow];
    [arrow release];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return [cell autorelease];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMessageComposeViewController *messageSender;
    MFMailComposeViewController *mailSender;
    
    switch(indexPath.row)
    {
        case 0:
            messageSender = [[MFMessageComposeViewController alloc] init];
            messageSender.messageComposeDelegate = self;
            
            if([MFMessageComposeViewController canSendText])
            {
                [self presentModalViewController:messageSender animated:YES];
            }
            
            [messageSender release];
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            mailSender = [[MFMailComposeViewController alloc] init];
            mailSender.mailComposeDelegate = self;
            
            if([MFMailComposeViewController canSendMail])
            {
                [self presentModalViewController:mailSender animated:YES];
            }
            
            [mailSender release];
            break;
        default:
            break;
    }
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
