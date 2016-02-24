//
//  DWBubbleMenuButton.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/2.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "DWBubbleMenuButton.h"

#define KDeafaultAnimationDutation 0.25f

@interface DWBubbleMenuButton ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *buttonContainer;
@property (nonatomic, assign) CGRect originFrame;

@end

@implementation DWBubbleMenuButton

- (void)addButtons:(NSArray *)buttons {
    assert(buttons != nil);
    for (UIButton *button in buttons ) {
        [self addButton:button];
    }
    if (self.homeButtonView != nil) {
        [self bringSubviewToFront:self.homeButtonView];
    }
}

- (void)addButton:(UIButton *)button {
    assert(button != nil);
    if (_buttonContainer == nil) {
        self.buttonContainer = [[NSMutableArray alloc] init];
    }
    if ([_buttonContainer containsObject:button] == false) {
        [_buttonContainer addObject:button];
        [self addSubview:button];
        button.hidden = YES;
    }
}

- (void)showButtons {
    if ([self.delegate respondsToSelector:@selector(bubbleMenuButtonWillExpand:)]) {
        [self.delegate bubbleMenuButtonWillExpand:self];
    }
    [self _prepareForButtonExpansion];
    self.userInteractionEnabled = NO;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        for (UIButton *button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
        }
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(bubbleMenuButtonDidExpand:)]) {
                [self.delegate bubbleMenuButtonDidExpand:self];
            }
        }
        self.userInteractionEnabled = YES;
    }];
    
    NSArray *buttonContainer = _buttonContainer;
    
    if (self.direction == DirectionUp || self.direction == DirectionLeft) {
        buttonContainer = [self _reverseOrderFromArray:_buttonContainer];
    }
    for (int i = 0; i < buttonContainer.count; i ++) {
        int index = (int)buttonContainer.count - (i + 1);
        
        UIButton *button = [buttonContainer objectAtIndex:index];
        button.hidden = NO;
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        CGPoint originPosition = CGPointZero;
        CGPoint finalPosition = CGPointZero;
        
        switch (self.direction) {
            case DirectionLeft:
                originPosition = CGPointMake(self.frame.size.width - self.homeButtonView.frame.size.width, self.frame.size.height/2.0f);
                finalPosition = CGPointMake(self.frame.size.width - self.homeButtonView.frame.size.width - button.frame.size.width/2.0f
                                            - self.buttonSpacing - ((button.frame.size.width + self.buttonSpacing) * index), self.frame.size.height/2.0f);
                break;
            case DirectionRight:
                originPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.height/2.0f);
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width + self.buttonSpacing + button.frame.size.width/2.0f +
                                            ((button.frame.size.width + self.buttonSpacing) * index), self.frame.size.height/2.0f);
                break;
            case DirectionUp:
                originPosition = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height - self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height - self.homeButtonView.frame.size.height -
                                            self.buttonSpacing - button.frame.size.height/2.0f - ((button.frame.size.height + self.buttonSpacing) * index));
                break;
            case DirectionDown:
                originPosition = CGPointMake(self.frame.size.width/2.0f, self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2.0f,self.homeButtonView.frame.size.height + self.buttonSpacing + button.frame.size.height/2.0f +
                                            ((button.frame.size.height + self.buttonSpacing) * index));
                break;
            default:
                break;
        }
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)i) + 0.03f;
        positionAnimation.fillMode =kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        [button .layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        button.layer.position = finalPosition;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = _animationDuration;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        button.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
    [CATransaction commit];
    _isCollapsed = NO;
    
}

-  (void)dismissButtons {
    if ([self.delegate respondsToSelector:@selector(bubbleMenubuttonWillCollapse:)]) {
        [self.delegate bubbleMenubuttonWillCollapse:self];
    }
    self.userInteractionEnabled = NO;
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        [self _finishCollapse];
        for (UIButton *button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
            button.hidden = YES;
        }
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(bubbleMenuButtonDidCollaose:)]) {
                [self.delegate bubbleMenuButtonDidCollaose:self];
            }
        }
        self.userInteractionEnabled = YES;
    }];
    int index = 0;
    for (int i = (int)_buttonContainer.count - 1; i >= 0; i --) {
        UIButton *button = [_buttonContainer objectAtIndex:i];
        if (self.direction == DirectionDown || self.direction == DirectionRight) {
            button = [_buttonContainer objectAtIndex:index];
        }
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = _animationDuration;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)index + 0.03f);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        button.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        CGPoint originPosition = button.layer.position;
        CGPoint finalPosition = CGPointZero;
        
        switch (self.direction) {
            case DirectionLeft:
                finalPosition = CGPointMake(self.frame.size.width - self.homeButtonView.frame.size.width, self.frame.size.width/2.0f);
                break;
            case DirectionRight:
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.width/2.0f);
                break;
            case DirectionUp:
                finalPosition = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height - self.homeButtonView.frame.size.height);
                break;
            case DirectionDown:
                finalPosition = CGPointMake(self.frame.size.width/2.0f, self.homeButtonView.frame.size.height);
                break;
                
            default:
                break;
        }
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)index);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [button.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        button.layer.position = originPosition;
        index ++;
        
    }
    [CATransaction commit];
    _isCollapsed = YES;
}

