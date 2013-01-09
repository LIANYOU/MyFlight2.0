//
//  SMSViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SMSViewController.h"
#import "UIButton+BackButton.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "AppConfigure.h"
#define ADD_Y 56
@interface SMSViewController ()

@end

@implementation SMSViewController

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
    nameAndPhone = [[NSMutableArray alloc]initWithCapacity:0];
    flag = NO;
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    //输入框
    cusInputTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, 280, 24)];
    cusInputTextField.font = [UIFont systemFontOfSize:17];
    cusInputTextField.text = @"手动输入一个手机号码";
    cusInputTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:cusInputTextField];
    cusInputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [cusInputTextField setBorderStyle:UITextBorderStyleRoundedRect];
    cusInputTextField.textColor = [UIColor lightGrayColor];
    cusInputTextField.returnKeyType = UIReturnKeyJoin;
    //编辑时会出现个修改X
    cusInputTextField.clearButtonMode = UITextFieldViewModeWhileEditing; 
    cusInputTextField.delegate = self;
    
    
    
   
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:222.0/255.0 blue:215.0/255.0 alpha:1];
        //导航栏rightItem
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, 76, 30);
    [myBtn setImage:[UIImage imageNamed:@"clean_histroy_4words.png"] forState:UIControlStateNormal];
    [myBtn setImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:UIControlStateHighlighted];
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(7, 2, 70, 26)];
    titleLable.font = [UIFont systemFontOfSize:13];
    titleLable.text = @"选择联系人";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    [myBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn addSubview:titleLable];
    [titleLable release];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:myBtn];
    [myBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //CGRectMake(20, 10, 280, 44);
    //发送短信按钮
    sendMessageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendMessageBtn.frame = CGRectMake(20, 10 + ADD_Y, 280, 44);
    [sendMessageBtn setImage:[UIImage imageNamed:@"orange_btn.png"] forState:UIControlStateNormal];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 11, 80, 22)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"发送短息";
    label.textColor = [UIColor whiteColor];
    [sendMessageBtn addSubview:label];
    [label release];
    [sendMessageBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageBtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)rightItemClick:(UIBarButtonItem *)arg{
    if ([nameAndPhone count] < 10) {
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }else{
        UIAlertView * toMore = [[UIAlertView alloc]initWithTitle:@"已满" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [toMore show];
        [toMore release];
    }
    
}



//- (IBAction)sendMessageBtnClick:(id)sender {
//    
//}
#pragma mark - 发送短息
-(void)sendMessage:(UIButton *)sender{
    NSLog(@"发短信");
    //nameAndPhone(NSArray *)
    NSMutableString * peopleList = [[[NSMutableString alloc]initWithCapacity:0]autorelease];
    for (int i = 0; i < [nameAndPhone count]; i++) {
        //J-张三-13100000000
        if (flag == NO) {
            flag = YES;
        }else{
            [peopleList appendString:@";"];
        }
        
        NSString * tempString1 = [NSString stringWithFormat:@"%@",[[nameAndPhone objectAtIndex:i]objectForKey:@"name"]];
        if (tempString1.length == 0) {
            NSString * tempString = [NSString stringWithFormat:@"J-%@;",[[nameAndPhone objectAtIndex:i]objectForKey:@"phone"]];
            [peopleList appendString:tempString];
        }else{
            NSString * tempString = [NSString stringWithFormat:@"J-%@-%@;",[[nameAndPhone objectAtIndex:i]objectForKey:@"name"],[[nameAndPhone objectAtIndex:i]objectForKey:@"phone"]];
            [peopleList appendString:tempString];
        }
        
    }
    flag = NO;
    NSLog(@"%@",peopleList);
    
    [self getDataWithList:peopleList];
}

//改变“发送短信”按钮位置 并刷新数据
-(void)resetSendMessageBtnFrame{
    NSLog(@"//改变“发送短信”按钮位置 并刷新数据");
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView * oneMan = obj;
            if (oneMan.tag == 999999) {
                [oneMan removeFromSuperview];
            }
            
        }
    }
    NSLog(@"%d",[nameAndPhone count]);
    for (int i = 0; i < [nameAndPhone count]; i++) {
        [self createPersonInfoLabelWithIndex:i name:[[nameAndPhone objectAtIndex:i]valueForKey:@"name"] phone:[[nameAndPhone objectAtIndex:i]valueForKey:@"phone"]];
    }
    sendMessageBtn.frame = CGRectMake(20, 10 + ADD_Y + [nameAndPhone count] * 36, 280, 44);
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    //是否存在此人 开关
    haveThisMan = NO;
    
    //获取联系人姓名
    NSString * name = (NSString*)ABRecordCopyCompositeName(person);
    
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++)
    {
        NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i) autorelease];
        NSString *aLabel = [(NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i) autorelease];
        
        //获取号码
        NSString * temp1 =  [aPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        NSString * new = [temp1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString * phone = new;
        NSLog(@"PhoneLabel:%@ Phone#:%@",aLabel,aPhone);
        
        //查重
        NSDictionary * oneMan = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name",phone,@"phone", nil];
        for (NSDictionary * dic in nameAndPhone) {
            if ([[dic valueForKey:@"name"] isEqualToString:name]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"已存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [alert release];
                haveThisMan = YES;
                return NO;
            }
        }
        //将联系人添加到数组中
        if (haveThisMan == NO) {
            [nameAndPhone addObject:oneMan];
        }
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"]){
            [phones addObject:aPhone];
            NSLog(@"[phones count] : %d",[phones count]);
        }
    }
