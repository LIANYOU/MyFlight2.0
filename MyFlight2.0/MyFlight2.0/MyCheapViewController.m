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
#import "MyCheapCouponHelper.h"
#import "CouponsInfo.h"
#import "UIButton+BackButton.h"
@interface MyCheapViewController (){
    
    NSArray *tmpArray;
    //    NSArray *uselistArray;
    //    NSArray *noUseListArray;
    //    NSArray *outOfDateListArray;
}

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


- (void) back{
     [self.captchNumberInput resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) initKeyBoardView{
    
    self.captchNumberInput.text =@"";
    self.tmpTextField.inputAccessoryView =self.textFieldAccView;
    [self.tmpTextField becomeFirstResponder];
    
    [self.captchNumberInput becomeFirstResponder];
    
    [self.tmpTextField resignFirstResponder];

    
}

//添加q优惠券
- (void) addCoup{
    
    CCLog(@"增加优惠券");
    [self initKeyBoardView];
}

#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    
    
    UIButton * rightBn = [UIButton  backButtonType:6 andTitle:@""];
    [rightBn addTarget:self action:@selector(addCoup) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:rightBn];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];
    
  
    
        
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
}


- (void) initThisView{
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"未使用",@"已使用",@"已过期", nil];
    segmented = [[SVSegmentedControl alloc]initWithSectionTitles:titleNameArray];
    [titleNameArray release];
    segmented.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    segmented.textColor = myFirstColor;
    segmented.center = CGPointMake(160, 25);
    
    //segmented.thumb.backgroundImage = [UIImage imageNamed:@"tab.png"];
    
    segmented.height = 38;
    segmented.LKWidth = 100;
    
    segmented.thumb.textColor = mySceColor;
    segmented.thumb.tintColor = [UIColor whiteColor];
    segmented.thumb.textShadowColor = [UIColor clearColor];
    segmented.crossFadeLabelsOnDrag = YES;
    
    segmented.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    
    [segmented addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.headerView addSubview:segmented];
    
    
}


-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    NSInteger index = sender.selectedIndex;
    switch (index) {
        case 0:
            tmpArray = self.uselistArray;
            
            [self.thisTableView reloadData];
            break;
        case 1:
            tmpArray =self.noUseListArray;
            [self.thisTableView reloadData];
            break;
        case 2:
            
            
            
            tmpArray = self.outOfDateListArray;
            [self.thisTableView reloadData];
            break;
        default:
            break;
    }
    
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
    [self setNav];
    
//    self.thisTableView.tableFooterView = self.tableFoot;
    
    //    uselistArray = [[NSArray alloc] init];
    //    noUseListArray = [[NSArray alloc] init];
    //    outOfDateListArray =[[NSArray alloc] init];
    //
    //    tmpArray = uselistArray;
    
    //    LoginBusiness *bis = [[LoginBusiness alloc] init];
    
    
    
    NSString *memberId =Default_UserMemberId_Value;
    
    [MyCheapCouponHelper getCouponInfoListWithMemberId:memberId andDelegate:self];
    
    //    [bis getCouponListWithMemberId:memberId andDelegate:self];
    
    
    
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
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    // Return the number of rows in the section.
    return [tmpArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyCheapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCheapCell" owner:nil options:nil];
        
        cell = [array objectAtIndex:0];
    }
    
    
//    cell.highlighted = NO;
    
    CouponsInfo *data = [tmpArray objectAtIndex:indexPath.row];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",data.price];
    
    
    NSString *string = [NSString stringWithFormat:@"有效期至%@至%@",data.dateStart,data.dateEnd];
    
    cell.youHuiQuanName.text = data.name;
    cell.moneyLabel.text= price;
    cell.timeLabel.text =string;
    
    [UIQuickHelp setTableViewCellBackGroundColorAndHighLighted:cell];
    if ([cell.timeLabel.text isEqualToString:@""]) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    } else{
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CouponsInfo *data = [tmpArray objectAtIndex:indexPath.row];
    NSString *rule = data.rule;
    

    [UIQuickHelp showAlertViewWithTitle:@"优惠券使用规则" message:rule delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
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
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    
    NSString *message = [info objectForKey:KEY_Request_Type];
    if ([message isEqualToString:@"active"]) {
        CCLog(@"是激活信息返回的信息");
        
        
    } else{
        
        CCLog(@"这是查询优惠券回调的方法");
        
        self.uselistArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfUse];
        self.noUseListArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfNoUse];
        self.outOfDateListArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfOutOfDate];
        
        
        tmpArray = self.uselistArray;
        [self.thisTableView reloadData];
        
        CCLog(@"网络返回的数据count = %d",[tmpArray count]);
        
    }
    
}



- (void)dealloc {
    [_thisTableView release];
    [_headerView release];
    [_tableFoot release];
    [_textFieldAccView release];
    [_captchaNumberTextField release];
    [_tmpTextField release];
    [_captchNumberInput release];
    [_thisTempView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisTableView:nil];
    [self setHeaderView:nil];
    [self setTableFoot:nil];
    [self setTextFieldAccView:nil];
    [self setCaptchaNumberTextField:nil];
    [self setTmpTextField:nil];
    [self setCaptchNumberInput:nil];
    [self setThisTempView:nil];
    [super viewDidUnload];
}
- (IBAction)SureAddcaptchaBn:(id)sender {
    
    NSString *number =[self.captchNumberInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([number length]==0) {
        
        
        [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"请输入优惠券号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [self initKeyBoardView];
        
    } else{
        
        NSString *memberId =Default_UserMemberId_Value;
        
        [self.captchNumberInput resignFirstResponder];

        
        [MyCheapCouponHelper makeCouponActiveWithMemberId:memberId captcha:number andDlegate:self];
        
        
        
    }
    

    
    
        
    
}
@end
