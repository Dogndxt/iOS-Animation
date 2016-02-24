//
//  BaseViewController.h
//  iOS动画
//
//  Created by 杨杨 on 16/1/30.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//界面标题
- (NSString *)controllerTitle;

//初始化界面
- (void)initView;

//按钮标题
- (NSArray *)operateTitle;

//点击事件
- (void)clickOperateButton:(UIButton *)button;

@end
