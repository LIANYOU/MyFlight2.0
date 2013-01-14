//
//  BindSNSViewController.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-11.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "BindSNSViewController.h"

@interface BindSNSViewController ()

@end

@implementation BindSNSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 132) style:UITableViewStylePlain];
        
        table.rowHeight = 44.0f;
        table.backgroundColor = FOREGROUND_COLOR;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        table.layer.borderColor = [BORDER_COLOR CGColor];
        table.layer.borderWidth = 1.0f;
        table.layer.cornerRadius = CORNER_RADIUS;
        
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = NO;
        table.allowsSelection = NO;
        
        [self.view addSubview:table];
        [table release];
        
        self.view.backgroundColor = BACKGROUND_COLOR;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"社交帐户绑定";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"multichoice";
    
    MultiChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        cell = [[MultiChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    switch(indexPath.row)
    {
        case 0:
            [cell setServiceName:@"新浪微博"];
            break;
        case 1:
            [cell setServiceName:@"微信"];
            break;
        case 2:
            [cell setServiceName:@"QQ"];
            break;
        default:
            break;
    }
    
    cell.tag = indexPath.row;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void) didDeselectItemWithTag:(NSInteger)tag
{
    switch(tag)
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

- (void) didSelectItemWithTag:(NSInteger)tag
{
    switch(tag)
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

@end
