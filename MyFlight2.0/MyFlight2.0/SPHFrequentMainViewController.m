//
//  SPHFrequentMainViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "SPHFrequentMainViewController.h"
#import "AppConfigure.h"
#import "QueryLeijiViewController.h"
#import "DetailForLichengViewController.h"
#import "WarmTipViewController.h"
#import "DetailInfoWithImageViewController.h"
#import "LiChengBudengViewController.h"
#import "isFrequentPassengerLogin.h"
#import "LiChengDetailData.h"
@interface SPHFrequentMainViewController (){
    
    NSArray *nameArray;
    
    
}

@end

@implementation SPHFrequentMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void) initThisView{
    
    self.footView.frame  =CGRectMake(0, MainHeight_withNavBar-54, 320, 54);
    [self.view addSubview:self.footView];
    
    self.thisTableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.thisTableView.tableHeaderView  = self.FucktableviewHeader;
    
    isFrequentPassengerLogin *single =[isFrequentPassengerLogin shareFrequentPassLogin];
    self.cardNumber.text =single.frequentPassData.cardNo;
    self.nameLabel.text = single.frequentPassData.name;
    self.lichengLabel.text =single.lichengData.balance;
      
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initThisView];
    
    
    
    
    if (iPhone5) {
        
        
        
        CCLog(@"是Iphone5");
        
        
    } else{
        
        CCLog(@"不是iPhone5");
    }
    
    
    //   MainHeight
    //    CCLog(@"高度 ：%@",MainHeight);
    
    CCLog(@"%f",MainHeight);
    CCLog(@"%f",MainWidth);
    
    CCLog(@"屏幕高度是 %f",[[UIScreen mainScreen] bounds].size.height);
    
    CCLog(@"宽度为:%f",[[UIScreen mainScreen] bounds].size.width);
    
    nameArray = [[NSArray alloc] initWithObjects:@"里程累积/兑换标准查询",@"里程补登",@"里程详情查询", nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_FucktableviewHeader release];
    [_thisTableView release];
    [_footView release];
    [_cardNumber release];
    [_nameLabel release];
    [_lichengLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFucktableviewHeader:nil];
    [self setThisTableView:nil];
    [self setFootView:nil];
    [self setCardNumber:nil];
    [self setNameLabel:nil];
    [self setLichengLabel:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    
    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LiChengBudengViewController *firstController = [[LiChengBudengViewController alloc] init];
    DetailInfoWithImageViewController *secondController = [[DetailInfoWithImageViewController alloc] init];
    WarmTipViewController *thirdController = [[WarmTipViewController alloc] init];
    
    
    
    
    UIImage *image1 = [UIImage imageNamed:@"icon_registration.png"];
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"里程补登" image:image1 tag:500];
    firstController.tabBarItem= firstItem;
    
       
    UIImage *image2 = [UIImage imageNamed:@"icon_prompt.png"];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTitle:@"图示说明" image:image2 tag:501];
    secondController.tabBarItem = secondItem;
    
    
    
    UIImage *image3 = [UIImage imageNamed:@"icon_img.png"];
    UITabBarItem *thirdItem = [[UITabBarItem alloc] initWithTitle:@"温馨提示" image:image3 tag:501];
    thirdController.tabBarItem = thirdItem;
    
    
    UINavigationController *nav1 =[[UINavigationController alloc] initWithRootViewController:firstController];
    
      [firstController release];
    
     
    NSArray *conArray = [[NSArray alloc] initWithObjects:nav1,secondController,thirdController ,nil];
    
    [secondController release];
    [thirdController release];
    
    UITabBarController *tabController= [[UITabBarController alloc] init];
    
    
    tabController.viewControllers = conArray;
    
    tabController.selectedIndex = 0;
    
    NSInteger selectIndex = indexPath.row;
    
    
    id controller = nil;
    
    switch (selectIndex) {
        case 0:
            controller = [[QueryLeijiViewController alloc] init];
            break;
        case 1:
            
            controller = tabController;
            //[self presentModalViewController:tabController animated:YES];
            
            break;
        case 2:
         controller = [[DetailForLichengViewController alloc] init];
            break;
        default:
            
            break;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    [nav1 release];
    
   
    
}



@end
