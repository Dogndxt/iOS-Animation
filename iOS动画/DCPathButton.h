//
//  DCPathButton.h
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPathItemButton.h"

@import QuartzCore;
@import AudioToolbox;

@protocol DCPathButtonDelegate <NSObject>

- (void)itemButtonTappedAtIndex:(NSUInteger)index;

@end

@interface DCPathButton : UIImageView

@property (weak, nonatomic) id<DCPathButtonDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *itemButtonImages;
@property (strong, nonatomic) NSMutableArray *itemButtonHighlightedImages;

@property (strong, nonatomic) UIImage *itemButtonBackgroundImage;
@property (strong, nonatomic) UIImage *itemButtonBackgroundHighlightedImage;
@property (assign, nonatomic) CGFloat bloomRadius;

- (id)initWithCenterImage:(UIImage *)centerImage hilightedImage:(UIImage *)centerHighlightedImage;
- (void)addPathItems:(NSArray *)pathItemButtons;

@end
