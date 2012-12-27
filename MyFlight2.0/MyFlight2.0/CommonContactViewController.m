//
//  CommonContactViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "CommonContactViewController.h"
#import "CommonContactCell.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "AppConfigure.h"
#import "AddContactViewController.h"
#import "CommonContactDetailViewController.h"
#import "AppConfigure.h"
#import "CommontContactSingle.h"
#import "CommonContact.h"
@interface CommonContactViewController ()
{
    
    
    
}
@end

@implementation CommonContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    CommontContactSingle *single = [CommontContactSingle shareCommonContact];
    
    
    [self.resultArray removeAllObjects];
    
    self.resultArray =single.passengerArray;
   
    
    
    
    NSLog(@"网络返回的数据为：%d", [self.resultArray count]);
    
    for (CommonContact *data in self.resultArray) {
    
        
        NSLog(@"数据：%@",data.name);
    }
    
[ self.thisTableView reloadData];

    
    
}
//添加联系人
-(void) addCommonPassenger{
    AddContactViewController *controller = [[AddContactViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    
    
    
    
}

- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCommonPassenger)];
    
    right.tintColor = Right_BarItem_Blue;
    
    self.navigationItem.rightBarButtonItem = right;
    
    [right release];
    
    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    _resultArray = [[NSMutableArray alloc] init];
    
    
    [self setNav];
    
    LoginBusiness  *bis = [[LoginBusiness alloc] init];
    
    NSString *memberId =Default_UserMemberId_Value;
    
    CCLog(@"在常用联系人查询界面 memberId= %@",memberId);
    
    [bis getCommonPassengerWithMemberId:memberId andDelegate:self];
    
    self.title = @"常用乘机人";
    
    
      
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    return [self.resultArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CommonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CommonContactCell" owner:self options:nil];
        
        cell  = [array objectAtIndex:0];
        
    }
   
    CommonContact *data = [self.resultArray objectAtIndex:indexPath.row];
    NSString *string = nil;
    
    if ([data.type isEqualToString:@"01"]) {
        
        string = @"成人";
        
    } else{
        
        string = @"儿童";
        
    }
    
    
    cell.contactName.text = data.name;
    cell.personType  =[NSString stringWithFormat:@"(%@)",string];
    cell.personId.text = data.certNo;
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    CommonContactDetailViewController *controller = [[CommonContactDetailViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    
    
    
    
    
}





- (void)dealloc {
    [_thisTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisTableView:nil];
    [super viewDidUnload];
}
@end
