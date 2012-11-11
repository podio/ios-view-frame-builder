# POViewFrameBuilder

POViewFrameBuilder aims to provide a simple way to layout UIViews programatically while maintaining the semantics and readability of the code. It lets you modify a view's frame by chaining a series of readable layout methods. It reduces the amount of frame calculation code and keeps the intent of your layout clear. A handy tool for your average layoutSubviews, animation block etc.

It is by no means complete, but rather contains a number of methods I have happened to need at various occasions. Feedback and pull requests are very welcome.

# Usage

The following two examples give you a brief introduction on how POViewFrameBuilder can be used. Just include the `UIView+POViewFrameBuilder.h` category where you want to use it, and then you can access the `po_frameBuilder` convenience property to instantiate a frame builder for any `UIView` subclass.

Resizing a view:

	[view.po_frameBuilder setWidth:100.0f height:40.0f];

Moving a view to be centered within it's superview:

	[view.po_frameBuilder centerInSuperview];

You can combine these methods to your own liking:

	[[view.po_frameBuilder setWidth:100.0f height:40.0f] centerHorizontallyInSuperview];

# Demo

The DemoApp project shows how POViewFrameBuilder can be used in animation blocks. One thing to note is that by default, the `automaticallyCommitChanges` property is set to `YES`. This means that the frame changes are committed after every modifying method in the chain. However, having multiple frame changes in an animation doesn't work, and the view ends up jumping around. To avoid this, begin the method chain by calling `disableAutoCommit` and finish the series of changes by calling the `commit` method, which will update the view's frame:

	[[[[view.po_frameBuilder disableAutoCommit] setWidth:100.0f height:40.0f] centerHorizontallyInSuperview] commit];