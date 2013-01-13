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




-(id)initWithTabelViewData:(NSArray *) codeArr andDelegate:(id<CustomTableViewDelegate>)delegate{
    
    
    cellArr = [NSArray arrayWithArray:codeArr];
    
    self.frame = CGRectMake(0, 320, 320, 50);
   
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
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
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
    
    [self.idDelegate delegateViewController:self didSelectItem:[cellArr objectAtIndex:indexPath.row] ];
    
    [self removeFromSuperview];
}
- (void)dealloc {
    [_resultCell release];
    [super dealloc];
}
@end
