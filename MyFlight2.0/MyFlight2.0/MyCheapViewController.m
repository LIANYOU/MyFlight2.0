//
//  MyCheapViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyCheapViewController.h"
#import "MyCheapCell.h"
#import "SVSegmentedControl.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
@interface MyCheapViewController ()

@end

@implementation MyCheapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initThisView{
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"未使用",@"已使用",@"已过期", nil];
    segmented = [[SVSegmentedControl alloc]initWithSectionTitles:titleNameArray];
    [titleNameArray release];
    segmented.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    segmented.textColor = myFirstColor;
    segmented.center = CGPointMake(160, 23);
    
    //segmented.thumb.backgroundImage = [UIImage imageNamed:@"tab.png"];
    
    segmented.height = 38;
    segmented.LKWidth = 100;
    
    segmented.thumb.textColor = mySceColor;
    segmented.thumb.tintColor = [UIColor whiteColor];
    segmented.thumb.textShadowColor = [UIColor clearColor];
    segmented.crossFadeLabelsOnDrag = YES;
    
    segmented.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    
    [segmented addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];
    

}


-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    
    
    
    

    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
    LoginBusiness *bis = [[LoginBusiness alloc] init];
    
    NSString *memberId =Default_UserMemberId_Value;
    
    [bis getCouponListWithMemberId:memberId andDelegate:self];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyCheapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCheapCell" owner:nil options:nil];
        
        cell = [array objectAtIndex:0];
    }
    

    cell.youHuiQuanName.text = @"新华旅行";
    cell.moneyLabel.text= @"￥100";
    cell.timeLabel.text =@"有效期至2012-12-13至2013-11-23";
    
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}




#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    
    
    
    
    
    
}



@end
