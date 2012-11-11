//
//  POViewController.h
//  DemoApp
//
//  Created by Sebastian Rehnby on 11/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *squareView;
@property (weak, nonatomic) IBOutlet UIButton *animateButton;

- (IBAction)animateButtonPressed;

@end
