//
//  AffineViewController.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/1.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "AffineViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface AffineViewController ()

@property (strong, nonatomic) UIView *demoView;

@end

@implementation AffineViewController

- (void)initView {
    [super initView];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 100, 100, 100)];
    _demoView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_demoView];
}

- (NSString *)controllerTitle {
    return @"仿射变换";
}

- (NSArray *)operateTitle {
    return [NSArray arrayWithObjects:@"位移", @"缩放", @"旋转", @"组合", @"反转", nil];
}

- (void)clickOperateButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self scaleAnimation];
            break;
        case 2:
            [self rorateAnimation];
            break;
        case 3:
            [self groupAnimation];
            break;
        case 4:
            [self invertAnimation
             ];
            break;
        default:
            break;
    }
}

- (void)positionAnimation {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}

- (void)scaleAnimation {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }];
}

- (void)rorateAnimation {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)groupAnimation {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeScale(0.6, 0.6);
        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
        CGAffineTransform transform3 = CGAffineTransformTranslate(transform2, 100, 100);
        _demoView.transform = transform3;
    }];
}

- (void)invertAnimation {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(0.5, 0.5));
    }];
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