//    //获取号码
//    if([phones count]>0)
//    {   NSLog(@"[phones count]>0");
//        phone = [phones objectAtIndex:0];
//    }
    
    
    //获取联系人邮箱
    ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    for (int i = 0;i < ABMultiValueGetCount(emailMulti); i++)
    {
        //邮箱地址
        NSString *emailAdress = [(NSString*)ABMultiValueCopyValueAtIndex(emailMulti, i) autorelease];
        [emails addObject:emailAdress];
    }
//    if([emails count]>0){
//        NSString *emailFirst=[emails objectAtIndex:0];
//        NSString * email = emailFirst;
//    }
    [self resetSendMessageBtnFrame];
    [peoplePicker dismissModalViewControllerAnimated:YES];
    return NO;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}


-(void)createPersonInfoLabelWithIndex:(NSInteger)index name:(NSString *)name phone:(NSString *)phone{
    UIColor * nameColor = [UIColor colorWithRed:20/255.0 green:97/255.0 blue:174/255.0 alpha:1];
    UIColor * bottom1Color = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    UIColor * bgColor = [UIColor colorWithRed:247.0/255.0 green:243.0/255.0 blue:239.0/255.0 alpha:1];

    
    UIView * oneMan = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + 36 * index + ADD_Y, 320, 36)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    btn.alpha = 0.1;
    btn.backgroundColor = [UIColor whiteColor];
    btn.frame = CGRectMake(0, 0, 320, 36);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    oneMan.backgroundColor = bgColor;
    UIImageView * bottom1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 34 , 320, 1)];
    bottom1.backgroundColor = bottom1Color;
    [oneMan addSubview:bottom1];
    [bottom1 release];
    
    UIImageView * bottom2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 35, 320, 1)];
    bottom2.backgroundColor = [UIColor whiteColor];
    [oneMan addSubview:bottom2];
    [bottom2 release];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 120, 30)];
    nameLabel.tag = 100;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = name;
    nameLabel.textColor = nameColor;
    [oneMan addSubview:nameLabel];
    [nameLabel release];
    
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 3, 130, 30)];
    phoneLabel.tag = 101;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = phone;
    phoneLabel.textColor = [UIColor blackColor];
    [oneMan addSubview:phoneLabel];
    [phoneLabel release];
    
    [self.view addSubview:oneMan];
    
    //手势
    UITapGestureRecognizer * myTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendMessageTap:)];
    myTap.numberOfTapsRequired = 1;
    myTap.numberOfTouchesRequired = 1;
//    [oneMan addGestureRecognizer:myTap];
    [myTap release];
    
    [oneMan addSubview:btn];
    oneMan.tag = 999999;
    
    
    [oneMan release];
}

-(void)sendMessageTap:(UITapGestureRecognizer *)tap{
    [[tap.view superview] viewWithTag:100];
    
//    UIAlertView * tapAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
}

