//
//  AboutViewController.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void) requestForData
{
    
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
	// Do any additional setup after loading the view.
    
    titleArray = [[NSArray alloc] initWithObjects:@"意见反馈", @"检查新版本", @"推荐给好友安装", @"软件推荐", @"觉得不错，给我们评分", nil];
    
    UIImageView *image;
    
    image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    
    image.frame = CGRectMake(73, 30, 174, 28.5);
    
    [self.view addSubview:image];
    [image release];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 88.5, 300, 220) style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    
    tableView.rowHeight = 44.0f;
    tableView.backgroundColor = FOREGROUND_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.layer.borderColor = [BORDER_COLOR CGColor];
    tableView.layer.borderWidth = 1.0f;
    tableView.layer.cornerRadius = 10.0f;
    
    [self.view addSubview:tableView];
    [tableView release];
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 550 ? 360:430, 320, 20)];
    
    version.text = @"版本号 : 3.0";
    version.textAlignment = UITextAlignmentCenter;
    version.textColor = FONT_COLOR_BIG_GRAY;
    version.font = [UIFont systemFontOfSize:12.0f];
    version.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:version];
    [version release];
    
    UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 550 ? 380:450, 320, 25)];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Copyright © 新华旅行网 51YOU.com"];
    
    [string addAttribute:NSForegroundColorAttributeName value:FONT_COLOR_BIG_GRAY range:NSMakeRange(0, 17)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(18, 9)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 27)];
    
    [label setAttributedText:string];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setEnabled:NO];
    
    [self.view addSubview:label];
    [label release];
    
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
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSString *identifier = @"about";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(14, 13.5f, 180, 17)];
    
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:17.0f];
    title.textColor = FONT_COLOR_DEEP_GRAY;
    title.textAlignment = UITextAlignmentLeft;
    title.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:title];
    [title release];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    
    arrow.frame = CGRectMake(276, 16, 9, 12);
    
    [cell addSubview:arrow];
    [arrow release];
    
    return [cell autorelease];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackViewController *feedback = nil;
    
    switch(indexPath.row)
    {
        case 0:
            feedback = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedback animated:YES];
            [feedback release];
            break;
        default:
            break;
    }
}

@end
