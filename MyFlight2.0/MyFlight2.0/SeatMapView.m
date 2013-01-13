//
//  SeatMapView.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SeatMapView.h"

@implementation SeatMapView

@synthesize sectionX;
@synthesize sectionY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        selectionX = -1;
        selectionY = -1;
        
        emergencyExit = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"e1" ofType:@"png"]];
        available = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seat1" ofType:@"png"]];
        occupied = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_seat" ofType:@"png"]];
        selected = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pitch_on" ofType:@"png"]];
        
        lastSelection = nil;
    }
    return self;
}

- (void) drawSeatMap:(NSDictionary *) seatMap
{
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    NSInteger i = 0;
    NSInteger j = 0;
    
    NSString *cabinType = [NSString stringWithFormat:@"column%@", [seatMap objectForKey:@"baseCabin"]];
    
    NSArray *stringArray = [[seatMap objectForKey:cabinType] objectForKey:@"string"];
    
    [map release];
    map = [seatMap retain];
    
    NSArray *rowArray = [[map objectForKey:@"row"] objectForKey:@"_int"];
    
    NSArray *seatsArray = [[map objectForKey:@"seats"] objectForKey:@"arrayOfXsdString"];
    
    for(i = 0; i < sectionY; i++)
    {
        NSNumber *value = [rowArray objectAtIndex:i];
        
        if(value.intValue != 0)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * 30, 30, 30)];
            
            label.text = [NSString stringWithFormat:@"%d", value.intValue];
            
            label.textColor = FONT_COLOR_DEEP_GRAY;
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:20.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [self addSubview:label];
            [label release];
        }
    }
    
    availableCount = 0;
    
    for(i = 0; i < sectionY; i++)
    {
        NSArray *string = [[seatsArray objectAtIndex:i] objectForKey:@"string"];
        
        NSNumber *type = [rowArray objectAtIndex:i];
        
        for(j = 0; j < sectionX; j++)
        {
            NSString *value = [string objectAtIndex:j];
            
            if(type.intValue == 0)
            {
            }
            else
            {
                switch([value characterAtIndex:0])
                {
                    case '.':
                        break;
                    case '*':
                        availableCount++;
                        break;
                    case ':':
                        break;
                    case '=':
                        break;
                    case '/':
                        break;
                    case '+':
                        break;
                    case 'E':
                        break;
                    case 'I':
                        break;
                    case 'Q':
                        break;
                    case 'X':
                        break;
                    case 'T':
                        break;
                    case 'V':
                        break;
                    case 'D':
                        break;
                    case 'C':
                        break;
                    case 'P':
                        break;
                    case 'R':
                        break;
                    case 'O':
                        break;
                    case 'A':
                        break;
                    case 'B':
                        break;
                    case 'N':
                        break;
                    case 'U':
                        break;
                    case 'G':
                        break;
                    case 'H':
                        break;
                    case '>':
                        break;
                    case 'L':
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    for(i = 0; i < sectionY; i++)
    {
        NSArray *string = [[seatsArray objectAtIndex:i] objectForKey:@"string"];
        
        NSNumber *type = [rowArray objectAtIndex:i];
        
        for(j = 0; j < sectionX; j++)
        {
            NSString *value = [string objectAtIndex:j];
            
            if(type.intValue == 0)
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((j + 1) * 30, i * 30, 30, 30)];
                
                label.text = value;
                
                label.textColor = [UIColor blueColor];
                label.textAlignment = UITextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:20.0f];
                label.backgroundColor = [UIColor clearColor];
                
                [self addSubview:label];
                [label release];
            }
            else
            {
                UIButton *button;
                UIImageView *image;
                UIView *aisle;
                
                switch([value characterAtIndex:0])
                {
                    case '.':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case '*':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                            [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case ':':
                        break;
                    case '=':
                        aisle = [[UIView alloc] initWithFrame:CGRectMake((j + 1) * 30 + 11.5, i * 30 + 1.5, 3, 12)];
                        aisle.backgroundColor = [UIColor lightGrayColor];
                        [self addSubview:aisle];
                        [aisle release];
                        aisle = [[UIView alloc] initWithFrame:CGRectMake((j + 1) * 30 + 16.5, i * 30 + 1.5, 3, 12)];
                        aisle.backgroundColor = [UIColor lightGrayColor];
                        [self addSubview:aisle];
                        [aisle release];
                        aisle = [[UIView alloc] initWithFrame:CGRectMake((j + 1) * 30 + 11.5, i * 30 + 16.5, 3, 12)];
                        aisle.backgroundColor = [UIColor lightGrayColor];
                        [self addSubview:aisle];
                        [aisle release];
                        aisle = [[UIView alloc] initWithFrame:CGRectMake((j + 1) * 30 + 16.5, i * 30 + 16.5, 3, 12)];
                        aisle.backgroundColor = [UIColor lightGrayColor];
                        [self addSubview:aisle];
                        [aisle release];
                        break;
                    case '/':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case '+':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'E':
                        image = [[UIImageView alloc] initWithImage:emergencyExit];
                        image.frame = CGRectMake((j + 1) * 30 + 11.75f, i * 30 + 9.25f, 6.5f, 11.5f);
                        [self addSubview:image];
                        [image release];
                        break;
                    case 'I':
                        break;
                    case 'Q':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case 'X':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'T':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'V':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'D':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'C':
                        if(availableCount == 0)
                        {
                            button = [UIButton buttonWithType:UIButtonTypeCustom];
                            button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                            [button setBackgroundImage:available forState:UIControlStateNormal];
                            [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                            [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                            [self addSubview:button];
                        }
                        else
                        {
                            button = [UIButton buttonWithType:UIButtonTypeCustom];
                            button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                            [button setBackgroundImage:occupied forState:UIControlStateNormal];
                            [self addSubview:button];
                        }
                        break;
                    case 'P':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'R':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'O':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'A':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'B':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case 'N':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case 'U':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case 'G':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'H':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    case '>':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:occupied forState:UIControlStateNormal];
                        [self addSubview:button];
                        break;
                    case 'L':
                        button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake((j + 1) * 30 + 4, i * 30 + 4, 22, 22);
                        [button setBackgroundImage:available forState:UIControlStateNormal];
                        [button setTitle:[NSString stringWithFormat:@"%d%@", type.intValue, [stringArray objectAtIndex:j]] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:button];
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) click:(UIButton *)sender
{
    if(lastSelection != nil)
    {
        if(lastSelection != sender)
        {
            [lastSelection setBackgroundImage:available forState:UIControlStateNormal];
            [sender setBackgroundImage:selected forState:UIControlStateNormal];
            lastSelection = sender;
        }
        else
        {
            [lastSelection setBackgroundImage:available forState:UIControlStateNormal];
            lastSelection = nil;
        }
    }
    else
    {
        [sender setBackgroundImage:selected forState:UIControlStateNormal];
        lastSelection = sender;
    }
}

- (NSString *) currentSelected
{
    if(lastSelection == nil)
    {
        return nil;
    }
    else
    {
        return lastSelection.currentTitle;
    }
}

- (void) dealloc
{
    [emergencyExit release];
    [selected release];
    [available release];
    [occupied release];
    
    [map release];
    
    [super dealloc];
}

@end