- (void)_finishCollapse {
    self.frame = _originFrame;
}

- (NSArray *)_reverseOrderFromArray:(NSArray *)array {
    NSMutableArray *reverseArray = [NSMutableArray array];
    for (int i = (int)array.count - 1; i >= 0; i --) {
        [reverseArray addObject:[array objectAtIndex:i]];
    }
    return reverseArray;
}

- (float)_combineButtonHeight {
    float height = 0;
    for (UIButton *button in _buttonContainer) {
        height += button.frame.size.height + self.buttonSpacing;
    }
    return height;
}

- (float)_combineButtonWidth {
    float width = 0;
    for (UIButton *button in _buttonContainer) {
        width += button.frame.size.width + self.buttonSpacing;
    }
    return width;
}

- (void)_prepareForButtonExpansion {
    float buttonHeight = [self _combineButtonHeight];
    float buttonWidth = [self _combineButtonWidth];
    switch (self.direction) {
        case DirectionUp:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            
            CGRect frame = self.frame;
            frame.origin.y -= buttonHeight;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
        case DirectionDown:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            
            CGRect frame = self.frame;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
        case DirectionLeft:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            
            CGRect frame = self.frame;
            frame.origin.x -= buttonWidth;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
        case DirectionRight:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            
            CGRect frame = self.frame;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
            
        default:
            break;
    }

}

- (void)_defaultInit {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.direction = DirectionUp;
    self.animatedHighlighting = YES;
    self.collapseAfterSelection = YES;
    self.animationDuration = _animationDuration;
    self.standbyAlpha = 1.0f;
    self.highlightAlpha = 0.45f;
    self.originFrame = self.frame;
    self.buttonSpacing = 20.0f;
    _isCollapsed = YES;
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGesture:)];
    self.tapGestureRecognizer.cancelsTouchesInView = NO;
    self.tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)_handleTapGesture:(id)sender {
    if (self.tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [self.tapGestureRecognizer locationOfTouch:0 inView:self];
        if (_collapseAfterSelection && _isCollapsed == NO && CGRectContainsPoint(self.homeButtonView.frame, touchLocation)) {
            [self dismissButtons];
        }
    }

}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame expansionDirection:(ExpansionDirection)direction {
    self = [super initWithFrame:frame];
    if (self) {
        [self _defaultInit];
        _direction = direction;
    }
    return self;
}

- (void)_animateWithBlock:(void(^)(void))animationBlock {
    [UIView transitionWithView:self
                      duration:KDeafaultAnimationDutation
                       options:UIViewAnimationOptionBeginFromCurrentState
                    animations:animationBlock
                    completion:NULL];
}

- (void)_setTouchHighlighted:(BOOL)highighted {
    float alphaValue = highighted ? _highlightAlpha : _standbyAlpha;
    if (self.homeButtonView.alpha == alphaValue) {
        return;
    }
    if (_animationDuration) {
        [self _animateWithBlock:^{
            if (self.homeButtonView != nil) {
                self.homeButtonView.alpha = alphaValue;
            }
        }];
    } else {
        if (self.homeButtonView != nil) {
            self.homeButtonView.alpha = alphaValue;
        }
    }
}

- (UIView *)_subviewForPoint:(CGPoint)point {
    for (UIView *subview in self.subviews) {
        if (CGRectContainsPoint(subview.frame, point)) {
            return subview;
        }
    }
    return self;
}

- (void)setHomeButtonView:(UIView *)homeButtonView {
    if (_homeButtonView != homeButtonView) {
        _homeButtonView = homeButtonView;
    }
    if ([_homeButtonView isDescendantOfView:self] == NO) {
        [self addSubview:_homeButtonView];
    }
}

- (NSArray *)buttons {
    return [_buttonContainer copy];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])) {
        [self _setTouchHighlighted:YES];
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self _setTouchHighlighted:NO];
    
    if (CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])) {
        if (_isCollapsed) {
            [self showButtons];
        } else {
            [self dismissButtons];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesCancelled:touches withEvent:event];
    [self _setTouchHighlighted:NO];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self _setTouchHighlighted:CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        if (_isCollapsed) {
            return self;
        } else {
            return [self _subviewForPoint:point];
        }
    }
    return hitView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([self _subviewForPoint:touchLocation] != self && _collapseAfterSelection) {
        return YES;
    }
    return NO;
}





































































@end
