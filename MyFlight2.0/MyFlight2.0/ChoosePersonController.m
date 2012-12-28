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
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(260, 5, 40, 31);
    histroyBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [histroyBut setTitle:@"确定" forState:UIControlStateNormal];
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_2words_.png"]];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];


    self.dataArr = [NSMutableArray arrayWithObjects:@"儿童",@"成人",@"儿童",@"成人",@"成人", nil];
    
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
    return 5;
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
   
    if (self.selectArr.count!=0) {
   
        for (NSString *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_choice_.png"]];
                break;
            }
        }
    }
    if (selectedSign==NO) {
        cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ico_def_.png"]];
    }
    
    cell.type.text = [self.dataArr objectAtIndex:indexPath.row];
    
    [cell.btn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddPersonController * add = [[AddPersonController alloc] init];
    add.choose = self;
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
            
                btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ico_def_.png"]];
                return;
            }
        }
    }
    
    [self.selectArr addObject: [NSString stringWithFormat:@"%d",btn.tag]];
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_choice_.png"]];
}


- (IBAction)addPerson:(UIButton *)sender {
    AddPersonController * add = [[AddPersonController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)back
{
    for(NSString * str in self.selectArr)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[str intValue] inSection:0];
        ChoosePersonCell *cell = (ChoosePersonCell *)[self.showTableView cellForRowAtIndexPath:indexPath];
        
        [self.nameDic setObject:cell.name.text forKey:str];
        [self.typeDic setObject:cell.type.text forKey:str];
        [self.identityNumberDic setObject:cell.identityNumber.text forKey:str];
    }
    
    blocks(self.nameDic,self.identityNumberDic,self.typeDic,self.selectArr);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDate:(void (^) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableArray * arr))string
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
@end
