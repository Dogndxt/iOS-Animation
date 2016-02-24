//
//  MCFireworksView.h
//  iOS动画
//
//  Created by 杨杨 on 16/2/5.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCFireworksView : UIView

@property (strong, nonatomic) UIImage *particleImage;
@property (assign, nonatomic) CGFloat particleScale;
@property (assign, nonatomic) CGFloat particleScaleRange;

- (void)animate;

@end
