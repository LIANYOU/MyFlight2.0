//
//  MileSearchViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ITTDataRequest.h"

@interface MileSearchViewController : UIViewController<DataRequestDelegate>{
     IBOutlet UILabel *_label1;
     IBOutlet UILabel *_label2;
    IBOutlet UILabel *_telLabel;
     IBOutlet UIView *_contentView;
    


}

@property(retain,nonatomic)UILabel *_label1;
@property(retain,nonatomic)UILabel *_label2;



-(IBAction)telAction:(id)sender;
@end
