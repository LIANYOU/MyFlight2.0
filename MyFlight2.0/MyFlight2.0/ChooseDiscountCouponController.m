//
//  ChooseDiscountCouponController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "ChooseDiscountCouponController.h"
#import "discountCell.h"
#import "UIButton+BackButton.h"
#import "UIQuickHelp.h"
@interface ChooseDiscountCouponController ()
{
        BOOL selectedSign;
}
@end

@implementation ChooseDiscountCouponController

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
    self.navigationItem.title = @"选择优惠券";
    
    [UIQuickHelp setRoundCornerForView:self.backViee withRadius:8];
    
    UIButton * button = [UIButton backButtonType:0 andTitle:@""];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * button1 = [UIButton backButtonType:2 andTitle:@"确定"];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];
    
    self.showTableView.tableFooterView = self.footView;
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    

    self.selectArr = [NSMutableArray arrayWithArray:self.indexArr];

    [super viewDidLoad];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.captchaList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    discountCell *cell = (discountCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"discountCell" owner:self options:nil];
        cell = self.discountCell;
        
    }
    
    selectedSign=NO;
    cell.selectBtn.userInteractionEnabled = NO;
    
    if (self.selectArr.count!=0) {
        
        for (NSString *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_Selected.png"] forState:0];
                break;
            }
        }
    }
    if (selectedSign==NO) {
        
        [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
    }
    
    cell.selectionStyle = 0;
    
    NSDictionary * dic = [self.captchaList objectAtIndex:indexPath.row];
    
    cell.name.text = [dic objectForKey:@"name"];
    cell.count.text = @"0";
    cell.beginDate.text = [dic objectForKey:@"startDate"];
    cell.endDate.text = [dic objectForKey:@"endDate"];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    discountCell *cell = (discountCell *)[self.showTableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectArr.count!=0) {
        for (NSString *thisRow in self.selectArr) {
            
                discountCell *cell = (discountCell *)[self.showTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[thisRow intValue] inSection:0]];
                [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default.png"] forState:0];
                
                [self.selectArr removeAllObjects];
                
            }

    }
        
    [self.selectArr addObject: [NSString stringWithFormat:@"%d",indexPath.row]];
    
   [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_Selected.png"] forState:0];
    
}
- (void)dealloc {
    [_discountCell release];
    [_showTableView release];
    [_footView release];
    [_backViee release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDiscountCell:nil];
    [self setShowTableView:nil];
    [self setFootView:nil];
    [self setBackViee:nil];
    [super viewDidUnload];
}

-(void)back
{

    NSString * string1 = nil;
    NSString * string2 = nil;
    for(NSString * str in self.selectArr)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[str intValue] inSection:0];
        discountCell *cell = (discountCell *)[self.showTableView cellForRowAtIndexPath:indexPath];
        string1 = [NSString stringWithFormat:@"%@",cell.name.text];
        string2 = [NSString stringWithFormat:@"%@",cell.count.text];
    }
    
    blocks(string1,string2,self.selectArr);
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDate:(void (^) (NSString * name, NSString * count ,NSMutableArray * arr))string
{
    [blocks release];
    blocks = [string copy];
}
@end
