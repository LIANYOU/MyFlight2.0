//
//  TextInputHelperViewController.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "TextInputHelperViewController.h"

@interface TextInputHelperViewController ()

@end

@implementation TextInputHelperViewController

- (id) initWithKeyboardType:(UIKeyboardType)type
{
    self = [super init];
    if(self)
    {
        self.keyboardType = type;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    textInput = [[UITextField alloc] initWithFrame:CGRectMake(0, 150, 320, 50)];
    
    textInput.textColor = [UIColor blackColor];
    textInput.textAlignment = UITextAlignmentCenter;
    textInput.font = [UIFont systemFontOfSize:50.0f];
    textInput.keyboardType = self.keyboardType;
    
    [textInput addTarget:self action:@selector(endOnExit) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:textInput];
    [textInput release];
    
    [textInput becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[event touchesForView:self.view] count] != 0)
    {
        [self.delegate performSelector:@selector(userCancelInput)];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (NSString *) text
{
    return textInput.text;
}

- (void) endOnExit
{
    [textInput resignFirstResponder];
    
    [self.delegate performSelector:@selector(userDidInput)];
}

@end
