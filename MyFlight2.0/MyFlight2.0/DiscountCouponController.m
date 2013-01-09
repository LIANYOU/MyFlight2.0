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
#import "UIButton+BackButton.h"
#import "ChooseDiscountCouponController.h"
#import "CheckPassword.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
@interface DiscountCouponController ()
{
    BOOL selectedSign;
    
    NSString * captchaID; // 优惠券ID
    
    int checkFlag; // 判断支付密码是否正确
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
    
    self.tempText.inputAccessoryView = self.keyBoardBar;
    
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
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
    
    self.captchaListArr = [NSArray array];
    
    self.captchaListArr = [dic objectForKey:@"captchaList"];
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
        
        cell.payLabel.text = [NSString stringWithFormat:@"￥%d",[self.accountAmount intValue]+[self.goldAmount intValue]];
        
                
        if ([cell.payLabel.text isEqualToString:@"0.00"]) {
            cell.useBtn.enabled = NO;
        }
        
        cell.selectionStyle = 0;
        
        [cell.useBtn addTarget:self action:@selector(payNow) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(void)payNow
{
    [self.tempText becomeFirstResponder];
    [self.text becomeFirstResponder];
}
- (IBAction)sure:(id)sender {
    
    NSString * string = [NSString stringWithFormat:@"%@%@%@%@",Default_UserMemberId_Value,self.text.text,SOURCE_VALUE,Default_Token_Value];
    
    CheckPassword * password = [[CheckPassword alloc] initWithMemberId:Default_UserMemberId_Value
                                                             andSource:SOURCE_VALUE
                                                               andHwId:HWID_VALUE
                                                               andSign:GET_SIGN(string)
                                                            andEdition:EDITION_VALUE
                                                           andDelegate:self];
    password.delegate = self;
    
    [password getPassword];
    
    [self.text resignFirstResponder];
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

    if (indexPath.row == 1) {
     
        NSLog(@"*********************   %@",self.captchaListArr);
        if (self.captchaListArr.count != 0) {
            ChooseDiscountCouponController * choose =  [[ChooseDiscountCouponController alloc] init];
            choose.captchaList = self.captchaListArr;
            [choose getDate:^(NSString *name, NSString *count, NSMutableArray *arr) {
                
                cell.name.text = name;
                cell.secLebel.text = [NSString stringWithFormat:@"%@",count];
                self.nextSelectArr = [NSMutableArray arrayWithArray:arr];
            }];
            choose.indexArr = self.nextSelectArr;
            [self.navigationController pushViewController:choose animated:YES];
            [choose release];

        }
        else{
            
        }
        
    }

  
   
    
    if (self.selectArr.count!=0) {
        
        for (NSString *thisRow in self.selectArr) {
            
            int a=[thisRow intValue];

                UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:0]];
                cell.selectBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Default_.png"]];
                
                [self.selectArr removeAllObjects];

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
    [_text release];
    [_keyBoardBar release];
    [_keyText release];
    [_tempText release];
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
    [self setText:nil];
    [self setKeyBoardBar:nil];
    [self setKeyText:nil];
    [self setTempText:nil];
    [super viewDidUnload];
}

-(void)back
{
   
    
    NSString * string = nil;
    NSString * goldString = nil;

    if (checkFlag == 100) {  // 支付密码验成功

    goldString =[NSString stringWithFormat:@"%d",[self.accountAmount intValue]+[self.goldAmount intValue]] ;
    }

    if (self.selectArr.count != 0) {
        if ([[self.selectArr objectAtIndex:0] isEqual:@"0"]) {
            string = self.silverAmount;  // 使用银币
        }
        else{  // 使用优惠券
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            UseDiscountCell *cell = (UseDiscountCell *)[self.showDiscountTableView cellForRowAtIndexPath:indexPath];
            string = cell.secLebel.text;
            
            int flag =[[self.nextSelectArr objectAtIndex:0] intValue];
            captchaID = [[self.captchaListArr objectAtIndex:flag] objectForKey:@"id"];
            
        }
    }
    
    
    blocks(self.swithStation, string ,goldString, self.selectArr,self.text.text,captchaID);
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)swithOFFOrON:(UISwitch *)sender {
    
    BOOL setting = sender.isOn;//获得开关状态
    if(setting)
    {
        self.swithStation = @"ON";
        
        self.showDiscountTableView.hidden = NO;
        
    }else {
        [self.selectArr removeAllObjects];
        self.swithStation = @"OFF";
        self.showDiscountTableView.hidden = YES;
    }

}

-(void)getDate:(void (^) (NSString * swithStation, NSString * silverOrDiscount ,NSString * gold, NSMutableArray * arr,NSString * password, NSString * ID))string
{
    [blocks release];
    blocks = [string copy];
}


#pragma mark -

//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    NSString * meg =[info objectForKey:KEY_message];
  
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    NSString * meg =[info objectForKey:KEY_message];

    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付密码验证成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    checkFlag = 100;
    [alert show];
    [alert release];
    
}
@end
