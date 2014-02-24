//
//  JJViewController.h
//  Word Up!
//
//  Created by Jonathan Jayet on 23/02/2014.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJViewController : UIViewController {
    CGFloat reducedSize;

    UIView *selectedView;
    IBOutlet UIView *mainView;
    IBOutlet UIView *firstView;
    IBOutlet UIView *secondView;
    IBOutlet UIView *thirdView;
}

@end
