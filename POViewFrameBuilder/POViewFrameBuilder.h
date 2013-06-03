//
//  POViewFrameBuilder.h
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, POViewFrameBuilderDirection) {
  POViewFrameBuilderDirectionRight = 0,
  POViewFrameBuilderDirectionLeft,
  POViewFrameBuilderDirectionUp,
  POViewFrameBuilderDirectionDown,
};

@interface POViewFrameBuilder : NSObject

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic) BOOL automaticallyCommitChanges; // Default is YES

- (id)initWithView:(UIView *)view;

+ (POViewFrameBuilder *)frameBuilderForView:(UIView *)view;

- (void)commit;
- (void)reset;
- (void)update:(void (^)(POViewFrameBuilder *builder))block;

// Configure
- (POViewFrameBuilder *)enableAutoCommit;
- (POViewFrameBuilder *)disableAutoCommit;

// Move
- (POViewFrameBuilder *)setX:(CGFloat)x;
- (POViewFrameBuilder *)setY:(CGFloat)y;
- (POViewFrameBuilder *)setOriginWithX:(CGFloat)x y:(CGFloat)y;

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX;
- (POViewFrameBuilder *)moveWithOffsetY:(CGFloat)offsetY;
- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (POViewFrameBuilder *)centerInSuperview;
- (POViewFrameBuilder *)centerHorizontallyInSuperview;
- (POViewFrameBuilder *)centerVerticallyInSuperview;

- (POViewFrameBuilder *)alignToTopInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignToBottomInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignLeftInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignRightInSuperviewWithInset:(CGFloat)inset;

- (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(UIEdgeInsets)insets;
- (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(UIEdgeInsets)insets;
- (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(UIEdgeInsets)insets;
- (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(UIEdgeInsets)insets;

- (POViewFrameBuilder *)alignToTopOfView:(UIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignToBottomOfView:(UIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignLeftOfView:(UIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignRightOfView:(UIView *)view offset:(CGFloat)offset;

+ (void)alignViews:(NSArray *)views direction:(POViewFrameBuilderDirection)direction spacing:(CGFloat)spacing;
+ (void)alignViews:(NSArray *)views direction:(POViewFrameBuilderDirection)direction spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;

+ (void)alignViewsVertically:(NSArray *)views spacing:(CGFloat)spacing;
+ (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;
+ (void)alignViewsHorizontally:(NSArray *)views spacing:(CGFloat)spacing;
+ (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views spacing:(CGFloat)spacing;
+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views constrainedToWidth:(CGFloat)constrainedWidth spacing:(CGFloat)spacing;
+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views constrainedToWidth:(CGFloat)constrainedWidth spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;

// Resize
- (POViewFrameBuilder *)setWidth:(CGFloat)width;
- (POViewFrameBuilder *)setHeight:(CGFloat)height;
- (POViewFrameBuilder *)setSize:(CGSize)size;
- (POViewFrameBuilder *)setSizeWithWidth:(CGFloat)width height:(CGFloat)height;
- (POViewFrameBuilder *)setSizeToFitWidth;
- (POViewFrameBuilder *)setSizeToFitHeight;
- (POViewFrameBuilder *)setSizeToFit;

+ (void)sizeToFitViews:(NSArray *)views;

@end
