//
//  JJViewController.m
//  Word Up!
//
//  Created by Jonathan Jayet on 23/02/2014.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "JJViewController.h"
#import "JJTranslatorViewController.h"
#import "JJVocalViewController.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface JJViewController ()

@end

@implementation JJViewController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willAttendForTouchNotications:) name:@"TouchNotificationHasArrived" object:nil];

    [mainView setTag:1];
    [firstView setTag:2];
    [secondView setTag:3];
    [thirdView setTag:4];
    reducedSize = 50.0;
    selectedView = mainView;
    [super viewDidLoad];
}

-(void)willAttendForTouchNotications:(NSNotification *)notification {
    if ([[notification object] isKindOfClass:[JJTranslatorViewController class]]) {
        [self changeSelectedView:mainView];
    }
    else if ([[notification object] isKindOfClass:[JJVocalViewController class]]) {
        [self changeSelectedView:firstView];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self addLabelForView:mainView withAlpha:0];
    [self addLabelForView:firstView withAlpha:1];
    [self addLabelForView:secondView withAlpha:1];
    [self addLabelForView:thirdView withAlpha:1];
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [self doRotationOperation];
    [super viewDidAppear:animated];
}
-(void)changeSelectedView:(UIView *)newSelectedView  {
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ [self doViewOperation:newSelectedView]; }
                     completion:nil];
    selectedView = newSelectedView;
}

-(void)doViewOperation:(UIView *)newSelectedView {
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    CGFloat axis = 0;
    if (isPortrait)
        axis = 20;
    for (UIView *view in [[self view] subviews]) {
        if (view.tag == 0)
            continue;
        if (isPortrait) {
            view.frame = CGRectMake(0, axis, view.frame.size.width, [view isEqual:newSelectedView] ? [self getDesiredSize] : reducedSize);
            axis = view.frame.origin.y + view.frame.size.height;
        }
        else {
            view.frame = CGRectMake(axis, 20, ([view isEqual:newSelectedView] ? [self getDesiredSize] : reducedSize), view.frame.size.height);
            axis = view.frame.origin.x + view.frame.size.width;
        }
        
        if ([view isEqual:selectedView])
        {
            for (UILabel *label in [[[view subviews] firstObject] subviews]) {
                if (label.tag == 777) {
                    label.alpha = 1;
                    break;
                }
            }
        }
        if ([view isEqual:newSelectedView]){
            for (UILabel *label in [[[view subviews] firstObject] subviews]) {
                if (label.tag == 777) {
                    label.alpha = 0;
                    break;
                }
            }
        }
    }
}

-(void)addLabelForView:(UIView *)aView withAlpha:(CGFloat)alpha {
    UIView *view = ((UIView *)[[aView subviews] firstObject]);
    if (view == nil)
        return;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, reducedSize)];
    [label setText:view.accessibilityLabel];
    [label setTag:777];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setAlpha:alpha];
    [view addSubview:label];
}

-(CGFloat)getDesiredSize {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height - (UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? 20 : 0) - 3 * reducedSize;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self doRotationOperation];
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)doRotationOperation {
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    CGFloat axis = 0;
    if (isPortrait)
        axis = 20;
    for (UIView *view in [[self view] subviews]) {
        if (view.tag == 0)
            continue;
        if(isPortrait) {
            view.frame = CGRectMake(0, axis, view.frame.size.width, [view isEqual:selectedView] ? [self getDesiredSize] : reducedSize);
            axis = view.frame.origin.y + view.frame.size.height;
        }
        else {
            view.frame = CGRectMake(axis, 20, ([view isEqual:selectedView] ? [self getDesiredSize] : reducedSize), view.frame.size.width);
            axis = view.frame.origin.x + view.frame.size.width;
        }
        for (UILabel *label in [[[view subviews] firstObject] subviews]) {
            if (label.tag == 777) {
                if (isPortrait) {
                    label.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(360));
                    label.frame = CGRectMake(0, 0, view.frame.size.width, reducedSize);
                }
                else {
                    label.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
                    label.frame = CGRectMake(0, 0, reducedSize, view.frame.size.height);
                }
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
