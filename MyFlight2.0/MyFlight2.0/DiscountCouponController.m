//
//  DiscountCouponController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-28.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "DiscountCouponController.h"
#import "UseDiscountCell.h"
#import "GoldCoinCell.h"
@interface DiscountCouponController ()
{
    BOOL selectedSign;
}
@end

@implementation DiscountCouponController

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
    self.showDiscountTableView.delegate = self;
    self.showDiscountTableView.dataSource = self;
    
    self.navigationItem.title = @"账户资金/优惠券抵用";
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"返回金币数目" object:nil];
    [self.gold searchGold];
    
    
    self.swithStation = @"ON";  // 默认开关是开着的
    
    if (self.type == nil) {
        
        self.type = @"ON";
    }
    
    if ([self.type isEqualToString:@"ON"]) {
        self.swith.on = YES;
        self.showDiscountTableView.hidden = NO;
    }
    else
    {
        self.swith.on = NO;
        self.showDiscountTableView.hidden = YES;
    }
    
    
    self.selectArr = [NSMutableArray arrayWithCapacity:5];
    self.selectArr = self.indexArr;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receive:(NSNotification *) not
{
    NSDictionary * dic = [[not userInfo] objectForKey:@"arr"];
    
    self.accountAmount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"accountAmount"]];
    self.goldAmount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goldAmount"]];
    self.silverAmount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"silverAmount"]];
    
    [self.showDiscountTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else{
        return 40;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sectionHeadViewOne;
    }
    else{
        return self.sectionHeadViewTwo;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.sectionFootView;
    }
    else{
        return nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell";
        
        UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"UseDiscountCell" owner:self options:nil];
            cell = self.discountCell;
            
        }
        
        if (indexPath.row == 0) {
            cell.name.text = [NSString stringWithFormat:@"使用银币%@元",self.silverAmount];
        }
        else{
            cell.name.text = @"使用优惠券";
        }
        
        cell.selectBtn.tag=indexPath.row;
        
        selectedSign=NO;
        
        if (self.selectArr.count!=0) {
            
            for (NSString *thisRow in self.selectArr) {
                int a=[thisRow intValue];
                if (indexPath.row==a) {
                    selectedSign=YES;
                    cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
                    break;
                }
            }
        }
        if (selectedSign==NO) {
            cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
        }

        
        [cell.selectBtn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = 0;
        
        return cell;

    }
    else{
        static NSString *CellIdentifier = @"Cell";
        
         GoldCoinCell *cell = (GoldCoinCell *)[self.showDiscountTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"GoldCoinCell" owner:self options:nil];
            cell = self.goldCell;
            
        }
        
        cell.payLabel.text = [NSString stringWithFormat:@"￥%@",self.accountAmount];
        
        if ([self.accountAmount isEqualToString:@"0.00"]) {
            cell.useBtn.enabled = NO;
        }
        
        cell.userInteractionEnabled = NO;
        
        [cell.useBtn addTarget:self action:@selector(payNow) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(void)payNow
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
}

#pragma mark - 点选时的操作

-(void)selectMore:(UIButton *)btn
{

    if (self.selectArr.count!=0) {
        for (NSString *thisRow in self.selectArr) {
            
            int a=[thisRow intValue];
            if (btn.tag==a) {
       
                [self.selectArr removeObject:thisRow];
                
                btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
                return;
            }
            else{
                UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:0]];
                cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
                
                [self.selectArr removeAllObjects];
                                                            
            }
        }
    }


    [self.selectArr addObject: [NSString stringWithFormat:@"%d",btn.tag]];
    
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
 

}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectArr.count!=0) {
        for (NSString *thisRow in self.selectArr) {
            
            int a=[thisRow intValue];
            if (indexPath.row == a) {
                
                [self.selectArr removeObject:thisRow];
                
                cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
                return;
            }
            else{
                UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:0]];
                cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
                
                [self.selectArr removeAllObjects];
                
            }
        }
    }
    
    
    [self.selectArr addObject: [NSString stringWithFormat:@"%d",indexPath.row]];
    
    cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
    
    
   
}

- (void)dealloc {
    [_showDiscountTableView release];
    [_sectionHeadViewOne release];
    [_sectionHeadViewTwo release];
    [_sectionFootView release];
    [_discountCell release];
    [_goldCell release];
    [_swith release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowDiscountTableView:nil];
    [self setSectionHeadViewOne:nil];
    [self setSectionHeadViewTwo:nil];
    [self setSectionFootView:nil];
    [self setDiscountCell:nil];
    [self setGoldCell:nil];
    [self setSwith:nil];
    [super viewDidUnload];
}

-(void)back
{
    NSString * string = nil;
    NSString * goldString = nil;
    for(NSString * str in self.selectArr)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[str intValue] inSection:0];
        UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:indexPath];
        string = [NSString stringWithFormat:@"%@",cell.name.text];
        
    }
    
    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:1];
    GoldCoinCell *cell = (GoldCoinCell *)[self.showDiscountTableView cellForRowAtIndexPath:index];
    goldString = [NSString stringWithFormat:@"%@",cell.payLabel.text];

    NSLog(@"%@,%@,%@,%@",self.swithStation,string,goldString,self.selectArr);

    
    if ([self.swithStation isEqualToString:@"OFF"]) {   // 总开关关闭
        string = @"";
        goldString = @"不使用优惠券银币和账户余额";
        [self.selectArr removeAllObjects];
    }
    
    if (string == nil) {
        string = @"不使用优惠券和银币";
    }
    
    
    blocks(self.swithStation, string ,goldString, self.selectArr);
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)swithOFFOrON:(UISwitch *)sender {
    
    BOOL setting = sender.isOn;//获得开关状态
    if(setting)
    {
        self.swithStation = @"ON";
        self.showDiscountTableView.hidden = NO;
        
    }else {
        self.swithStation = @"OFF";
        self.showDiscountTableView.hidden = YES;
    }

}

-(void)getDate:(void (^) (NSString * swithStation, NSString * silverOrDiscount ,NSString * gold, NSMutableArray * arr))string
{
    [blocks release];
    blocks = [string copy];
}
@end
