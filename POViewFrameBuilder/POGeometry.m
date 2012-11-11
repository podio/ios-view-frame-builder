//
//  POGeometry.m
//
//  Created by Sebastian Rehnby on 6/1/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POGeometry.h"

CGRect PORectInsets(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
  return UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(top, left, bottom, right));
}

CGRect PORectFromSize(CGFloat width, CGFloat height) {
  return PORectWithSize(CGRectZero, width, height);
}

CGRect PORectWithSize(CGRect rect, CGFloat width, CGFloat height) {
  rect.size.width = width;
  rect.size.height = height;
  
  return rect;
}

CGRect PORectWithWidth(CGRect rect, CGFloat width) {
  rect.size.width = width;
  
  return rect;
}

CGRect PORectWithHeight(CGRect rect, CGFloat height) {
  rect.size.height = height;
  
  return rect;
}

CGRect PORectWithOrigin(CGRect rect, CGFloat x, CGFloat y) {
  rect.origin.x = x;
  rect.origin.y = y;
  
  return rect;
}

CGRect PORectWithX(CGRect rect, CGFloat x) {
  rect.origin.x = x;

  return rect;
}

CGRect PORectWithY(CGRect rect, CGFloat y) {
  rect.origin.y = y;
  
  return rect;
}

CGPoint POPointWithOffset(CGPoint p, CGFloat dx, CGFloat dy) {
  return CGPointMake(p.x + dx, p.y + dy);
}

CGPoint POPointCenterInSize(CGSize s) {
  return CGPointMake(floorf(s.width / 2), floorf(s.height / 2));
}

CGRect PORectMove(CGRect rect, CGFloat dx, CGFloat dy) {
  rect.origin.x += dx;
  rect.origin.y += dy;
  
  return rect;
}