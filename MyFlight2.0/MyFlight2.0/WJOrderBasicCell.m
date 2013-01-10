//
//  WJOrderBasicCell.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "WJOrderBasicCell.h"

@implementation WJOrderBasicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_orderNo release];
    [_orderData release];
    [_orderStation release];
    [_payStation release];
    [_orderAllPay release];
    [_infoView release];
    [_discount release];
    [_discountPay release];
    [_slive release];
    [_gold release];
    [_payOnline release];
    [_allPayLabel release];
    [_cellAddView release];
    [super dealloc];
}
@end
