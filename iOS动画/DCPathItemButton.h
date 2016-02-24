//
//  DCPathItemButton.h
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCPathItemButton;

@protocol DCPathItemButtonDelegate <NSObject>

- (void)itemButtonTapped:(DCPathItemButton *)itemButton;

@end

@interface DCPathItemButton : UIImageView

@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) id<DCPathItemButtonDelegate> delegate;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
    backgroundImage:(UIImage *)backgroundImage backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage;

@end
