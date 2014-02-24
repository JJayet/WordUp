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
    selectedView = mainView;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([[touch view] isEqual:mainView]) {
         [self shrinkMyView:selectedView withViewToGrow:mainView];
    }
    else if ([[touch view] isEqual:firstView]){
        [self shrinkMyView:selectedView withViewToGrow:firstView];
    }
    else if ([[touch view] isEqual:secondView]) {
        [self shrinkMyView:selectedView withViewToGrow:secondView];
    }
    else if ([[touch view] isEqual:thirdView]) {
        [self shrinkMyView:selectedView withViewToGrow:thirdView];
    }
}

-(void)shrinkMyView:(UIView *)viewToShrink withViewToGrow:(UIView *)viewToGrow  {
    CGFloat desiredSize = 834.0;
    CGFloat reducedSize = 50.0;

    [UIView animateWithDuration:0.7
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{selectedView.transform = CGAffineTransformMakeScale(1, reducedSize/viewToShrink.bounds.size.height);
                         selectedView.transform = CGAffineTransformMakeTranslation(0, 1000);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.7
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{thirdView.transform = CGAffineTransformMakeScale(1, desiredSize/viewToGrow.bounds.size.height);}
                                          completion:nil];
                     }];
    selectedView = viewToGrow;
}
@end
