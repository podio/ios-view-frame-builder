//
//  POGeometry.h
//
//  Created by Sebastian Rehnby on 6/1/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

extern inline CGRect PORectInsets(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

extern inline CGRect PORectFromSize(CGFloat width, CGFloat height);
extern inline CGRect PORectWithSize(CGRect rect, CGFloat width, CGFloat height);
extern inline CGRect PORectWithWidth(CGRect rect, CGFloat width);
extern inline CGRect PORectWithHeight(CGRect rect, CGFloat height);

extern inline CGRect PORectWithOrigin(CGRect rect, CGFloat x, CGFloat y);
extern inline CGRect PORectWithX(CGRect rect, CGFloat x);
extern inline CGRect PORectWithY(CGRect rect, CGFloat y);

extern inline CGPoint POPointWithOffset(CGPoint p, CGFloat dx, CGFloat dy);
extern inline CGPoint POPointCenterInSize(CGSize s);

extern inline CGRect PORectMove(CGRect rect, CGFloat dx, CGFloat dy);