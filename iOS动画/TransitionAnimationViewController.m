//
//  TransitionAnimationViewController.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/1.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "TransitionAnimationViewController.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface TransitionAnimationViewController ()

@property (strong, nonatomic) UIView *demoView;
@property (strong, nonatomic) UILabel *demoLable;
@property (assign, nonatomic) NSInteger index;

@end

@implementation TransitionAnimationViewController

- (NSString *)controllerTitle {
    return @"转场动画";
}

- (NSArray *)operateTitle {
    return [NSArray arrayWithObjects:@"fade", @"moveIn", @"push", @"reveal", @"cube", @"suck",
            @"oglFilp", @"ripple", @"curl", @"Uncurl", @"caOpen", @"caclose", nil];
}

- (void)initView {

    [super initView];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/6, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    _demoLable = [[UILabel alloc] initWithFrame:CGRectMake(_demoView.frame.size.width/2 - 20, CGRectGetHeight(_demoView.frame)/2 - 30, 40, 60)];
    _demoLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_demoView];
    [_demoView addSubview:_demoLable];
}

- (void)clickOperateButton:(UIButton *)button {
    
    switch (button.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleAnimation];
            break;
        case 8:
            [self curlAnimation];
            break;
        case 9:
            [self unCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
        default:
            break;
    }
}

/**
 *  普通过场
 */
- (void)fadeAnimation {
    [self changeView:YES];
    CATransition *fadeAnimation = [CATransition animation];
    fadeAnimation.type = kCATransitionFade;
    fadeAnimation.subtype = kCATransitionFromRight;
    fadeAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

- (void)moveInAnimation {
    [self changeView:YES];
    CATransition *moveInAnimation = [CATransition animation];
    moveInAnimation.type = kCATransitionMoveIn;
    moveInAnimation.subtype = kCATransitionFromRight;
    moveInAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:moveInAnimation forKey:@"moveInAnimation"];
}

- (void)pushAnimation {
    [self changeView:YES];
    CATransition *pushAnimation = [CATransition animation];
    pushAnimation.type = kCATransitionPush;
    pushAnimation.subtype = kCATransitionFromRight;
    pushAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:pushAnimation forKey:@"pushAnimation"];
}

- (void)revealAnimation {
    [self changeView:YES];
    CATransition *revealAnimation = [CATransition animation];
    revealAnimation.type = kCATransitionReveal;
    revealAnimation.subtype = kCATransitionFromRight;
    revealAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:revealAnimation forKey:@"revealAnimation"];
}

/**
 *  特别的转场动画
 */
- (void)cubeAnimation {
    [self changeView:YES];
    CATransition *cubeAnimation = [CATransition animation];
    cubeAnimation.type = @"cube";
    cubeAnimation.subtype =  kCATransitionFromRight;
    cubeAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:cubeAnimation forKey:@"subeAnimation"];
}

- (void)suckAnimation {
    [self changeView:YES];
    CATransition *suckAnimation = [CATransition animation];
    suckAnimation.type = @"suckEffect";
    suckAnimation.subtype = kCATransitionFromRight;
    suckAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:suckAnimation forKey:@"suckAnimation"];
}

- (void)oglFlipAnimation {
    [self changeView:YES];
    CATransition *ogleFlipAnimation = [CATransition animation];
    ogleFlipAnimation.type = @"oglFlip";
    ogleFlipAnimation.subtype = kCATransitionFromRight;
    ogleFlipAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:ogleFlipAnimation forKey:@"oglFlipAnimation"];
}

- (void)rippleAnimation {
    [self changeView:YES];
    CATransition *rippleAnimation = [CATransition animation];
    rippleAnimation.type = @"rippleEffect";
    rippleAnimation.subtype = kCATransitionFromRight;
    rippleAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:rippleAnimation forKey:@"rippleAnimation"];
}

- (void)curlAnimation {
    [self changeView:YES];
    CATransition *curlAnmation = [CATransition animation];
    curlAnmation.type = @"pageCurl";
    curlAnmation.subtype = kCATransitionFromRight;
    curlAnmation.duration = 1.0f;
    [_demoView.layer addAnimation:curlAnmation forKey:@"curlAnimation"];
}

- (void)unCurlAnimation {
    [self changeView:YES];
    CATransition *unCurlAnimation = [CATransition animation];
    unCurlAnimation.type = @"pageUnCurl";
    unCurlAnimation.subtype = kCATransitionFromRight;
    unCurlAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:unCurlAnimation forKey:@"unCurlAnimation"];
}

- (void)cameraIrisHollowOpenAnimation {
    [self changeView:YES];
    CATransition *cameraIrisHollowOpenAnimation = [CATransition animation];
    cameraIrisHollowOpenAnimation.type = @"cameraIrisHollowOpen";
    cameraIrisHollowOpenAnimation.subtype = kCATransitionFromRight;
    cameraIrisHollowOpenAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:cameraIrisHollowOpenAnimation forKey:@"cameraIrisHollowOpenAnimation"];
}


- (void)cameraIrisHollowCloseAnimation {
    [self changeView:YES];
    CATransition *cameraIrisHollowCloseAnimation = [CATransition animation];
    cameraIrisHollowCloseAnimation.type = @"cameraIrisHollowClose";
    cameraIrisHollowCloseAnimation.subtype = kCATransitionFromRight;
    cameraIrisHollowCloseAnimation.duration = 1.0f;
    [_demoView.layer addAnimation:cameraIrisHollowCloseAnimation forKey:@"cameraIrisHollowCloseAnimation"];
}

/**
 *  设置view的值
 */
- (void)changeView:(BOOL)Up {
    if (_index > 3) {
        _index = 0;
    } else if (_index < 0) {
        _index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor orangeColor], [UIColor greenColor], [UIColor yellowColor], [UIColor blueColor], nil];
    NSArray *nums = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", nil];
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    _demoLable.text = [nums objectAtIndex:_index];
    if (Up) {
        _index ++;
    } else {
        _index --;
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    _index = 0;
    [self changeView:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
