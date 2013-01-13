//
//  SPHFrequentMainViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHFrequentMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//常旅客卡号：
@property (retain, nonatomic) IBOutlet UILabel *cardNumber;

//姓名
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;

@property (retain, nonatomic) IBOutlet UILabel *lichengLabel;

@property (retain, nonatomic) IBOutlet UIView *FucktableviewHeader;
@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

//底部视图
@property (retain, nonatomic) IBOutlet UIView *footView;

- (IBAction)callFuckPhone:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *callPhone;



@end
