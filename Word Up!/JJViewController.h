//
//  JJViewController.h
//  Word Up!
//
//  Created by Jonathan Jayet on 23/02/2014.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTranslatorViewController.h"

@interface JJViewController : UIViewController {
    CGFloat reducedSize;

    UIView *selectedView;
    IBOutlet UIView *translatorView;
    IBOutlet UIView *voiceView;
    IBOutlet UIView *ocrView;
    IBOutlet UIView *settingsView;
}

@end
