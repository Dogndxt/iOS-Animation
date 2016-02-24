//
//  TitleButton.h
//  iOS动画
//
//  Created by 杨杨 on 16/1/30.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface TitleButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
