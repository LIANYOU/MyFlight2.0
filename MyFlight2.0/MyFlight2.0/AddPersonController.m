//
//  AddPersonController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AddPersonController.h"
#import "AddPersonCoustomCell.h"
#import "AddPersonSwitchCell.h"
#import "IdentityViewController.h"
#import "UIButton+BackButton.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "CustomTableView.h"
@interface AddPersonController ()
{
    NSString * passengerType;  // 乘客类型
    NSString * passengerCertType; // 身份证的类型
    
    NSString * certtype;
    
    NSString * passengerName;
    NSString * brithMember;
    NSString * certMember;
    
    NSString * personTYpe;
    NSString * certTYpe;
    
    
    int flagOne;
    int flagThree;
    
    int selectOneRow;
    int selectThreeRow;
}
@end

@implementation AddPersonController

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
    
    self.navigationItem.title = self.navTitleString;
    
    
    self.cellTitleArr = [NSArray arrayWithObjects:@"身  份 ",@"姓  名 ",@"证件类型 ",@"证件号码 ",@"生  日 ",@"保存为常用乘机人", nil];
    
    self.cellTextArr = [NSMutableArray arrayWithObjects:@"成人",@"请输入乘机人姓名",@"身份证",@"请输入证件号码",@"1990-09-09", nil];
    
    self.addPersonTableView.delegate = self;
    self.addPersonTableView.dataSource = self;
    self.typeTableView.delegate = self;
    self.typeTableView.dataSource = self;
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton backButtonType:8 andTitle:@"保存"];
    [histroyBut addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=histroyBtn;
    [histroyBtn release];
    
    if (self.controllerType != nil) {
        self.addPersonTableView.tableFooterView = self.delBtnView;
    }

 
    
    if (self.passenger != nil) {
        
        
        [self.cellTextArr replaceObjectAtIndex:0 withObject:self.passenger.type];
        [self.cellTextArr replaceObjectAtIndex:2 withObject:self.passenger.certType];
        
        
        if ([self.passenger.type isEqualToString:@"01"]) {
            passengerType = @"成人";
        }
        else{
            passengerType = @"儿童";
        }
        
        if ([self.passenger.certType isEqualToString:@"0"]) {
          
            certtype = @"0";
            passengerCertType = @"身份证";
        }
        if ([self.passenger.certType isEqualToString:@"1"]) {
         
            certtype = @"1";
            passengerCertType = @"护照";
        }
        else if ([self.passenger.certType isEqualToString:@"9"]){
           
            certtype = @"9";
            passengerCertType = @"其他";
        }
    }

    
    self.typeTableView.hidden = YES;
        
    
    if (self.addBtnSelected) {
        passengerType = nil;
        passengerCertType = nil;
    }
    
    
    
    
    // 初始化第二个tableview的数组
    
    
    
    self.typeArr = [NSMutableArray arrayWithObjects:@"儿童",@"成人", nil];
    self.certArr = [NSMutableArray arrayWithObjects:@"身份证",@"护照",@"其它", nil];
    self.typeArrText = [NSMutableArray arrayWithObjects:@" ",@" ", nil];
    self.certArrText = [NSMutableArray arrayWithObjects:@" ",@" ", nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_addPersonTableView release];
    [_addPersonSwithCell release];
    [_addPersonCoustomCell release];
    [_delBtnView release];
    [_typeTableView release];
    [_typeCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddPersonTableView:nil];
    [self setAddPersonSwithCell:nil];
    [self setAddPersonCoustomCell:nil];
    [self setDelBtnView:nil];
    [self setTypeTableView:nil];
    [self setTypeCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
        if (Default_IsUserLogin_Value) {
            return 5;
        }
        else{
            return 6;
        }


    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if ([passengerType isEqualToString:@"成人"]) {
            
            self.delBtnView.frame = CGRectMake(0, 0, 320, 91);
            
            if (indexPath.row == 4) {
                
                return 0;
            }
            
            else{
                return 50;
            }
            
        }
        
        else  {
            
            
            self.delBtnView.frame = CGRectMake(0, 0, 320, 160);
            
            return 50;
        }

    
    
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if (indexPath.row == 5) {
            
            static NSString *CellIdentifier1 = @"Cell";
            AddPersonSwitchCell *cell = (AddPersonSwitchCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (!cell)
            {
                [[NSBundle mainBundle] loadNibNamed:@"AddPersonSwitchCell" owner:self options:nil];
                cell = self.addPersonSwithCell;
            }
            cell.cellTitle.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            [cell.swith addTarget:self action:@selector(switchOFFORON:) forControlEvents:UIControlEventValueChanged];
            
            return cell;
            
        }
        else{
            static NSString *CellIdentifier = @"Cell";
            AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                [[NSBundle mainBundle] loadNibNamed:@"AddPersonCoustomCell" owner:self options:nil];
                cell = self.addPersonCoustomCell;
            }
            
            
            if (passengerType != nil) {
                
                NSLog(@"%s,%d",__FUNCTION__,__LINE__);
                
                if ([passengerType isEqualToString:@"成人"]) {
                    if (indexPath.row == 4) {
                        cell.hidden = YES;
                    }
                }
                if (indexPath.row == 0) {
                    cell.secText.text = passengerType;
                    cell.secText.userInteractionEnabled = NO;
                }
                if (indexPath.row == 2) {
                    
                    cell.secText.text = passengerCertType;
                    cell.secText.userInteractionEnabled = NO;
                }
                
                if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
                    if (self.choose != nil  || self.controllerType != nil) {
                        if (indexPath.row == 1) {
                            cell.btn.frame = CGRectMake(320-10-22, 14, 22, 22);
                            [cell.btn setBackgroundImage:[UIImage imageNamed:@"icon_info.png"] forState:0];
                            [cell.btn addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
                            cell.secText.text = self.passenger.name;
                        }
                        if (indexPath.row == 3) {
                            cell.secText.text = self.passenger.certNo;
                            cell.btn.hidden = YES;
                        }
                        if (indexPath.row == 4) {
                            cell.secText.text = self.passenger.certNo;
                        }
                    }
                    
                    cell.secText.delegate = self;
                }
                
                cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
                if (self.choose == nil) {
                    cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
                }
            }
            
            else
            {
                
                if ([[self.cellTextArr objectAtIndex:0] isEqualToString:@"成人"]) {
                    if (indexPath.row == 4) {
                        cell.hidden = YES;
                    }
                }
                if (indexPath.row == 0 || indexPath.row == 2) {
                    cell.secText.enabled = NO;
                }
                cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
                cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
                cell.secText.delegate = self;
            }
            
            
            return cell;
            
        }



    
}

-(void)showInfo{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"乘机人姓名请输入中文姓名  2  如为英文姓名，则需用/分割，姓在前，名在后，如hill/jiang。 3  如遇到生僻字，请用拼音代替，如 降feng" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"儿童", @"成人", nil];
        actionSheet.tag = 1;
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        
        [actionSheet showInView:self.view];
        [actionSheet release];

    }
    if (indexPath.row == 2) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"身份证", @"护照",@"其它", nil];
        actionSheet.tag = 2;
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        
        [actionSheet showInView:self.view];
        [actionSheet release];
        
    }

}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        switch(buttonIndex)
        {
            case 0:
                passengerType = @"儿童";
                break;
            case 1:
                passengerType = @"成人";
                
                break;
                
                
            default:
                break;
        }

    }
    if (actionSheet.tag == 2) {
        switch(buttonIndex)
        {
            case 0:
                passengerCertType = @"身份证";
                break;
            case 1:
                passengerCertType = @"护照";
                
                break;
            case 2:
                passengerCertType = @"其它";
                
                break;
   
                
            default:
                break;
        }
        
    }

    [self.addPersonTableView reloadData];
}


