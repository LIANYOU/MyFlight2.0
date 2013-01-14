//
//  MyLocalOrderListViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/9/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "MyLocalOrderListViewController.h"

#import "OrderDatabase.h"
#import "OrderListModelData.h"
#import "MyOrderListCell.h"
#import "OrderDetaile.h"
#import "AppConfigure.h"
#import "DetailsOrderViewController.h"

@interface MyLocalOrderListViewController ()
{
    
    NSArray *tmpArray;
    
}
@end

@implementation MyLocalOrderListViewController

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
    
    thisFuckView.tableHeaderView=self.thisTableHeaderView;
    
    self.resultArray = [OrderDatabase findAllOrderInfo];
    
    
    
    tmpArray =self.resultArray;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_thisTableHeaderView release];
    [thisFuckView release];
    [ceshiView release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    
    [self setThisTableHeaderView:nil];
    [thisFuckView release];
    thisFuckView = nil;
    [ceshiView release];
    ceshiView = nil;
    [super viewDidUnload];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return 1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView==thisFuckView) {
        
        return [tmpArray count];
    } else{
        
        return 12;
    }

     
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==thisFuckView) {
        return 60;

    } else{
        
        return 44;
    }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==thisFuckView) {
        
        static NSString *CellIdentifier = @"Cell";
        
        MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyOrderListCell" owner:nil options:nil];
            
            cell = [array objectAtIndex:0];
            
        }
        OrderListModelData *data = [tmpArray objectAtIndex:indexPath.row];
        
        
        cell.totalMoney.text =data.totalMoney;
        cell.orderState.text = data.payStsCH;
        
        cell.areaInfo.text = [NSString stringWithFormat:@"%@-%@",data.depAirportName,data.arrAirportName];
        
        
        NSString *time = [data.createTime substringWithRange:NSMakeRange(0, 10)];
        
        
        
        cell.orderTime.text = time;
        
        return cell;

    } else{
        
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
        }

        cell.textLabel.text = @"ceshi";
        
        
        return cell;
    }
    

    return nil;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView==thisFuckView) {
        
        OrderListModelData *data = [tmpArray objectAtIndex:indexPath.row];
        
        NSString *orderId =data.orderId;
//        NSString *code = data.code;
//        NSString *createTime =data.createTime;
        
        NSString *memberId = Default_UserMemberId_Value;
        NSString *token =Default_Token_Value;
        
        NSString *signTmp =[NSString stringWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,token];
        
        NSString *sign =GET_SIGN(signTmp);
        
        CCLog(@"用户选择的订单号为%@",orderId);
        CCLog(@"订单code ;%@",data.code);
        CCLog(@"type：%@",data.type);
        
        
        OrderDetaile *detail = nil;
        if (Default_IsUserLogin_Value) {
            
            detail =[[OrderDetaile alloc] initWithOrderId:orderId
                                                            andMemberId:memberId
                                                           andCheckCode:data.type
                                                                sndSign:sign
                                                              sndSource:SOURCE_VALUE
                                                                andHwId:HWID_VALUE
                                                             andEdition:EDITION_VALUE
                                                            andDelegate:nil];

        }
        else{
            
            detail =[[OrderDetaile alloc] initWithOrderId:orderId
                                                            andMemberId:nil
                                                           andCheckCode:data.checkCode
                                                                sndSign:nil
                                                              sndSource:SOURCE_VALUE
                                                                andHwId:HWID_VALUE
                                                             andEdition:EDITION_VALUE
                                                            andDelegate:nil];

        }
        
        
        DetailsOrderViewController *con  =[[DetailsOrderViewController alloc] init];
        
        
        con.detaile = detail;
        
        
        [self.navigationController pushViewController:con animated:YES];
        
    }
    
  
}



@end
