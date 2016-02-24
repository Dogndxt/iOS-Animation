//
//  GroupAnimationViewController.m
//  iOS动画
//
//  Created by 杨杨 on 16/1/31.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "GroupAnimationViewController.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface GroupAnimationViewController ()

@property (strong, nonatomic) UIView *demoView;

@end

@implementation GroupAnimationViewController

- (void)initView {
    [super initView];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 100, 100, 100)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
}

- (NSString *)controllerTitle {
    return @"组动画";
}

- (NSArray *)operateTitle {
    return [NSArray arrayWithObjects:@"连续", @"顺序", nil];
}

- (void)clickOperateButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self groupAnimation];
            break;
        case 1:
            [self keyframAnimation2];
            break;
        default:
            break;
    }
}

//组动画
- (void)groupAnimation {
//    //关键帧动画
//    CAKeyframeAnimation *keyframAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/3)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
//    keyframAnimation1.values = [NSArray arrayWithObjects:value1, value2, value3, value4, nil];
//    
//    //缩放动画
//    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    basicAnimation.fromValue = [NSNumber numberWithFloat:0.8f];
//    basicAnimation.toValue = [NSNumber numberWithFloat:2.0f];
//    
//    //旋转动画
//    CABasicAnimation *basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    basicAnimation2.toValue = [NSNumber numberWithFloat:M_PI*4];
//
//    //组动画
//    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//    groupAnimation.animations = [NSArray arrayWithObjects:keyframAnimation1, basicAnimation, basicAnimation2, nil];
//    groupAnimation.duration = 4.0f;
//    
//    [_demoView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
    
    //关键帧动画
    CAKeyframeAnimation *keyframAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/3)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    keyframAnimation1.values = [NSArray arrayWithObjects:value1, value2, value3, value4, nil];
    keyframAnimation1.duration = 4.0f;
    [_demoView.layer addAnimation:keyframAnimation1 forKey:@"a"];
    
    //缩放动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:1.5f];
    basicAnimation.duration = 4.0f;
    [_demoView.layer addAnimation:basicAnimation forKey:@"b"];
// 
//    //缩放动画
//    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    basicAnimation1.fromValue = [NSNumber numberWithFloat:2.0f];
//    basicAnimation1.toValue = [NSNumber numberWithFloat:1.0f];
//    basicAnimation1.beginTime = 2.0f;
//    basicAnimation1.duration = 2.0f;
//    [_demoView.layer addAnimation:basicAnimation1 forKey:@"c"];
    
    //旋转动画
    CABasicAnimation *basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation2.toValue = [NSNumber numberWithFloat:M_PI*4];
    basicAnimation2.duration = 4.0f;
    [_demoView.layer addAnimation:basicAnimation2 forKey:@"d"];
}

//顺序动画
- (void)keyframAnimation2 {
    
    //关键帧动画
    CAKeyframeAnimation *keyframAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/3)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    keyframAnimation1.values = [NSArray arrayWithObjects:value1, value2, value3, value4, nil];
    keyframAnimation1.duration = 2.0f;
    keyframAnimation1.beginTime = CACurrentMediaTime();
    [_demoView.layer addAnimation:keyframAnimation1 forKey:@"a"];
    
    //缩放动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:1.5f];
    basicAnimation.duration = 2.0f;
    basicAnimation.beginTime = CACurrentMediaTime() + 2.0f;
    [_demoView.layer addAnimation:basicAnimation forKey:@"b"];
    
    //旋转动画
    CABasicAnimation *basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation2.toValue = [NSNumber numberWithFloat:M_PI*4];
    basicAnimation2.duration = 2.0f;
    basicAnimation2.beginTime = CACurrentMediaTime() + 4.0f;
    [_demoView.layer addAnimation:basicAnimation2 forKey:@"d"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
