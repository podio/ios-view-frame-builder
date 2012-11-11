//
//  POViewController.m
//  DemoApp
//
//  Created by Sebastian Rehnby on 11/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "POViewController.h"
#import "UIView+POViewFrameBuilder.h"

static NSTimeInterval kAnimationDuration = 1.0;
static CGFloat kEdgeInset = 10.0f;

@interface POViewController ()

@end

@implementation POViewController

- (void)resetSquareView {
  self.animateButton.enabled = YES;
  [[[[self.squareView.po_frameBuilder disableAutoCommit] setSizeWithWidth:40.0f height:40.0f] centerInSuperview] commit];
}

- (void)animateSquareView {
  self.animateButton.enabled = NO;
  
  [UIView animateWithDuration:kAnimationDuration animations:^{
    // Left and resize
    [[[[self.squareView.po_frameBuilder disableAutoCommit]
      setSizeWithWidth:60.0f height:60.0f]
      alignLeftInSuperviewWithInset:kEdgeInset] commit];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:kAnimationDuration animations:^{
      // Center at top
      [[[[self.squareView.po_frameBuilder disableAutoCommit]
        centerHorizontallyInSuperview]
        alignToTopInSuperviewWithInset:kEdgeInset] commit];
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:kAnimationDuration animations:^{
        // Right
        [self.squareView.po_frameBuilder alignRightInSuperviewWithInset:kEdgeInset];
      } completion:^(BOOL finished) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
          // Bottom
          [self.squareView.po_frameBuilder alignToBottomInSuperviewWithInset:kEdgeInset];
        } completion:^(BOOL finished) {
          [UIView animateWithDuration:kAnimationDuration animations:^{
            // Left
            [self.squareView.po_frameBuilder alignLeftInSuperviewWithInset:kEdgeInset];
          } completion:^(BOOL finished) {
            // Back to the start
            [UIView animateWithDuration:kAnimationDuration animations:^{
              [self resetSquareView];
            } completion:nil];
          }];
        }];
      }];
    }];
  }];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self resetSquareView];
}

- (IBAction)animateButtonPressed {
  [self animateSquareView];
}

@end
