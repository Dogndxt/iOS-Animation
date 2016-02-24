//
//  DCPathCenterButton.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "DCPathCenterButton.h"

@implementation DCPathCenterButton

- (id)initWithImage:(UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        self.userInteractionEnabled = YES;
        self.image = image;
        self.highlightedImage = highlightedImage;
    }
    return self;
}

- (CGRect)scaleRect:(CGRect)origiRect {
    return CGRectMake(- origiRect.size.width, - origiRect.size.height, origiRect.size.width * 3, origiRect.size.height * 3);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
    if ([_delegate respondsToSelector:@selector(centerButtonTapped)]) {
        [_delegate centerButtonTapped];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentLocation = [[touches anyObject] locationInView:self];
    
    if (!CGRectContainsPoint([self scaleRect:self.bounds], currentLocation)) {
        self.highlighted = NO;
        return;
    }
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

@end
