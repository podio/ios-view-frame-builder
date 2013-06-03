//
//  POViewFrameBuilder.m
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "POViewFrameBuilder.h"
#import "POGeometry.h"

// We define NS_ENUM in case we build for iOS 5
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

typedef NS_ENUM(NSUInteger, POViewFrameBuilderEdge) {
  POViewFrameBuilderEdgeTop,
  POViewFrameBuilderEdgeBottom,
  POViewFrameBuilderEdgeLeft,
  POViewFrameBuilderEdgeRight,
};

@interface POViewFrameBuilder ()

@property (nonatomic) CGRect frame;

@end

@implementation POViewFrameBuilder

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _view = view;
    _frame = view.frame;
    _automaticallyCommitChanges = YES;
  }
  return self;
}

+ (POViewFrameBuilder *)frameBuilderForView:(UIView *)view {
  return [[[self class] alloc] initWithView:view];
}

#pragma mark - Properties

- (void)setFrame:(CGRect)frame {
  _frame = frame;

  if (self.automaticallyCommitChanges) {
    [self commit];
  }
}

#pragma mark - Impl

- (void)commit {
  self.view.frame = self.frame;
}

- (void)reset {
  self.frame = self.view.frame;
}

- (void)update:(void (^)(POViewFrameBuilder *builder))block {
    [self disableAutoCommit];
    block(self);
    [self commit];
}

- (POViewFrameBuilder *)performChangesInGroupWithBlock:(void (^)(void))block {
  BOOL automaticCommitEnabled = self.automaticallyCommitChanges;

  self.automaticallyCommitChanges = NO;
  block();
  self.automaticallyCommitChanges = automaticCommitEnabled;

  if (self.automaticallyCommitChanges) {
    [self commit];
  }

  return self;
}

#pragma mark - Configure

- (POViewFrameBuilder *)enableAutoCommit {
  self.automaticallyCommitChanges = YES;

  return self;
}

- (POViewFrameBuilder *)disableAutoCommit {
  self.automaticallyCommitChanges = NO;

  return self;
}

#pragma mark - Move

- (POViewFrameBuilder *)setX:(CGFloat)x {
  self.frame = PORectWithX(self.frame, x);

  return self;
}

- (POViewFrameBuilder *)setY:(CGFloat)y {
  self.frame = PORectWithY(self.frame, y);

  return self;
}

- (POViewFrameBuilder *)setOriginWithX:(CGFloat)x y:(CGFloat)y {
  return [self performChangesInGroupWithBlock:^{
    [[self setX:x] setY:y];
  }];
}

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX {
  self.frame = PORectWithX(self.frame, self.frame.origin.x + offsetX);

  return self;
}

- (POViewFrameBuilder *)moveWithOffsetY:(CGFloat)offsetY {
  self.frame = PORectWithY(self.frame, self.frame.origin.y + offsetY);

  return self;
}

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
  return [self performChangesInGroupWithBlock:^{
    [[self moveWithOffsetX:offsetX] moveWithOffsetY:offsetY];
  }];
}

- (POViewFrameBuilder *)centerInSuperview {
  return [self performChangesInGroupWithBlock:^{
    [[self centerHorizontallyInSuperview] centerVerticallyInSuperview];
  }];
}

- (POViewFrameBuilder *)centerHorizontallyInSuperview {
  if (!self.view.superview) {
    return self;
  }

  self.frame = PORectWithX(self.frame, roundf((self.view.superview.bounds.size.width - self.frame.size.width) / 2));

  return self;
}

- (POViewFrameBuilder *)centerVerticallyInSuperview {
  if (!self.view.superview) {
    return self;
  }

  self.frame = PORectWithY(self.frame, roundf((self.view.superview.bounds.size.height - self.frame.size.height) / 2));

  return self;
}

- (POViewFrameBuilder *)alignToTopInSuperviewWithInset:(CGFloat)inset {
  [self alignToTopInSuperviewWithInsets:UIEdgeInsetsMake(inset, 0.0f, 0.0f, 0.0f)];

  return self;
}

- (POViewFrameBuilder *)alignToBottomInSuperviewWithInset:(CGFloat)inset {
  [self alignToBottomInSuperviewWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, inset, 0.0f)];

  return self;
}

- (POViewFrameBuilder *)alignLeftInSuperviewWithInset:(CGFloat)inset {
  [self alignLeftInSuperviewWithInsets:UIEdgeInsetsMake(0.0f, inset, 0.0f, 0.0f)];

  return self;

}

- (POViewFrameBuilder *)alignRightInSuperviewWithInset:(CGFloat)inset {
  [self alignRightInSuperviewWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, inset)];

  return self;
}

- (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(UIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.frame.origin.x + insets.left - insets.right,
                                insets.top - insets.bottom);

  return self;
}

- (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(UIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.frame.origin.x + insets.left - insets.right,
                                self.view.superview.bounds.size.height - self.frame.size.height + insets.top - insets.bottom);

  return self;
}

- (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(UIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                insets.left - insets.right,
                                self.frame.origin.y + insets.top - insets.bottom);

  return self;
}

- (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(UIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.view.superview.bounds.size.width - self.frame.size.width + insets.left - insets.right,
                                self.frame.origin.y + insets.top - insets.bottom);

  return self;
}

