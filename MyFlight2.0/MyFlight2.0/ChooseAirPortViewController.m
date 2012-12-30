//
//  ChooseAirPortViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ChooseAirPortViewController.h"
#import "AirPortDataBaseSingleton.h"
#import "ChooseAirPortCell.h"
#import "AutomaticPositioningCell.h"
#import "AirPortData.h"

@interface ChooseAirPortViewController (){
    
    NSMutableArray *sectionTitles;
    NSMutableSet *selectItem;
}

@property(nonatomic,retain) NSMutableDictionary *resultDic;

@end

@implementation ChooseAirPortViewController
@synthesize resultDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initSectionTitles{
    
    sectionTitles = [[NSMutableArray alloc] init];
   	[sectionTitles addObject:@"热门"];//letter start with !
	
    for (unichar c = 'A'; c <= 'Z'; ++c) {
        NSString* letter = [NSString stringWithFormat:@"%c", c];
        [sectionTitles addObject:letter];
    }
	
CCLog(@"分区的头部为：%d",[sectionTitles count]);
}

- (void)viewDidLoad
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    selectItem =[[NSMutableSet alloc] init];
    
    
    [super viewDidLoad]; 
    
    [self initSectionTitles];
    resultDic = [[NSMutableDictionary alloc] init];
    //数据库的单例
    AirPortDataBaseSingleton *air =[AirPortDataBaseSingleton shareAirPortBaseData];
    
    self.resultDic = air.correctAirPortsDic;
    
    self.resultHotArray = [self.resultDic objectForKey:@"热门"];
    
//   [ self.resultDic removeObjectForKey:@"热门"];
 
    
    
    
    
    CCLog(@"热门区域为：%d个",[self.resultHotArray count]);
    
    NSLog(@"字典里面 一共有%d个分区",self.resultDic.count);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_searchBar release];
    [_tableView release];
    [sectionTitles release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 28;
}



- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
  
    NSString *string =nil;
    if (section==0) {
        string = @"当前定位机场";
    } else{
        
        string = [sectionTitles objectAtIndex:section-1];
        
    }
    return string;
}
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    
       return sectionTitles;

    
      
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    
    if (section==0) {
        
        rows =1;
    } else{
        NSArray * itemAray = [self.resultDic objectForKey:[sectionTitles objectAtIndex:section-1]];
        
        rows =[itemAray count];
        
    }
    
    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
//    static NSString *CellIdentifier = nil;
    
    
    if (indexPath.section==0) {
        
      static NSString *CellIdentifier  = @"onecell";
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      if (cell==nil) {
          
           NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AutomaticPositioningCell" owner:self options:nil];
           
           
           cell = [array objectAtIndex:0];
       }
        
               
    } else{
        
        static NSString *CellIdentifier = @"cell";
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChooseAirPortCell" owner:self options:nil];
            
            
            cell = [array objectAtIndex:0];
            
        }
        
        ChooseAirPortCell *thisCell = (ChooseAirPortCell *) cell;
        
        NSArray *items = [[self .resultDic objectForKey:[sectionTitles objectAtIndex:indexPath.section -1]] retain];
        
     
        AirPortData *data  = [items objectAtIndex:indexPath.row];
        thisCell.apCodeLabel.text = data.apCode;
        
        thisCell.airPortNameLabel.text = data.apName;
        thisCell.apCodeLabel.textColor =[UIColor darkTextColor];
        thisCell.airPortNameLabel.textColor = [UIColor darkTextColor];
        
        [thisCell.flightState setHidden:YES];
        if ([thisCell.airPortNameLabel.text isEqualToString:self.startAirportName]) {
            
            thisCell.apCodeLabel.textColor = [UIColor blueColor];
            thisCell.airPortNameLabel.textColor =[UIColor blueColor];
            [thisCell.flightState setHidden:NO];
            thisCell.flightState.image = [UIImage imageNamed:@"arrive.png"];
        }
        
            
            
            
            
        if ([thisCell.airPortNameLabel.text isEqualToString:self.endAirPortName]) {
            thisCell.apCodeLabel.textColor = [UIColor blueColor];
            thisCell.airPortNameLabel.textColor =[UIColor blueColor];
            [thisCell.flightState setHidden:NO];
            thisCell.flightState.image =[UIImage imageNamed:@"depart.png"];
            
            
        }
        
        
    }
    
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==0) {
        
        
    } else{
        
//        ChooseAirPortCell *cell = (ChooseAirPortCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        NSArray *items = [[self .resultDic objectForKey:[sectionTitles objectAtIndex:indexPath.section -1]] retain];
        
        
        AirPortData *data  = [items objectAtIndex:indexPath.row];

        
        CCLog(@"选择的机场信息：%@,%@",data.apCode,data.apName);
        
        if (_delegate&&[_delegate respondsToSelector:@selector(ChooseAirPortViewController:chooseType:didSelectAirPortInfo:)]) {
            
            [_delegate ChooseAirPortViewController:self chooseType:self.choiceTypeOfAirPort didSelectAirPortInfo:data];
            
                 
        }
        
          
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];




}




@end