#pragma mark - 导航定制左键响应
-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 短信联系人btn
-(void)btnClick:(UIButton *)btn{
    NSString * tempStr = [NSString stringWithFormat:@"%@ %@",[[nameAndPhone objectAtIndex:btn.tag]objectForKey:@"name"],[[nameAndPhone objectAtIndex:btn.tag]objectForKey:@"phone"]];
    delegateIndex = btn.tag;
    UIAlertView * tapAlert = [[UIAlertView alloc]initWithTitle:@"删除" message:tempStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [tapAlert show];
}

#pragma mark textField代理

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    cusInputTextField.text = @"";
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    cusInputTextField.textColor = [UIColor blackColor];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString * myStr = cusInputTextField.text;
    if (cusInputTextField.text.length == 0) {
        [cusInputTextField resignFirstResponder];
    }
    if ([self checkTel:myStr] == YES) {
        if ([nameAndPhone count] == 0) {
            NSDictionary * phone = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"name",myStr,@"phone", nil];
            [nameAndPhone addObject:phone];
            [self resetSendMessageBtnFrame];
            [cusInputTextField resignFirstResponder];
            
        }else{
            
            for (int i = 0;i < [nameAndPhone count];i++) {
                NSDictionary * dic = [nameAndPhone objectAtIndex:i];
                NSLog(@"dic : %@",[dic objectForKey:@"phone"]);
                if ([[dic objectForKey:@"phone"] isEqualToString:myStr] == YES) {
                    isHave = YES;
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"已存在" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [self resetSendMessageBtnFrame];
                    [cusInputTextField resignFirstResponder];
                    [alert show];
                    [alert release];
                    
                }
            }
            if (isHave == NO) {
                NSDictionary * phone = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"name",myStr,@"phone", nil];
                
                [nameAndPhone addObject:phone];
                [self resetSendMessageBtnFrame];
                [cusInputTextField resignFirstResponder];
                
            }
            isHave = NO;
            
        }

    }
    
    
    return YES;
  
}

#pragma mark - 判断手机号码
- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert release];
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert release];
        
        return NO;
    }
    return YES;
    
}




#pragma mark - alert代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [nameAndPhone removeObjectAtIndex:delegateIndex];
        [self resetSendMessageBtnFrame];
    }
}
#pragma mark - 

-(void)getDataWithList:(NSString *)peopleList{
    myData = [[NSMutableData alloc]init];
    
    // Do any additional setup after loading the view from its nib.
    
    // NSString * myUrl = [NSString stringWithFormat:@"%@3gWeb/api/provision.jsp",BASE_Domain_Name];
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Flight/BookFlightMovement.json"];
    
    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;
    
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:memberID forKey:@"memberId"];
    [request setPostValue:@"51YOU" forKey:@"orgSource"];
    [request setPostValue:subMyFlightConditionDetailData.flightNum  forKey:@"fno"];
    [request setPostValue:subMyFlightConditionDetailData.deptDate  forKey:@"fdate"];
    [request setPostValue:subMyFlightConditionDetailData.flightDepcode forKey:@"dpt"];
    [request setPostValue:subMyFlightConditionDetailData.flightArrcode forKey:@"arr"];
    [request setPostValue:subMyFlightConditionDetailData.deptTime forKey:@"dptTime"];
    [request setPostValue:subMyFlightConditionDetailData.arrTime forKey:@"arrTime"];
    [request setPostValue:nil forKey:@"dptName"];
    [request setPostValue:nil forKey:@"arrName"];
    [request setPostValue:@"M" forKey:@"type"];
    [request setPostValue:peopleList forKey:@"sendTo"];
    [request setPostValue:nil forKey:@"message"];
    [request setPostValue:hwID forKey:@"token"];
    [request setPostValue:@"1" forKey:@"source"];
    [request setPostValue:hwID forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    NSLog(@"request :%@",request);
    
    [request setCompletionBlock:^{
        
//        NSData * jsonData = [request responseData];
        NSString * string = [request responseString];
        
   
        NSLog(@"temp : %@",string);
       
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)dealloc{
    [nameAndPhone release];
    [super dealloc];
}
@end
