//
//  MyCenterUnLoginViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyCenterUnLoginViewController.h"
#import "UIQuickHelp.h"
#import "MyCenterUnLoginCell.h"
#import "UIImage+Scale.h"
#import "UIImage+scaleImage.h"
#import "LogViewController.h"
#import "AppConfigure.h"
#import "MyOrderListViewController.h"
#import "MyLowOrderListViewController.h"

#import "MyLocalOrderListViewController.h"

@interface MyCenterUnLoginViewController ()
{
    
    NSArray *nameArray;
    NSArray *imageArray;
}

@end

@implementation MyCenterUnLoginViewController

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
    
    
    UIImage *image1 = [UIImage imageNamed:@"icon_acc.png"];
    
    UIImage *image2 = [UIImage imageNamed:@"icon_Orders.png"];
    UIImage *image3 = [UIImage imageNamed:@"icon_Recharge.png"];
    
    imageArray =[[NSArray alloc] initWithObjects:image1,image2,image3,nil];
    
    
    nameArray = [[NSArray alloc] initWithObjects:@"个人资料",@"我的订单",@"我订阅的低价航线", nil];
    
    
    [UIQuickHelp setRoundCornerForView:self.thisView withRadius:8];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_thisView release];
    [_nameLabel release];
    [_unPayDealLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisView:nil];
    [self setNameLabel:nil];
    [self setUnPayDealLabel:nil];
    [super viewDidUnload];
}
#pragma mark -
#pragma mark TableViewDataSource
//设置每个分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    //    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    
    
    //重用机制
    static NSString *cellIdentity=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    
    
    
    if (cell==nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterUnLoginCell" owner:nil options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    
    
    MyCenterUnLoginCell *thisCell = (MyCenterUnLoginCell *) cell;
    
    thisCell.nameLabel.text =[nameArray objectAtIndex:indexPath.row];
    
    thisCell.thisimageView.image =[imageArray objectAtIndex:indexPath.row];
    
    //    thisCell.thisimageView.frame = CGRectMake(13, 10, 24, 24);
    
    if (indexPath.row==0) {
        
        thisCell.detailLabel.text = @"未登录";
        thisCell.detailLabel.textColor =FONT_Blue_Color;
        
    }
    if (indexPath.row==1) {
        
        
        thisCell.detailLabel.text = [NSString stringWithFormat:@"未支付订单(%d)",1];
        thisCell.detailLabel.textColor = FONT_Orange_Color;
    }
    
    
    
    return cell;
    
}

//以上两个方法是必须的




//返回有几个分区，每个分区包含之前设置的行数
- (NSInteger ) numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    return 1;
}

#pragma mark -
#pragma mark TableViewDelegate

//选择列表项时，需要的进行的操作
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id controller = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            LogViewController *con = [[LogViewController alloc] init];
        
            con.loginSuccessReturnType= Login_Success_ReturnMyCenterDefault_Type;
            controller = con;
            break;
        }
        case 1:
            controller = [[MyLocalOrderListViewController alloc] init];
            break;
        case 2:
            
            //低价预约
            controller= [[MyLowOrderListViewController alloc] init];

            break;
        default:
            break;
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    
}


@end