#pragma mark - switch

-(void)switchOFFORON:(UISwitch *)sender
{
    mySwitch = (UISwitch *)sender;
    BOOL setting = mySwitch.isOn;//获得开关状态
    if(setting)
    {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:nil message:@"您登录后才能保存乘机人信息，是否登录?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"【暂不登录】",@"【登录】", nil];
        [alter show];
        [alter release];
        
    }else {
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        mySwitch.on = NO;    // 若不登陆则状态位OFF
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"进入登陆界面");
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)delPassenger:(id)sender {
    

    
    LoginBusiness *bis =[[LoginBusiness alloc] init];
    
    [bis deleteCommonPassengerWithPassengerId:self.passenger.contactId userDic:nil andDelegate:self];

    
}

-(void)getDate:(void (^) (NSString * name, NSString * identity))string
{
    [blocks release];
    blocks = [string copy];
}
-(void)back
{
    //  blocks(name,identityType);
    self.passenger = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    
    
    
    
    
    
    
    if (Default_IsUserLogin_Value) {
        AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        passengerName = cell.secText.text;
        
        AddPersonCoustomCell *cell1 = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        certMember = cell1.secText.text;
        
        AddPersonCoustomCell *cell2 = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        brithMember = cell2.secText.text;
        
        
//        [self.cellTextArr replaceObjectAtIndex:0 withObject:passengerType];
//        
//        [self.cellTextArr replaceObjectAtIndex:2 withObject:passengerCertType];
        
        
        if ([passengerCertType isEqualToString:@"身份证"] || passengerCertType == nil) {
            
            certtype = @"0";
        }
        if ([passengerCertType isEqualToString:@"护照"]) {
            certtype = @"1";
        }
        else if ([passengerCertType isEqualToString:@"其它"]){
            certtype = @"9";
        }
      

        
        NSString * passenType = nil;
        if ([passengerType isEqualToString:@"成人"] || passengerType == nil) {
            passenType = @"01";
        }
        else{
            passenType = @"02";
        }
        
        LoginBusiness *bis = [[LoginBusiness alloc] init];
        
        CommonContact *contact = [[CommonContact alloc] initWithName:passengerName
                                                                type:passenType
                                                            certType:certtype
                                                              certNo:certMember
                                                           contactId:self.passenger.contactId];

        
        if ([self.navTitleString isEqualToString:@"添加乘机人"]) {
            
            
            
            [bis addCommonPassengerWithPassengerData:contact andDelegate:self];
            
            
        }
        if ([self.navTitleString isEqualToString:@"编辑乘机人"]) {
            
                       
            [bis editCommonPassengerWithPassengerData:contact andDelegate:self];
            
        }
        
    }
    else{
        
        
        
        
    }
    
}


#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{

    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    

    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    NSLog(@"hfioewhfioawjhfjaekl");
    
    
    [self.navigationController popViewControllerAnimated:YES];

    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[self.addPersonTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AddPersonCoustomCell *cell1 = (AddPersonCoustomCell *)[self.addPersonTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    self.passenger.name = cell.secText.text;
    self.passenger.certNo = cell1.secText.text;
    
    [cell1.secText resignFirstResponder];
    
    [cell.secText resignFirstResponder];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	

    AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[self.addPersonTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AddPersonCoustomCell *cell1 = (AddPersonCoustomCell *)[self.addPersonTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    self.passenger.name = cell.secText.text;
    self.passenger.certNo = cell1.secText.text;
    
    [cell1.secText resignFirstResponder];

    [cell.secText resignFirstResponder];
               
}


@end
