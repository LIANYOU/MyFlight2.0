//
//  ChoosePersonController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-12.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChoosePersonController.h"
#import "ChoosePersonCell.h"
#import "AddPersonController.h"
#import "AddPersonController.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
#import "CommontContactSingle.h"
#import "CommonContact.h"
#import "LoginBusiness.h"
#import "UIImage+scaleImage.h"
#import "UIButton+BackButton.h"
@interface ChoosePersonController ()
{
    int childNumber;  // 儿童个数
    int personNumber; // 成人个数
}
@end

@implementation ChoosePersonController

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
    self.navigationItem.title = @"选择乘机人";
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    self.selectArr = [NSMutableArray array];
    self.selectArr = self.indexArr;
    
    self.nameDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.identityNumberDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.typeDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.flightPassengerIdDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.certTypeDic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton backButtonType:2 andTitle:@"确定"];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];


    self.dataArr = [[NSMutableArray alloc] init];
    
    LoginBusiness *bis =[[LoginBusiness alloc] init];
        
    [bis getCommonPassengerWithMemberId:Default_UserMemberId_Value andDelegate:self];
    
    [bis release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView * myView =[[[UIView alloc] init] autorelease];
    
    self.addBtn.frame = CGRectMake(10, 30, 300, 36);
    [myView addSubview:self.addBtn];
    
    return myView;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ChoosePersonCell *cell = (ChoosePersonCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ChoosePersonCell" owner:self options:nil];
        cell = self.choosePersonCell;
        
    }
    
    //判断是否已被选择
    cell.btn.tag=indexPath.row;
    selectedSign=NO;
   
    cell.selectionStyle = 2;
    
    cell.btn.frame = CGRectMake(0,0, 44, 44);
    if (self.selectArr.count!=0) {
   
        for (NSString *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                
                UIImage * image=[UIImage imageNamed:@"icon_choice.png"];
              //  UIImage * toimage=[UIImage scaleImage:image toScale:0.5];
                
                [cell.btn setBackgroundImage:image forState:0];
                
               
                break;
            }
        }
    }
    if (selectedSign==NO) {
        
        UIImage * image=[UIImage imageNamed:@"ico_def.png"];
    
        [cell.btn setBackgroundImage:image forState:0];
        
    }
    
    
    CommonContact * com = [self.dataArr objectAtIndex:indexPath.row];
    NSString * str = nil;
    if ([com.type isEqualToString:@"01"]) {
        str = @"成人";
    }
    else{
        str = @"儿童";
    }
    cell.name.text = com.name;
    cell.type.text = str;
    cell.identityNumber.text = com.certNo;
    
    [cell.btn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CommonContact * com = [self.dataArr objectAtIndex:indexPath.row];
    
    AddPersonController * add = [[AddPersonController alloc] init];
    add.addBtnSelected = false;
    add.choose = self;
    add.passenger = com;
    [self.navigationController pushViewController:add animated:YES];
    [add release];
}

#pragma mark - 批量选择点选时的操作

-(void)selectMore:(UIButton *)btn
{
    if (self.selectArr.count!=0) {
        for (NSString *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (btn.tag==a) {
                [self.selectArr removeObject:thisRow];
                
                UIImage * image=[UIImage imageNamed:@"ico_def.png"];
   

               [btn setBackgroundImage:image forState:0];
            
               
                return;
            }
        }
    }
    
    [self.selectArr addObject: [NSString stringWithFormat:@"%d",btn.tag]];
    
    UIImage * image=[UIImage imageNamed:@"icon_choice.png"];

    
    [btn setBackgroundImage:image forState:0];
    
}


- (IBAction)addPerson:(UIButton *)sender {
    AddPersonController * add = [[AddPersonController alloc] init];
    
    add.addBtnSelected = true;
    
    [self.navigationController pushViewController:add animated:YES];
}

-(void)back
{
    for(NSString * str in self.selectArr)
    {
        int index = [str intValue];
        
        CommonContact * com = [self.dataArr objectAtIndex:index];
        
        
        [self.nameDic             setObject:com.name forKey:str];
        [self.typeDic             setObject:com.type forKey:str];
        [self.identityNumberDic   setObject:com.certNo  forKey:str];
        [self.flightPassengerIdDic setObject:com.contactId forKey:str];
        [self.certTypeDic          setObject:com.certType forKey:str];
        
    }

    blocks(self.nameDic,self.identityNumberDic,self.typeDic,self.flightPassengerIdDic,self.certTypeDic,self.selectArr);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDate:(void (^) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableDictionary *flightPassengerIdDic,NSMutableDictionary * certTypeDic,NSMutableArray * arr))string
{
    [blocks release];
    blocks = [string copy];
}
- (void)dealloc {
    [_showTableView release];
    [_choosePersonCell release];
    [_addBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowTableView:nil];
    [self setChoosePersonCell:nil];
    [self setAddBtn:nil];
    [super viewDidUnload];
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

    CommontContactSingle *sin = [CommontContactSingle shareCommonContact];
    
    NSArray * arr = [NSArray arrayWithArray:sin.passengerArray];
    
    for (CommonContact * common in arr) {
        [self.dataArr addObject:common];
    }
    
    [self.showTableView reloadData];
}



@end
