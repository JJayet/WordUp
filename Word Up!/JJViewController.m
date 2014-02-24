//
//  JJViewController.m
//  Word Up!
//
//  Created by Jonathan Jayet on 23/02/2014.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "JJViewController.h"

@interface JJViewController ()

@end

@implementation JJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [mainView setTag:1];
    [firstView setTag:2];
    [secondView setTag:3];
    [thirdView setTag:4];
    reducedSize = 50.0;
    selectedView = mainView;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([[touch view] isEqual:selectedView]) {
        return;
    }
    [self changeSelectedView:[touch view]];
}

-(void)changeSelectedView:(UIView *)newSelectedView  {
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
                             CGFloat yAxis = 20;
                             for (UIView *view in [[self view] subviews]) {
                                 if (view.tag == 0)
                                     continue;
                                 view.frame = CGRectMake(0, yAxis, view.frame.size.width, [view isEqual:newSelectedView] ? [self getDesiredSize] : reducedSize);
                                 yAxis = view.frame.origin.y + view.frame.size.height;
                                 if ([view isEqual:selectedView])
                                 {
                                     UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                                     label.text = view.accessibilityLabel;
                                     [label setTextColor:[UIColor blackColor]];
                                     [label setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
                                     [label setTextAlignment:NSTextAlignmentCenter];
                                     [view addSubview:label];
                                 }
                                 if ([view isEqual:newSelectedView]){
                                     for (UILabel *label in [view subviews]) {
                                         label.alpha = 0;
                                     }
                                 }
                             }
                         }
                         else {
                             CGFloat xAxis = 0;
                             for (UIView *view in [[self view] subviews]) {
                                 if (view.tag == 0)
                                     continue;
                                 
                                 view.frame = CGRectMake(xAxis, 20, ([view isEqual:newSelectedView] ? [self getDesiredSize] : reducedSize), view.frame.size.height);
                                 xAxis = view.frame.origin.x + view.frame.size.width;
                                 
                             }
                         }
                     }
                     completion:nil];
    selectedView = newSelectedView;
}

-(CGFloat)getDesiredSize {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height - (UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? 20 : 0) - 3 * reducedSize;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        CGFloat yAxis = 20;
        for (UIView *view in [[self view] subviews]) {
            if (view.tag == 0)
                continue;
            
            view.frame = CGRectMake(0, yAxis, view.frame.size.width, [view isEqual:selectedView] ? [self getDesiredSize] : reducedSize);
            yAxis = view.frame.origin.y + view.frame.size.height;
        }
    }
    else {
        CGFloat xAxis = 0;
        for (UIView *view in [[self view] subviews]) {
            if (view.tag == 0)
                continue;

            view.frame = CGRectMake(xAxis, 20, ([view isEqual:selectedView] ? [self getDesiredSize] : reducedSize), view.frame.size.width);
            xAxis = view.frame.origin.x + view.frame.size.width;

        }
    }
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
