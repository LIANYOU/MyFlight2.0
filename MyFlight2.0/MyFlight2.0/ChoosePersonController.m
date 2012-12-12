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
@interface ChoosePersonController ()

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
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    self.selectArr = [NSMutableArray array];
    self.nameDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.identityNumberDic = [NSMutableDictionary dictionaryWithCapacity:5];
    self.typeDic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    histroyBut.frame = CGRectMake(20, 5, 80, 30);
    [histroyBut setTitle:@"返回" forState:UIControlStateNormal];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.leftBarButtonItem=backBtn;
    [backBtn release];
    
    [super viewDidLoad];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    [cell.btn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];
    
    //判断是否已被选择
    cell.btn.tag=indexPath.row;
    selectedSign=NO;
   
    if (self.selectArr.count!=0) {
   
        for (NSNumber *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sel.png"]];
                break;
            }
        }
    }
    if (selectedSign==NO) {
        cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Un sel.png"]];
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 批量选择点选时的操作

-(void)selectMore:(UIButton *)btn
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    ChoosePersonCell *cell = (ChoosePersonCell *)[self.showTableView cellForRowAtIndexPath:indexPath];
    NSString * str = [NSString stringWithFormat:@"%d",btn.tag];
   
    if (self.selectArr.count!=0) {
        for (NSNumber *thisRow in self.selectArr) {
            int a=[thisRow intValue];
            if (btn.tag==a) {
                [self.selectArr removeObject:thisRow];
                
                [self.nameDic removeObjectForKey:str];
                [self.typeDic removeObjectForKey:str];
                [self.identityNumberDic removeObjectForKey:str];
                
                btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Un sel"]];
                return;
            }
        }
    }
    
    [self.nameDic setObject:cell.name.text forKey:str];
    [self.typeDic setObject:cell.type.text forKey:str];
    [self.identityNumberDic setObject:cell.identityNumber.text forKey:str];
    
    [self.selectArr addObject: [NSNumber numberWithInt:btn.tag]];
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sel"]];
}


- (IBAction)addPerson:(UIButton *)sender {
    AddPersonController * add = [[AddPersonController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)back
{
    blocks(self.nameDic,self.identityNumberDic,self.typeDic);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDate:(void (^) (NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type))string
{
    [blocks release];
    blocks = [string copy];
}
- (void)dealloc {
    [_showTableView release];
    [_choosePersonCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowTableView:nil];
    [self setChoosePersonCell:nil];
    [super viewDidUnload];
}
@end
