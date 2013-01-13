//
//  CustomTableView.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"



@protocol CustomTableViewDelegate <NSObject>


-(void)delegateViewController:(id)controller didSelectItem:(NSString *)item; // 其他选项传值

@end


@interface CustomTableView : UITableView
{
    NSArray * cellArr;   // 存放不同button推进来的cell的内容
    
}

@property (nonatomic, assign) id<CustomTableViewDelegate> idDelegate;


@property (retain, nonatomic) IBOutlet CustomTableViewCell *resultCell;



-(id)initWithTabelViewData:(NSArray *) codeArr andDelegate:(id<CustomTableViewDelegate>)delegate; // 通过点击的button的名字确认弹出的table里边有多少行数
@end
