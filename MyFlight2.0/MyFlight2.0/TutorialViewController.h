//
//  TutorialViewController.h
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "BasicViewController.h"

@interface TutorialViewController : BasicViewController <UIScrollViewDelegate>
{
    UIImageView *dots_0;
    UIImageView *dots_1;
    UIImageView *dots_2;
    
    UIButton *quitTutorial;
}

- (void) quitTutorial;

@end
