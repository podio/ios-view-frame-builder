//
//  UIView+POViewFrameBuilder.h
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POViewFrameBuilder.h"

@interface UIView (POViewFrameBuilder)

/**
 * Convenience method to return a new frame builder for this view.
 */
- (POViewFrameBuilder *)po_frameBuilder;

@end
