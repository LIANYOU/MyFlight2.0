//
//  CustomTableView.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomTableViewCell.h"
@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithButtonName:(NSString *)name
{
    self = [super init];
    if ([name isEqualToString:@"按航空公司筛选"]) {
        cellArr = [[NSArray alloc] initWithObjects:@"中国航空",@"山东航空",@"山西航空", nil];
    }
    else{
        cellArr = [[NSArray alloc] initWithObjects:@"时间从早到晚",@"价格从低到高", nil];
    }
    
    self.delegate = self;
    self.dataSource = self;
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = self.resultCell;
    }

    cell.airPortName.text = [cellArr objectAtIndex:indexPath.row];
    
    return cell;

}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
}
- (void)dealloc {
    [_resultCell release];
    [super dealloc];
}
@end
