//
//  HistroyCheckViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "HistroyCheckViewController.h"
#import "HistoryCheckDataBase.h"
#import "HistoryCheckInfoData.h"
#import "HistoryCell.h"
#import "OneWayCheckViewController.h"
@interface HistroyCheckViewController ()
{
    NSArray * hisroryArr;
}
@end

@implementation HistroyCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initDatabase
{
    hisroryArr =  [HistoryCheckDataBase findAllHistoryCheck];
    
//    HistoryCheckInfoData * data = [arr objectAtIndex:0];
//
//    for(HistoryCheckInfoData * data in hisroryArr)
//    {
//         NSLog(@"---------%@",data.startAirPortName);
//    }
    [hisroryArr retain];
   
}

- (void)viewDidLoad
{
    hisroryArr = [[NSArray alloc] init];
    [self initDatabase];
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    self.navigationItem.title = @"历史查询纪录";
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(250, 5, 60, 31);
    histroyBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [histroyBut setTitle:@"清除记录" forState:UIControlStateNormal];
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clean_histroy_4words_.png"]];
    [histroyBut addTarget:self action:@selector(deleteHistroy) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteHistroy
{
    [HistoryCheckDataBase deleteAllHistory];
    hisroryArr = nil;
    [self.showTableView reloadData];
   
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (hisroryArr.count == 0) {
        return 0;
    }
    if (hisroryArr.count <= 5) {
        return [hisroryArr count];
    }
    else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HistoryCell *cell = (HistoryCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil];
        cell = self.historyCell;
        
    }
    
    if (hisroryArr .count == 0) {
        return cell;
    }
    else{
        HistoryCheckInfoData * data = [hisroryArr objectAtIndex:hisroryArr.count- indexPath.row -1];
        
        cell.startName.text = data.startAirPortName;
        cell.endName.text = data.endAirPortName;
        if ([data.flag isEqualToString:@"1"]) {
            cell.image.image = [UIImage imageNamed:@"icon_oneway.png"];
        }
        else{
            cell.image.image = [UIImage imageNamed:@"icon_round.png"];
        }
        
        
        return cell;

    }
    
       
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneWayCheckViewController * one = [self.navigationController.viewControllers objectAtIndex:1];
    
    HistoryCheckInfoData * data = [hisroryArr objectAtIndex:hisroryArr.count- indexPath.row -1];
    
    if ([data.flag isEqualToString:@"1"]) {
        one.oneStartName = data.startAirPortName;
        one.oneEndName = data.endAirPortName;
        one.oneStartCode = data.startApCode;
        one.oneEndCode = data.endApCode;
        one.history = self;
        one.flagType = @"1";
    }
    else
    {
        one.startName = data.startAirPortName;
        one.endName = data.endAirPortName;
        one.startCode = data.startApCode;
        one.endCode = data.endApCode;
        one.history = self;
        one.flagType = @"2";
//        NSLog(@"%@%@",one.startCode,one.endCode);
    }
    [self.navigationController popToViewController:one animated:YES];
}

- (void)dealloc {
    [_historyCell release];
    [_showTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHistoryCell:nil];
    [self setShowTableView:nil];
    [super viewDidUnload];
}
@end
