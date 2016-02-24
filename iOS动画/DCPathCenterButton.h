//
//  DCPathCenterButton.h
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCPathCenterButtonDelegate <NSObject>

- (void)centerButtonTapped;

@end

@interface DCPathCenterButton : UIImageView

@property (weak, nonatomic) id<DCPathCenterButtonDelegate> delegate;

@end
