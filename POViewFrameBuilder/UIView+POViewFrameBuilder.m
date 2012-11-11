//
//  UIView+POViewFrameBuilder.m
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "UIView+POViewFrameBuilder.h"

@implementation UIView (POViewFrameBuilder)

- (POViewFrameBuilder *)po_frameBuilder {
  return [POViewFrameBuilder frameBuilderForView:self];
}

@end
