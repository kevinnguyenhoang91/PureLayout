//
//  ALiOSDemoView.m
//  PureLayout
//
//  Created by Kha Nguyen Hoang on 3/6/15.
//
//

#import "ALiOSDemoView.h"

#import "PureLayout.h"

@interface ALiOSDemoView ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation ALiOSDemoView

- (instancetype)initForAutoLayout {
    if (self = [super initForAutoLayout]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0f;
        
        [self addSubview:self.blueView];
        [self addSubview:self.redView];
        [self addSubview:self.yellowView];
        [self addSubview:self.greenView];
        
        [self setNeedsUpdateConstraints]; // bootstrap Auto Layout
    }
    
    return self;
}

- (void)updateConstraints {
    
    // Check a flag didSetupConstraints before creating constraints, because this method may be called multiple times, and we
    // only want to create these constraints once. Without this check, the same constraints could be added multiple times,
    // which can hurt performance and cause other issues. See Demo 7 (Animation) for an example of code that runs every time.
    if (!self.didSetupConstraints) {
        // Blue view is centered on screen, with size {50 pt, 50 pt}
        [self.blueView autoCenterInSuperview];
        [self.blueView autoSetDimensionsToSize:CGSizeMake(50.0, 50.0)];
        
        // Red view is positioned at the bottom right corner of the blue view, with the same width, and a height of 40 pt
        [self.redView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.blueView];
        [self.redView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.blueView];
        [self.redView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.blueView];
        [self.redView autoSetDimension:ALDimensionHeight toSize:40.0];
        
        // Yellow view is positioned 10 pt below the red view, extending across the screen with 20 pt insets from the edges,
        // and with a fixed height of 25 pt
        [self.yellowView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.redView withOffset:10.0];
        [self.yellowView autoSetDimension:ALDimensionHeight toSize:25.0];
        [self.yellowView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0];
        [self.yellowView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0];
        
        // Green view is positioned 10 pt below the yellow view, aligned to the vertical axis of its superview,
        // with its height twice the height of the yellow view and its width fixed to 150 pt
        [self.greenView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.yellowView withOffset:10.0];
        [self.greenView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.greenView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.yellowView withMultiplier:2.0];
        [self.greenView autoSetDimension:ALDimensionWidth toSize:150.0];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (UIView *)blueView
{
    if (!_blueView) {
        _blueView = [UIView newAutoLayoutView];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)redView
{
    if (!_redView) {
        _redView = [UIView newAutoLayoutView];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)yellowView
{
    if (!_yellowView) {
        _yellowView = [UIView newAutoLayoutView];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}

- (UIView *)greenView
{
    if (!_greenView) {
        _greenView = [UIView newAutoLayoutView];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}


@end
