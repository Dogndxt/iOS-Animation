//
//  DCPathItemButton.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "DCPathItemButton.h"

@interface DCPathItemButton ()

@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation DCPathItemButton

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage backgroundImage:(UIImage *)backgroundImage backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage {
    if (self = [super init]) {
        CGRect itemFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        if (!backgroundImage || !backgroundHighlightedImage) {
            itemFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        self.frame = itemFrame;
        self.image = backgroundImage;
        self.highlightedImage = backgroundHighlightedImage;
        self.userInteractionEnabled = YES;
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:image highlightedImage:highlightedImage];
        _backgroundImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        [self addSubview:_backgroundImageView];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentLocation = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint([self scaleRect:self.bounds], currentLocation)) {
        self.highlighted = NO;
        self.backgroundImageView.highlighted = NO;
        return;
    }
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
    
}


- (CGRect)scaleRect:(CGRect)originRect {
    return CGRectMake(- originRect.size.width * 2, - originRect.size.height * 2, originRect.size.width * 5, originRect.size.height * 5);
}



























@end
