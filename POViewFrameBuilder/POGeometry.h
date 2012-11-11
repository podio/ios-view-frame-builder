//
//  POGeometry.h
//
//  Created by Sebastian Rehnby on 6/1/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

CGRect PORectInsets(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

CGRect PORectFromSize(CGFloat width, CGFloat height);
CGRect PORectWithSize(CGRect rect, CGFloat width, CGFloat height);
CGRect PORectWithWidth(CGRect rect, CGFloat width);
CGRect PORectWithHeight(CGRect rect, CGFloat height);

CGRect PORectWithOrigin(CGRect rect, CGFloat x, CGFloat y);
CGRect PORectWithX(CGRect rect, CGFloat x);
CGRect PORectWithY(CGRect rect, CGFloat y);

CGPoint POPointWithOffset(CGPoint p, CGFloat dx, CGFloat dy);
CGPoint POPointCenterInSize(CGSize s);

CGRect PORectMove(CGRect rect, CGFloat dx, CGFloat dy);