//
//  KeyFramAnimationViewController.m
//  iOS动画
//
//  Created by 杨杨 on 16/1/31.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "KeyFramAnimationViewController.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface KeyFramAnimationViewController ()

@property (strong, nonatomic) UIView *demoView;

@end

@implementation KeyFramAnimationViewController

- (NSString *)controllerTitle {
    return @"关键帧动画";
}

- (NSArray *)operateTitle {
    return [NSArray arrayWithObjects:@"关键帧", @"路径", @"抖动", nil];
}

- (void)clickOperateButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self KeyFramAnimation];
            break;
        case 1:
            [self pathAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
        default:
            break;
    }
}

/**
 *  抖动动画
 */
- (void)shakeAnimation {

    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    shakeAnimation.values = [NSArray arrayWithObjects:value1, value2, value3, nil];
    shakeAnimation.repeatCount = 10;
    [_demoView.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

/**
 *  路径动画
 */
- (void)pathAnimation {
  
    CAKeyframeAnimation *pathAnimayion = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3, 100, 100)];
    pathAnimayion.path = path2.CGPath;
    pathAnimayion.duration = 3.0f;
    [_demoView.layer addAnimation:pathAnimayion forKey:@"pathAnimation"];
    
}

/**
 *  关键帧动画
 */
- (void)KeyFramAnimation {

    CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2 - 100)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(2*SCREEN_WIDTH/3, SCREEN_HEIGHT/2 - 100)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(2*SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    keyFramAnimation.values = [NSArray arrayWithObjects:value1, value2, value3, value4, value5, value6, nil];
    keyFramAnimation.duration = 3.0f;
    keyFramAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:keyFramAnimation forKey:@"KeyFramAnimation"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 100, 100, 100)];
    _demoView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_demoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
