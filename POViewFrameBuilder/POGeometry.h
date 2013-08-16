//
//  POGeometry.h
//
//  Created by Sebastian Rehnby on 6/1/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline CGRect PORectInsets(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
  return UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(top, left, bottom, right));
}

static inline CGRect PORectWithSize(CGRect rect, CGFloat width, CGFloat height) {
  rect.size.width = width;
  rect.size.height = height;
  
  return rect;
}

static inline CGRect PORectFromSize(CGFloat width, CGFloat height) {
  return PORectWithSize(CGRectZero, width, height);
}

static inline CGRect PORectWithWidth(CGRect rect, CGFloat width) {
  rect.size.width = width;
  
  return rect;
}

static inline CGRect PORectWithHeight(CGRect rect, CGFloat height) {
  rect.size.height = height;
  
  return rect;
}

static inline CGRect PORectWithOrigin(CGRect rect, CGFloat x, CGFloat y) {
  rect.origin.x = x;
  rect.origin.y = y;
  
  return rect;
}

static inline CGRect PORectWithX(CGRect rect, CGFloat x) {
  rect.origin.x = x;
  
  return rect;
}

static inline CGRect PORectWithY(CGRect rect, CGFloat y) {
  rect.origin.y = y;
  
  return rect;
}

static inline CGPoint POPointWithOffset(CGPoint p, CGFloat dx, CGFloat dy) {
  return CGPointMake(p.x + dx, p.y + dy);
}

static inline CGPoint POPointCenterInSize(CGSize s) {
  return CGPointMake(roundf(s.width / 2), roundf(s.height / 2));
}

static inline CGPoint POPointIntegral(CGPoint point) {
  point.x = floorf(point.x);
  point.y = floorf(point.y);
  return point;
}

static inline CGPoint PORectCenter(CGRect rect) {
  return POPointIntegral((CGPoint){
    .x = CGRectGetMidX(rect),
    .y = CGRectGetMidY(rect)
  });
}

static inline CGRect PORectMove(CGRect rect, CGFloat dx, CGFloat dy) {
  rect.origin.x += dx;
  rect.origin.y += dy;
  
  return rect;
}

static inline CGSize POEdgeInsetsInsetSize(CGSize size, UIEdgeInsets insets) {
  size.width  -= (insets.left + insets.right);
  size.height -= (insets.top  + insets.bottom);
  return size;
}

static inline UIEdgeInsets POEdgeInsetsUnion(UIEdgeInsets insets1, UIEdgeInsets insets2) {
  insets1.top    += insets2.top;
  insets1.left   += insets2.left;
  insets1.bottom += insets2.bottom;
  insets1.right  += insets2.right;
  return insets1;
}
