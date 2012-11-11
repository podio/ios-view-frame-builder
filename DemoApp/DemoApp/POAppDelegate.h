//
//  POAppDelegate.h
//  DemoApp
//
//  Created by Sebastian Rehnby on 11/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POViewController;

@interface POAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) POViewController *viewController;

@end
