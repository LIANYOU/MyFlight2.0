//
//  AirportMainScreenSearchView.m
//  MyFlight2.0
//
//  Created by apple on 12-12-30.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AirportMainScreenSearchView.h"

@implementation AirportMainScreenSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        leftItem = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
        
        leftItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        leftItem.layer.borderWidth = 1.0f;
        leftItem.layer.cornerRadius = 10.0f;
        
        leftItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        leftIcon.frame = CGRectMake(0, 0, 40, 30);
        leftIcon.backgroundColor = [UIColor clearColor];
        
        [leftItem addSubview:leftIcon];
        [leftIcon release];
        
        [self addSubview:leftItem];
        [leftItem release];
        
        rightItem = [[UIView alloc] initWithFrame:CGRectMake(270, 10, 40, 30)];
        
        rightItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        rightItem.layer.borderWidth = 1.0f;
        rightItem.layer.cornerRadius = 10.0f;
        
        rightItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_next_white.png"]];
        
        rightIcon.frame = CGRectMake(0, 0, 40, 30);
        rightIcon.backgroundColor = [UIColor clearColor];
        
        [rightItem addSubview:rightIcon];
        [rightIcon release];
        
        [self addSubview:rightItem];
        [rightItem release];
        
        centerItem = [[UIView alloc] initWithFrame:CGRectMake(105, 10, 110, 30)];
        
        centerItem.layer.borderColor = [[UIColor whiteColor] CGColor];
        centerItem.layer.borderWidth = 1.0f;
        centerItem.layer.cornerRadius = 10.0f;
        
        centerItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        UIImageView *search = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_search.png"]];
        
        search.frame = CGRectMake(0, 0, 110, 30);
        search.backgroundColor = [UIColor clearColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 85, 30)];
        
        title.text = @"检索航班";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:15.0f];
        title.backgroundColor = [UIColor clearColor];
        
        [search addSubview:title];
        [title release];
        
        [centerItem addSubview:search];
        [search release];
        
        [self addSubview:centerItem];
        [centerItem release];
        
        [self setLeftIconInvisible];
        [self setRightIconInvisible];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setLeftIconVisible
{
    leftItem.hidden = NO;
}

- (void) setLeftIconInvisible
{
    leftItem.hidden = YES;
}

- (void) setRightIconVisible
{
    rightItem.hidden = NO;
}

- (void) setRightIconInvisible
{
    rightItem.hidden = YES;
}

- (void) userDidInput
{
    [self.delegate performSelector:@selector(search:) withObject:textInput.text];
    
    [textInput removeFromSuperview];
    
    centerItem.hidden = NO;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *leftTouches = [event touchesForView:leftItem];
    NSSet *rightTouches = [event touchesForView:rightItem];
    NSSet *centerTouches = [event touchesForView:centerItem];
    
    if([leftTouches count] != 0)
    {
        [self.delegate performSelector:@selector(previousPage)];
    }
    else if([rightTouches count] != 0)
    {
        [self.delegate performSelector:@selector(nextPage)];
    }
    else if([centerTouches count] != 0)
    {
        centerItem.hidden = YES;
        
        textInput = [[UITextField alloc] initWithFrame:CGRectMake(0, 150, 320, 50)];
        
        textInput.keyboardType = UIKeyboardTypeASCIICapable;
        textInput.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        textInput.textAlignment = UITextAlignmentCenter;
        textInput.textColor = [UIColor whiteColor];
        textInput.font = [UIFont systemFontOfSize:50.0f];
        
        [textInput addTarget:self action:@selector(userDidInput) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        [self.superview addSubview:textInput];
        [textInput release];
        
        [textInput becomeFirstResponder];
    }
}

@end
