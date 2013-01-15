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
#import "AppConfigure.h"
#import "LocationAirPortWJ.h"
#import "UIQuickHelp.h"
#import "AirPortDataBase.h"
#import "UIButton+BackButton.h"
@interface ChooseAirPortViewController (){
    
    NSMutableArray *sectionTitles;
    NSMutableSet *selectItem;
    NSInteger selectIndex;
    
    
    BOOL isLocated;
    
    NSString * locationFlag ; // 已经定位以后的标记位
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



#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton  backButtonType:0 andTitle:@""];
    
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    
    
    
    //    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonSystemItemSave target:self action:@selector(loginOut)];
    //
    //    right.tintColor = [UIColor colorWithRed:35/255.0 green:103/255.0 blue:188/255.0 alpha:1];
    //
    //    self.navigationItem.rightBarButtonItem = right;
    //
    //    [right release];
    
    
}

- (void) back{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
    
    
    [super viewDidLoad];
    
    isLocated =NO;
    selectItem =[[NSMutableSet alloc] init];
    
    [self setNav];
    
    [self initSectionTitles];
    
    resultDic = [[NSMutableDictionary alloc] init];
    //数据库的单例
    AirPortDataBaseSingleton *air =[AirPortDataBaseSingleton shareAirPortBaseData];
    
    self.resultDic = air.correctAirPortsDic;
    
    self.resultHotArray = [self.resultDic objectForKey:@"热门"];
    
    //   [ self.resultDic removeObjectForKey:@"热门"];
    
    
    
    
    
    CCLog(@"热门区域为：%d个",[self.resultHotArray count]);
    
    NSLog(@"字典里面 一共有%d个分区",self.resultDic.count);
    
    
    
    // 机场定位
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---  地图定位

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [locationManager stopUpdatingLocation];
    
    NSString *strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];
    NSString *strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];
    NSLog(@"Y: %@  X: %@", strLat, strLng);
    
    
    LocationAirPortWJ * location = [[LocationAirPortWJ alloc] initWithX:strLng andY:strLat andMapType:@"gps" andCode:nil andCodeType:nil andDelegate:self];
    location.delegate = self;
    
    [location getLocationName];
    
    [location release];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locError:%@", error);
    
}


- (void) viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [_searchBar release];
    [_tableView release];
    [sectionTitles release];
    

    CCLog(@"allResult retainCOunt =%d",[_allKeysArray retainCount]);
    
    
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}


- (void) filterAirPortByCondition:(NSString *) condition{
    
    
    self.filterArray = [AirPortDataBaseSingleton findAirPortByCondition:condition];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.tableView == tableView) {
        
        return 28;
        
        
    } else{
        
        return 1;
    }
    
    
}



- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *string =nil;
    
    if (self.tableView == tableView) {
        
        if (section==0) {
            string = @"当前定位机场";
        } else{
            
            string = [sectionTitles objectAtIndex:section-1];
            
        }
        
    }
    
    return string;
}
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (self.tableView == tableView) {
        
        return sectionTitles;
        
        
    } else{
        
        
        return nil;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    
    if (self.tableView == tableView) {
        //        CCLog(@"显示视图");
        
        
        if (section==0) {
            
            rows =1;
        } else{
            NSArray * itemAray = [self.resultDic objectForKey:[sectionTitles objectAtIndex:section-1]];
            
            rows =[itemAray count];
            
        }
        
        
        
    } else{
        
        
        //        CCLog(@"搜索视图");
        [self filterAirPortByCondition:self.searchBar.text];
        
        rows = [self.filterArray count];
    }
    
    
    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    //    static NSString *CellIdentifier = nil;
    
    if (self.tableView == tableView) {
        
        //        NSLog(@"显示视图cell");
        if (indexPath.section==0) {
            
            static NSString *CellIdentifier  = @"onecell";
            cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell==nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AutomaticPositioningCell" owner:self options:nil];
                
                
                cell = [array objectAtIndex:0];
            }
            
            
            AutomaticPositioningCell *thisCell =(AutomaticPositioningCell *) cell;
            
            if (isLocated) {
                thisCell.thsiImage.hidden = YES;
                NSString *string =[self.locationInfoArr objectAtIndex:0];
                
                
                thisCell.apName.text =  [string stringByReplacingOccurrencesOfString:@"机场" withString:@""];
            }
            
            
            
//            if ([thisCell.apName.text isEqualToString:<#(NSString *)#>]) {
//                <#statements#>
//            }
            
            
            
            
            
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
            
            thisCell.apCodeLabel.textColor =View_BackGrayTitleOne_Color;
            thisCell.airPortNameLabel.textColor = View_BackGrayTitleOne_Color;
            thisCell.airPortNameLabel.highlightedTextColor =View_BackGrayTitleOne_Color;
            
            thisCell.apCodeLabel.highlightedTextColor= View_BackGrayTitleOne_Color;
            
            
            [thisCell.thisStateView setHidden:YES];
            
            
            if (self.choiceTypeOfAirPort==AIRPORT_Big_Screen_ChooseType) {
                
                
                if ([thisCell.airPortNameLabel.text isEqualToString:self.startAirportName]) {
                    
                    //                    thisCell.apCodeLabel.textColor = [UIColor blueColor];
                    //                    thisCell.airPortNameLabel.textColor =[UIColor blueColor];
                    //                    [thisCell.flightState setHidden:NO];
                    //                    thisCell.flightState.image = [UIImage imageNamed:@"arrive.png"];
                    
                    thisCell.accessoryType=UITableViewCellAccessoryCheckmark;
                    
                }  else{
                    
                    
                    thisCell.accessoryType = UITableViewCellAccessoryNone;
                }
                
                
            } else{
                
                
                if ([thisCell.airPortNameLabel.text isEqualToString:self.startAirportName]) {
                    
                    thisCell.apCodeLabel.textColor = FONT_Blue_Color;
                    thisCell.airPortNameLabel.textColor =FONT_Blue_Color;
                    [thisCell.thisStateView setHidden:NO];
                    thisCell.labelState.text =@"到达";
                    thisCell.labelState.textColor =FONT_Blue_Color;
                    
                    
                    
                    thisCell.apCodeLabel.highlightedTextColor = FONT_Blue_Color;
                    
                    thisCell.airPortNameLabel.highlightedTextColor =FONT_Blue_Color;
                    thisCell.labelState.highlightedTextColor =FONT_Blue_Color;
                    
                    
                    thisCell.flightState.image = [UIImage imageNamed:@"icon_arrive.png"];
                }
                
                
                
                
                
                if ([thisCell.airPortNameLabel.text isEqualToString:self.endAirPortName]) {
                    
                    thisCell.apCodeLabel.textColor = FONT_Blue_Color;
                    thisCell.airPortNameLabel.textColor =FONT_Blue_Color;
                    [thisCell.thisStateView setHidden:NO];
                    thisCell.labelState.text =@"出发";
                    thisCell.labelState.textColor =FONT_Blue_Color;
                    
                    thisCell.apCodeLabel.highlightedTextColor = FONT_Blue_Color;
                    
                    thisCell.airPortNameLabel.highlightedTextColor =FONT_Blue_Color;
                    
                    
                    
                    thisCell.labelState.textColor =[UIColor colorWithRed:99.0/255 green:159.0/255 blue:76.0/255 alpha:1];
                    thisCell.flightState.image =[UIImage imageNamed:@"icon_depart.png"];
                    thisCell.labelState.highlightedTextColor=[UIColor colorWithRed:99.0/255 green:159.0/255 blue:76.0/255 alpha:1];
                    
                }
                
                
            }
            
            
        }
        
        
    } else{
        
        
        static NSString *CellIdentifier = @"cell";
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChooseAirPortCell" owner:self options:nil];
            
            
            cell = [array objectAtIndex:0];
            
        }
        
        ChooseAirPortCell *thisCell = (ChooseAirPortCell *) cell;
        
        AirPortData *data = [self.filterArray objectAtIndex:indexPath.row];
        
        thisCell.apCodeLabel.text = data.apCode;
        
        thisCell.airPortNameLabel.text = data.apName;
        thisCell.apCodeLabel.textColor =[UIColor darkTextColor];
        thisCell.airPortNameLabel.textColor = [UIColor darkTextColor];
        
        [thisCell.thisStateView setHidden:YES];
        
        
        
        if (self.choiceTypeOfAirPort==AIRPORT_Big_Screen_ChooseType) {
            
            
            if ([thisCell.airPortNameLabel.text isEqualToString:self.startAirportName]) {
                
                //                    thisCell.apCodeLabel.textColor = [UIColor blueColor];
                //                    thisCell.airPortNameLabel.textColor =[UIColor blueColor];
                //                    [thisCell.flightState setHidden:NO];
                //                    thisCell.flightState.image = [UIImage imageNamed:@"arrive.png"];
                
                thisCell.accessoryType=UITableViewCellAccessoryCheckmark;
                
            }  else{
                
                
                thisCell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            
        } else{
            
            
            if ([thisCell.airPortNameLabel.text isEqualToString:self.startAirportName]) {
                
                thisCell.apCodeLabel.textColor = FONT_Blue_Color;
                thisCell.airPortNameLabel.textColor =FONT_Blue_Color;
                [thisCell.thisStateView setHidden:NO];
                
                thisCell.labelState.text =@"到达";
                thisCell.labelState.textColor = [UIColor blueColor];
                
                thisCell.labelState.highlightedTextColor =FONT_Blue_Color;
                thisCell.apCodeLabel.highlightedTextColor =FONT_Blue_Color;
                thisCell.airPortNameLabel.highlightedTextColor=FONT_Blue_Color;
                
                thisCell.flightState.image = [UIImage imageNamed:@"icon_arrive.png"];
            }
            
            
            if ([thisCell.airPortNameLabel.text isEqualToString:self.endAirPortName]) {
                thisCell.apCodeLabel.textColor = [UIColor blueColor];
                
                thisCell.airPortNameLabel.textColor =[UIColor blueColor];
                
                [thisCell.thisStateView setHidden:NO];
                
                thisCell.apCodeLabel.highlightedTextColor =FONT_Blue_Color;
                thisCell.airPortNameLabel.highlightedTextColor=FONT_Blue_Color;
                thisCell.labelState.highlightedTextColor=[UIColor colorWithRed:99.0/255 green:159.0/255 blue:76.0/255 alpha:1];
                
                thisCell.labelState.text =@"出发";
                thisCell.labelState.textColor =[UIColor colorWithRed:99.0/255 green:159.0/255 blue:76.0/255 alpha:1];
                thisCell.flightState.image =[UIImage imageNamed:@"icon_depart.png"];
            }
        }
        
        
    }
    // Configure the cell...
    
    return cell;
}


- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        if (!isLocated) {
            return nil;
        } else{
            
            return indexPath;
        }
        
        
    }
    
    
return indexPath;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.tableView == tableView) {
        
        if (indexPath.section==0) {
            
            
            if (isLocated) {
                
                
                NSString *code =[self.locationInfoArr objectAtIndex:1];
                CCLog(@"选择的是%@",code);
                
                
                AirPortData *data =[AirPortDataBase findAirPortByApCode:code];
                
                
                CCLog(@"选择的机场信息：apcode = %@,apname =%@ city_x =%@ weatherCode =%@",data.apCode,data.apName,data.city_x,data.weatherCode);
                
                CCLog(@"机场坐标：%@ %@ ", data.air_x,data.air_y);
                
                if (_delegate&&[_delegate respondsToSelector:@selector(ChooseAirPortViewController:chooseType:didSelectAirPortInfo:)]) {
                    
                    [_delegate ChooseAirPortViewController:self chooseType:self.choiceTypeOfAirPort didSelectAirPortInfo:data];
                    
                }
                
                      
            }
            
              
        } else{
            
            
            
            
            if (self.choiceTypeOfAirPort==AIRPORT_Big_Screen_ChooseType) {
                
                //取消选择
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                if (selectIndex!=NSNotFound) {
                    //取得之前选择的那个单元格
                    UITableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
                    
                    //然后将其选择来样式，置为无
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    
                }
                //取得选择的单元格
                UITableViewCell *tmpCell=[tableView cellForRowAtIndexPath:indexPath];
                //标示为选择状态
                tmpCell.accessoryType=UITableViewCellAccessoryCheckmark;
                
                
                selectIndex = indexPath.row;
                
                
                
            } else{
                
                
                
                //        ChooseAirPortCell *cell = (ChooseAirPortCell *)[tableView cellForRowAtIndexPath:indexPath];
                
                NSArray *items = [[self .resultDic objectForKey:[sectionTitles objectAtIndex:indexPath.section -1]] retain];
                
                
                AirPortData *data  = [items objectAtIndex:indexPath.row];
                
                
                CCLog(@"选择的机场信息：apcode = %@,apname =%@ city_x =%@ weatherCode =%@",data.apCode,data.apName,data.city_x,data.weatherCode);
                
                CCLog(@"机场坐标：%@ %@ ", data.air_x,data.air_y);
                
                if (_delegate&&[_delegate respondsToSelector:@selector(ChooseAirPortViewController:chooseType:didSelectAirPortInfo:)]) {
                    
                    [_delegate ChooseAirPortViewController:self chooseType:self.choiceTypeOfAirPort didSelectAirPortInfo:data];
                }
                
                
                
                
                
            }
            
            
        }
    } else{
        
        
        AirPortData *data = [self.filterArray objectAtIndex:indexPath.row];
        
        CCLog(@"选择的机场信息：%@,%@",data.apCode,data.apName);
        
        if (_delegate&&[_delegate respondsToSelector:@selector(ChooseAirPortViewController:chooseType:didSelectAirPortInfo:)]) {
            
            [_delegate ChooseAirPortViewController:self chooseType:self.choiceTypeOfAirPort didSelectAirPortInfo:data];
        }
        
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 搜索代理

//结束搜索后执行的方法
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [self.filterArray removeAllObjects];
    [self.tableView reloadData];
    
}


//将要开始搜索时执行的方法
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [self.filterArray removeAllObjects];
}

#pragma mark -

//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    isLocated =NO;
    NSString * meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    isLocated =NO;
    
    NSString * meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
        
   
  //  CCLog(@"当前定位机场 ； %@", [self.locationInfoArr objectAtIndex:0]);
    
    self.airPortName = [info objectForKey:@"key_error"];
    
    if ([self.airPortName isEqualToString:@"noInfo"]) {
        isLocated=NO;
    }
    else{
        
        locationFlag = @"location";
        
        self.locationInfoArr =[info objectForKey:@"key_result"];

        isLocated =YES;
        [self.tableView reloadData];
    }
    
    
}




@end
