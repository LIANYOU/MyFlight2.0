//
//  A1FirstLevelViewController.m
//  SearchJob
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1FirstLevelViewController.h"

#import "A1LevelViewCell.h"
#import "GDataXMLNode.h"

@implementation A1FirstLevelViewController


@synthesize selectRow;
@synthesize provienceID;
@synthesize provienceArr;
@synthesize jobArr;
@synthesize jobIDArr;
@synthesize industryArr;
@synthesize publishDateArr;
@synthesize workEXPArr;
@synthesize educationArr;
@synthesize compsizeArr;
@synthesize comptypeArr;
@synthesize delegate;
@synthesize string;

@synthesize tableView1;
@synthesize tableView2;
@synthesize view1;
@synthesize townArr;
@synthesize smallJobArr;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
    [super dealloc];
    [tableView1 release];
    [tableView2 release];
    [view1 release];
    [string release];
    [delegate release];
    [provienceArr release];
    [provienceID release];
    [townArr release];
    [jobArr release];
    [jobIDArr release];
    [smallJobArr release];
    [industryArr release];
    [publishDateArr release];
    [workEXPArr release];
    [educationArr release];
    [compsizeArr release];
    [comptypeArr release];
    
}
#pragma mark - View lifecycle

-(void)initData  // 初始化tableView1的数据
{
    
    NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];//本地的
    // NSLog(@"%@",str);
    //解析XML,把结果放在document里边.
    GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    GDataXMLElement * root = [document rootElement];//获得根节点
    
    
    if (self.selectRow == 3)
    {
        provienceArr = [[NSMutableArray alloc] init];
        provienceID = [[NSMutableArray alloc] init];
        
        NSArray *rootChildren=[root children];//获得根节点的各个子节点
        GDataXMLElement *basedata =[rootChildren objectAtIndex:0];
        GDataXMLElement *city=[[basedata children]objectAtIndex:0];
        GDataXMLElement *firstLevel=[[city children]objectAtIndex:0];
        
        
        for (int i=0;i<[firstLevel childCount];i++) 
        {
            GDataXMLElement *firstCity=[[firstLevel children]objectAtIndex:i];
            NSString *firstCityName=[firstCity stringValue];
            NSString *firstCityId=[[firstCity attributeForName:@"code"]stringValue];
            [provienceArr addObject:firstCityName];
            
            [provienceID addObject:firstCityId];
            
        }
        
    }
    else if (self.selectRow == 1) // 工作选择
    {
        
        self.jobArr = [[NSMutableArray alloc] init];
        self.jobIDArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//jobtype/item" error:nil];
        for(GDataXMLElement * item in arr)
        {
            NSString *firstCityId=[[item attributeForName:@"code"]stringValue];
            
            [self.jobArr addObject:[item stringValue]];  // 此处是双层的，，，记录一个ID
            [self.jobIDArr addObject:firstCityId];
            
        }
        
    }
    else if (self.selectRow == 2)
    {
        
        self.industryArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//industry/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.industryArr addObject:[item stringValue]];            
        }
        
    }

}
-(void)initTableView2  // 初始化第二个表的数据
{
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];  // 第二个表加在这个view1上边，view1和第一个表是同级别的
    self.view1.backgroundColor = [UIColor blackColor];
    self.view1.alpha = 0.75;
    
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(100, 2, 220, 480) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]; //self.tableView的背景设置
    imageView.image = [UIImage imageNamed:@"纸纹"];
    self.tableView2.backgroundView = imageView;
    
    [self.view1 addSubview:self.tableView2];
    
    
    
    CATransition *animation = [CATransition animation];  // 第一一个动画，从右边推出第二个表（view1）
    animation.duration = 0.2f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [self.view1.layer addAnimation:animation forKey:@"animation"];
    
    
    [self.view addSubview:self.view1];
    
    self.tableView1.userInteractionEnabled = NO;
    self.view1.userInteractionEnabled = YES;
    self.tableView2.userInteractionEnabled = YES;
    
    [view1 release];
    [tableView2 release];
    
}

