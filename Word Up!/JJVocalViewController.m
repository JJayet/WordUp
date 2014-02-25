//
//  JJVocalViewController.m
//  Word Up!
//
//  Created by Jonathan Jayet on 25/02/2014.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "JJVocalViewController.h"

@interface JJVocalViewController ()

@end

@implementation JJVocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TouchNotificationHasArrived" object:self];
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShrink:) name:@"TimeToShrink" object:nil];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)willShrink:(NSNotification *)notification {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