- (POViewFrameBuilder *)alignToView:(UIView *)view edge:(POViewFrameBuilderEdge)edge offset:(CGFloat)offset {
  CGRect viewFrame = [view.superview convertRect:view.frame toView:self.view.superview];

  switch (edge) {
    case POViewFrameBuilderEdgeTop:
      self.frame = PORectWithY(self.frame, viewFrame.origin.y - offset - self.frame.size.height);
      break;
    case POViewFrameBuilderEdgeBottom:
      self.frame = PORectWithY(self.frame, CGRectGetMaxY(viewFrame) + offset);
      break;
    case POViewFrameBuilderEdgeLeft:
      self.frame = PORectWithX(self.frame, viewFrame.origin.x - offset - self.frame.size.width);
      break;
    case POViewFrameBuilderEdgeRight:
      self.frame = PORectWithX(self.frame, CGRectGetMaxX(viewFrame) + offset);
      break;
    default:
      break;
  }

  return self;
}

- (POViewFrameBuilder *)alignToTopOfView:(UIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeTop offset:offset];
}

- (POViewFrameBuilder *)alignToBottomOfView:(UIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeBottom offset:offset];
}

- (POViewFrameBuilder *)alignLeftOfView:(UIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeLeft offset:offset];
}

- (POViewFrameBuilder *)alignRightOfView:(UIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeRight offset:offset];
}

+ (void)alignViews:(NSArray *)views direction:(POViewFrameBuilderDirection)direction spacing:(CGFloat)spacing {
  return [self alignViews:views direction:direction spacingWithBlock:^CGFloat(UIView *firstView, UIView *secondView) {
    return spacing;
  }];;
}

+ (void)alignViews:(NSArray *)views direction:(POViewFrameBuilderDirection)direction spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block {
  UIView *previousView = nil;
  for (UIView *view in views) {
    if (previousView) {
      CGFloat spacing = block != nil ? block(previousView, view) : 0.0f;
      
      switch (direction) {
        case POViewFrameBuilderDirectionRight:
          [[[self alloc] initWithView:view] alignRightOfView:previousView offset:spacing];
          break;
        case POViewFrameBuilderDirectionLeft:
          [[[self alloc] initWithView:view] alignLeftOfView:previousView offset:spacing];
          break;
        case POViewFrameBuilderDirectionUp:
          [[[self alloc] initWithView:view] alignToTopOfView:previousView offset:spacing];
          break;
        case POViewFrameBuilderDirectionDown:
          [[[self alloc] initWithView:view] alignToBottomOfView:previousView offset:spacing];
          break;
        default:
          break;
      }
    }
    
    previousView = view;
  }
}

+ (void)alignViewsVertically:(NSArray *)views spacing:(CGFloat)spacing {
  [self alignViewsVertically:views spacingWithBlock:^CGFloat(UIView *firstView, UIView *secondView) {
    return spacing;
  }];
}

+ (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block {
  [self alignViews:views direction:POViewFrameBuilderDirectionDown spacingWithBlock:block];
}

+ (void)alignViewsHorizontally:(NSArray *)views spacing:(CGFloat)spacing {
  [self alignViewsHorizontally:views spacingWithBlock:^CGFloat(UIView *firstView, UIView *secondView) {
    return spacing;
  }];
}

+ (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block {
  [self alignViews:views direction:POViewFrameBuilderDirectionRight spacingWithBlock:block];
}

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views spacing:(CGFloat)spacing {
  return [self heightForViewsAlignedVertically:views constrainedToWidth:0.0f spacing:spacing];
}

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block {
  return [self heightForViewsAlignedVertically:views constrainedToWidth:0.0f spacingWithBlock:block];
}

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views constrainedToWidth:(CGFloat)constrainedWidth spacing:(CGFloat)spacing {
  return [self heightForViewsAlignedVertically:views constrainedToWidth:constrainedWidth spacingWithBlock:^CGFloat(UIView *firstView, UIView *secondView) {
    return spacing;
  }];
}

+ (CGFloat)heightForViewsAlignedVertically:(NSArray *)views constrainedToWidth:(CGFloat)constrainedWidth spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block {
  CGFloat height = 0.0f;
  
  UIView *previousView = nil;
  for (UIView *view in views) {
    if (constrainedWidth > FLT_EPSILON) {
      height += [view sizeThatFits:CGSizeMake(constrainedWidth, CGFLOAT_MAX)].height;
    } else {
      height += view.bounds.size.height;
    }
    
    if (previousView) {
      height += block != nil ? block(previousView, view) : 0.0f;
    }
    
    previousView = view;
  }
  
  return height;
}

#pragma mark - Resize

- (POViewFrameBuilder *)setWidth:(CGFloat)width {
  self.frame = PORectWithWidth(self.frame, width);

  return self;
}

- (POViewFrameBuilder *)setHeight:(CGFloat)height {
  self.frame = PORectWithHeight(self.frame, height);

  return self;
}

- (POViewFrameBuilder *)setSize:(CGSize)size {
  self.frame = PORectWithSize(self.frame, size.width, size.height);

  return self;
}

- (POViewFrameBuilder *)setSizeWithWidth:(CGFloat)width height:(CGFloat)height {
  return [self performChangesInGroupWithBlock:^{
    [[self setWidth:width] setHeight:height];
  }];
}

- (POViewFrameBuilder *)setSizeToFitWidth {
  CGRect frame = self.frame;
  frame.size.width = [self.view sizeThatFits:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
  self.frame = frame;

  return self;
}

- (POViewFrameBuilder *)setSizeToFitHeight {
  CGRect frame = self.frame;
  frame.size.height = [self.view sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].height;
  self.frame = frame;

  return self;
}

- (POViewFrameBuilder *)setSizeToFit {
  CGSize size = [self.view sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  
  CGRect frame = self.frame;
  frame.size.height = size.height;
  frame.size.width = size.width;
  self.frame = frame;
  
  return self;
}

+ (void)sizeToFitViews:(NSArray *)views {
  for (UIView *view in views) {
    [view sizeToFit];
  }
}

@end