-(void)initTableView2Data  // 初始化第二个表中的数据
{
    if (self.selectRow == 3) 
    {
        self.townArr = [[NSMutableArray alloc] init];
        
        if (section1 == 0) {
            ID = index;//判断前一个视图选择的是第几行，
        }
        else {
            ID = index + 27;
        }
        NSString * IDStr = [provienceID objectAtIndex:ID];//根据ID找到provienceID，例如北京530；
        
        
        NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];//本地的
        // NSLog(@"%@",str);
        //解析XML,把结果放在document里边.
        GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
        GDataXMLElement * root = [document rootElement];//获得根节点
        
        
        NSArray *rootChildren=[root children];//获得根节点的各个子节点
        GDataXMLElement *basedata =[rootChildren objectAtIndex:0];
        GDataXMLElement *city=[[basedata children]objectAtIndex:0];
        
        GDataXMLElement * secondLevel = [[city children] objectAtIndex:1];
        
        for (int i=0;i<[secondLevel childCount];i++) 
        {
            GDataXMLElement *secondCity=[[secondLevel children]objectAtIndex:i];
            
            NSString *secondCityId=[[secondCity attributeForName:@"parent"]stringValue];
            
            if ([secondCityId isEqualToString:IDStr]) {
                NSString *secondCityName=[secondCity stringValue];
                //               NSLog(@"%@",secondCityName);
                
                [self.townArr addObject:secondCityName]; //存放北京里边的详细城市
            }
            
        }
        
    }
    else if (self.selectRow == 1)
    {
        
        self.smallJobArr = [[NSMutableArray alloc] init];
        ID = index;
        NSString * IDStr = [self.jobIDArr objectAtIndex:ID];
        
        
        NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];//本地的
        // NSLog(@"%@",str);
        //解析XML,把结果放在document里边.
        GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
        GDataXMLElement * root = [document rootElement];//获得根节点
        
        
        NSArray *rootChildren=[root children];//获得根节点的各个子节点
        GDataXMLElement *basedata =[rootChildren objectAtIndex:0];
        GDataXMLElement *small_Job_type=[[basedata children]objectAtIndex:5];
        
        
        
        for (int i=0;i<[small_Job_type childCount];i++) 
        {
            GDataXMLElement *secondCity=[[small_Job_type children]objectAtIndex:i];
            
            NSString *secondCityId=[[secondCity attributeForName:@"categoryid"]stringValue];
            
            if ([secondCityId isEqualToString:IDStr]) {
                NSString *secondCityName=[secondCity stringValue];
                
                [self.smallJobArr addObject:secondCityName];
            }
            
        }
        
    }
    
}
-(void)loadView
{
    
    [self initData];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];   // 自定义 navigationItem
    btn.frame=CGRectMake(0, 0, 55, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(newBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    [btn release];
    self.navigationItem.leftBarButtonItem=backBtn;   
    [backBtn release];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]; //self.tableView的背景设置
    imageView.image = [UIImage imageNamed:@"纸纹"];
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.backgroundView = imageView;
    [self.view addSubview:tableView1];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event   // 点击第二个表左边的黑色view的时候，第二个表消失
{
    UITouch * touch =[touches anyObject];
    CGPoint  point =[touch locationInView:self.view1];
    if (point.x>0 && point.x<100) {
        [view1 removeFromSuperview];
    }    
    self.tableView1.userInteractionEnabled = YES;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
    self.navigationItem.title = self.string;
    
}

-(void)newBack//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView1) {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section     // 返回分区的行数
{
    if (tableView == self.tableView1 && section == 0) {  // 第一个表的第0个分区
        
        switch (self.selectRow) {
            case 1:
                return [self.jobArr count];
            case 2:
                return [self.industryArr count];
            case 3:
                return 27;
            default:
                break;
        }

    }
    else if (tableView == self.tableView1 && section == 1){
        return (self.provienceArr.count - 27);
    }
    
    else // 第二个表中的数据行数
    {
        if (self.selectRow == 1) {
            return [self.smallJobArr count];
        }
        else{
            return [self.townArr count];
        }
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section // 表尾高度
{
    if (tableView == self.tableView2) {
        return 80;
    }
    else
    {
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section // 表头title
{
    if (tableView == self.tableView1) {
        if (self.selectRow == 3 && section == 0) {
            return @"热门城市";
        }
        else if (self.selectRow == 3 && section == 1) {
            return @"按省份";
        }
    }
    else{
        return @"";
    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {   // 对表一的cell赋值
        static NSString *CellIdentifier = @"Cell";
        
        A1LevelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[A1LevelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        switch (self.selectRow) {
            case 1:{
                if (indexPath.row == 0) {
                    cell.imageView.image = [UIImage imageNamed:@"11999.png"];
                }
                cell.nameLabel.text = [self.jobArr objectAtIndex:indexPath.row];
                break;
            }
            case 2:{
                cell.nameLabel.text = [self.industryArr objectAtIndex:indexPath.row];
                cell.imageView.image = [UIImage imageNamed:@"119999.png"];


                
                break;
            }
            case 3:{
                if (indexPath.section == 0) {
                    section1 = 0;
                    cell.nameLabel.text = [self.provienceArr objectAtIndex:indexPath.row];
                }
                else {
                    section1 = 1;
                    cell.nameLabel.text = [self.provienceArr objectAtIndex:indexPath.row + 27];
                }
                break;
            }
        }
        
        return cell;
        
    }
    else  // 对表二cell赋值
    {
        static NSString *CellIdentifier = @"Cell1";
        A1LevelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) 
        {
            cell = [[[A1LevelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        if (self.selectRow == 1) 
        {
            cell.nameLabel.text = [self.smallJobArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 3)
        {
            cell.nameLabel.text = [self.townArr objectAtIndex:indexPath.row];
        }
        return cell;
        
    }
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1 && ((self.selectRow == 1 && (indexPath.row != 0)) || self.selectRow ==3)) {
        if ((self.selectRow == 1 && indexPath.row != 0)|| self.selectRow== 3) {  // 双层数据的初始化第二个表
            
            index = indexPath.row;
            [self initTableView2Data];
            [self initTableView2];
            
        }
        
    }
    else if (tableView == self.tableView2)
    {
        if (self.selectRow == 1) {
            if (blocks) {
                blocks([self.smallJobArr objectAtIndex:indexPath.row]);
            }
           // [delegate A1FirstLevelViewController:self didSelectJob:[self.smallJobArr objectAtIndex:indexPath.row]];
        }
        else if (self.selectRow == 3){
            [delegate A1FirstLevelViewController:self didSelectTown:[self.townArr objectAtIndex:indexPath.row]];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else if (tableView == self.tableView1)
    {
        if (self.selectRow == 1 && indexPath.row == 0) {
            self.string = (NSMutableString *)@"不限";
        }
        if (self.selectRow == 2) {
            self.string = [industryArr objectAtIndex:indexPath.row];
        }        
        [self.delegate A1FirstLevelViewController:self didSelectItem:self.string];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

-(void)setDataFromA1FirstLevelViewController:(void (^) (NSString * job))controller
{
    [blocks release];
    blocks = [controller copy];
}

@end
