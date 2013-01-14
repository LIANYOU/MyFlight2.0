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
        
        leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftItem.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 5:19, 40, 30);
        
        leftItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        leftItem.layer.borderWidth = 1.0f;
        leftItem.layer.cornerRadius = 10.0f;
        
        leftItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [leftItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [leftItem addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_before_white.png"]];
        
        leftIcon.frame = CGRectMake(0, 0, 40, 30);
        leftIcon.backgroundColor = [UIColor clearColor];
        
        [leftItem addSubview:leftIcon];
        [leftIcon release];
        
        [self addSubview:leftItem];
        
        rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rightItem.frame = CGRectMake(270, [UIScreen mainScreen].bounds.size.height < 500 ? 5:19, 40, 30);
        
        rightItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        rightItem.layer.borderWidth = 1.0f;
        rightItem.layer.cornerRadius = 10.0f;
        
        rightItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [rightItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [rightItem addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_next_white.png"]];
        
        rightIcon.frame = CGRectMake(0, 0, 40, 30);
        rightIcon.backgroundColor = [UIColor clearColor];
        
        [rightItem addSubview:rightIcon];
        [rightIcon release];
        
        [self addSubview:rightItem];
        
        centerItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        centerItem.frame = CGRectMake(105, [UIScreen mainScreen].bounds.size.height < 500 ? 5:19, 110, 30);
        
        centerItem.layer.borderColor = [[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] CGColor];
        centerItem.layer.borderWidth = 1.0f;
        centerItem.layer.cornerRadius = 10.0f;
        
        centerItem.layer.backgroundColor = [[UIColor blackColor] CGColor];
        
        [centerItem addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
        [centerItem addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    [textInput.superview removeFromSuperview];
}

- (void) previous
{
    [self.delegate performSelector:@selector(previousPage)];
}

- (void) search
{
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    exitButton.frame = [UIScreen mainScreen].bounds;
    
    [exitButton addTarget:exitButton action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchDown];
    
    textInput = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 500 ? 203:291, 320, 40)];
    
    textInput.keyboardType = UIKeyboardTypeASCIICapable;
    textInput.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    textInput.textAlignment = UITextAlignmentCenter;
    textInput.textColor = [UIColor blueColor];
    textInput.font = [UIFont systemFontOfSize:40.0f];
    
    textInput.backgroundColor = [UIColor yellowColor];
    
    [textInput addTarget:self action:@selector(userDidInput) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [exitButton addSubview:textInput];
    [textInput release];
    
    [self.superview addSubview:exitButton];
    
    [textInput becomeFirstResponder];
}

- (void) next
{
    [self.delegate performSelector:@selector(nextPage)];
}

- (void) highlight:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
    [sender performSelector:@selector(setBackgroundColor:) withObject:[UIColor blackColor] afterDelay:0.25];
}

@end
