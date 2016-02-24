//
//  FirstViewController.m
//  iOS动画
//
//  Created by 杨杨 on 16/1/30.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (strong, nonatomic)UIView *demoView;

@end

@implementation FirstViewController

- (NSArray *)operateTitle {
    return [[NSArray alloc] initWithObjects:@"位移", @"透明度", @"缩放", @"旋转", @"背景色", nil];
}

- (void)clickOperateButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self displacementAnimation];
            break;
        case 1:
            [self opacityAnimation];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        case 4:
            [self backgroundColorAnimation];
            break;
        default:
            break;
    }
    
}

- (NSString *)controllerTitle {
      return  @"基础动画";
}
//背景色变化
- (void)backgroundColorAnimation {

    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.toValue = (id)[UIColor greenColor].CGColor;
    backgroundColorAnimation.duration = 6.0f;
    [_demoView.layer addAnimation:backgroundColorAnimation forKey:@"backgroundColorAnimation"];
}

//旋转动画
- (void)rotateAnimation {
//    CABasicAnimation *rotatetionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotatetionAnimation.toValue = [NSNumber numberWithFloat:M_PI];
//    rotatetionAnimation.duration = 3.0f;
//    rotatetionAnimation.repeatCount = 3.0f;
//    [_demoView.layer addAnimation:rotatetionAnimation forKey:@"rotateAnimation"];

    //valueWithCATransform3D - layer
//    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    rotateAnimation.duration = 2.0f;
//    rotateAnimation.repeatCount = 10;
//    [_demoView.layer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
    
    //CGAffineTransformMakeRotation
    _demoView.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:2.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        
    }];
}

//缩放动画
- (void)scaleAnimation {
//bounds 方式缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
//    scaleAnimation.duration = 2.0f;
//    [_demoView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];

    //scale 方式缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0f];
//    scaleAnimation.duration = 2.0f;
//    [_demoView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    //缩放方式3
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    scaleAnimation.duration = 2.0f;
    [_demoView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
}

//透明动画
- (void)opacityAnimation {
    
    CABasicAnimation *opactityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactityAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    opactityAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    opactityAnimation.duration = 3.0f;
    [_demoView.layer addAnimation:opactityAnimation forKey:@"opacityAnimation"];
}

//位移动画
- (void)displacementAnimation {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2 - 50)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2 - 50)];
    basicAnimation.duration = 2.0f;
//    basicAnimation.fillMode = kCAFillModeForwards;
//    basicAnimation.removedOnCompletion = NO;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:basicAnimation forKey:@"displacementAnimation"];
    
    //block method
//    [UIView animateWithDuration:2.0f animations:^{
//        _demoView.frame = CGRectMake(0, 0, 100, 100);
//    } completion:^(BOOL finished) {
//        _demoView.frame = CGRectMake(SCREEN_WIDTH - 150, SCREEN_HEIGHT - 150, 150, 150);
//    }];
    //begin － commit方式
//    _demoView.frame = CGRectMake(0, 0, 100, 100);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2.0f];
//    _demoView.frame = CGRectMake(SCREEN_WIDTH - 200, SCREEN_HEIGHT - 200, 200, 200);
//    [UIView commitAnimations];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self controllerTitle];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 100, 100, 100)];
    _demoView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_demoView];
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
