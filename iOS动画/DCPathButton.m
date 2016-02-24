//
//  DCPathButton.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/3.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "DCPathButton.h"
#import "DCPathCenterButton.h"

@interface DCPathButton ()<DCPathCenterButtonDelegate, DCPathItemButtonDelegate>

@property (strong, nonatomic) UIImage *centerImage;
@property (strong, nonatomic) UIImage *centerHighlightedImage;

@property (assign, nonatomic, getter=isBloom) BOOL bloom;

@property (assign, nonatomic) CGSize foldedSize;
@property (assign, nonatomic) CGSize bloomSize;
@property (assign, nonatomic) CGPoint foldCenter;
@property (assign, nonatomic) CGPoint bloomCenter;

@property (assign, nonatomic) CGPoint pathCenterButtonBloomCenter;
@property (assign, nonatomic) CGPoint expandCenter;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) DCPathCenterButton *pathCenterButton;
@property (strong, nonatomic) NSMutableArray *itemButtons;

@property (assign, nonatomic) SystemSoundID bloomSound;
@property (assign, nonatomic) SystemSoundID foldSound;
@property (assign, nonatomic) SystemSoundID selectedSound;

@end

@implementation DCPathButton

- (id)initWithCenterImage:(UIImage *)centerImage hilightedImage:(UIImage *)centerHighlightedImage {

    if (self = [super init]) {
        self.centerImage = centerImage;
        self.centerHighlightedImage = centerHighlightedImage;
        
        self.itemButtonImages = [[NSMutableArray alloc] init];
        self.itemButtonHighlightedImages = [[NSMutableArray alloc] init];
        self.itemButtons = [[NSMutableArray alloc] init];
        
        [self configureViewsLayout];
        [self configureSounds];
    }
    return self;
}

- (void)configureViewsLayout {
    self.foldedSize = self.centerImage.size;
    self.bloomSize = [UIScreen mainScreen].bounds.size;
    
    self.bloom = NO;
    self.bloomRadius = 105.0f;
    
    self.foldCenter = CGPointMake(self.bloomSize.width/2, self.bloomSize.height - 255.0f);
    self.bloomCenter = CGPointMake(self.bloomSize.width/2, self.bloomSize.height/2);
    
    self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
    self.center = self.foldCenter;
    
    _pathCenterButton = [[DCPathCenterButton alloc] initWithImage:self.centerImage highlightedImage:self.centerHighlightedImage];
    _pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _pathCenterButton.delegate = self;
    [self addSubview:_pathCenterButton];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height)];
    _bottomView.backgroundColor = [UIColor blackColor];
    _bottomView.alpha = 0.0f;
}

- (void)configureSounds {

    NSString *blomSoundPath = [[NSBundle mainBundle] pathForResource:@"bloom" ofType:@"caf"];
    NSURL *bloomSoundURL = [NSURL fileURLWithPath:blomSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)bloomSoundURL, &_bloomSound);
    
    NSString *foldSoundPath = [[NSBundle mainBundle] pathForResource:@"fold" ofType:@"caf"];
    NSURL *foldSoundURL = [NSURL fileURLWithPath:foldSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)foldSoundURL, &_foldSound);
    
    NSString *selectedSoundPath = [[NSBundle mainBundle] pathForResource:@"selected" ofType:@"caf"];
    NSURL *selectedSoundURL = [NSURL fileURLWithPath:selectedSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)selectedSoundURL, &_selectedSound);

}

- (void)setCenterImage:(UIImage *)centerImage {
    if (!centerImage) {
        NSLog(@"Load center image failed ...");
        return;
    }
    _centerImage = centerImage;
}

- (void)setCenterHighlightedImage:(UIImage *)centerHighlightedImage {
    if (!centerHighlightedImage) {
        NSLog(@"Load highted image failed ... ");
        return;
    }
    _centerHighlightedImage = centerHighlightedImage;
}

- (void)setPathCenterButtonBloomCenter:(CGPoint)pathCenterButtonBloomCenter {
    if (_pathCenterButtonBloomCenter.x == 0) {
        _pathCenterButtonBloomCenter = pathCenterButtonBloomCenter;
    }
}

- (BOOL)isBloom {
    return _bloom;
}

- (void)centerButtonTapped {
//    self.isBloom ? [self pathCenterButtonFold] : [self p];
}

- (void)pathCenterButtonFold {
    AudioServicesPlaySystemSound(self.foldSound);
    
    for (int i = 1; i <= self.itemButtons.count; i ++) {
        DCPathItemButton *itemButton = self.itemButtons[i - 1];
        
        CGFloat currentAngel = i/((CGFloat)self.itemButtons.count + 1);
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 0.5f andAngel:currentAngel];
        CAAnimationGroup *foldAnimation = [self foldAnimationFromPoint:itemButton.center withFarPoint:farPoint];
        [itemButton.layer addAnimation:foldAnimation forKey:@"faldAniamtion"];
        itemButton.center = self.pathCenterButtonBloomCenter;
    }
    [self bringSubviewToFront:self.pathCenterButton];
    [self resizeToFoldFrame];
    
}

- (CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius andAngel:(CGFloat)angel {
    return CGPointMake(self.pathCenterButtonBloomCenter.x - cosf(angel * M_PI), self.pathCenterButtonBloomCenter.y
                       - sinf(angel * M_PI) * itemExpandRadius);
}

- (CAAnimationGroup *)foldAnimationFromPoint:(CGPoint)endPoint withFarPoint:(CGPoint)farPoint {
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0), @(M_PI), @(M_PI * 2)];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = 0.35f;
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathAddLineToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    
    moveAnimation.keyTimes = @[@(0.0f), @(0.75f), @(1.0f)];
    moveAnimation.path = path;
    moveAnimation.duration = 0.35;
    CGPathRelease(path);
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.animations = @[rotationAnimation, moveAnimation];
    animations.duration = 0.35f;
    
    return animations;
}

- (void)resizeToFoldFrame {
    [UIView animateWithDuration:0.0618f * 3
                          delay:0.0618f * 2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _pathCenterButton.transform = CGAffineTransformMakeRotation(0);
                     } completion:nil];
    [UIView animateWithDuration:0.1f
                          delay:0.35f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _bottomView.alpha = 0.0f;
                     } completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (DCPathItemButton * itemButton in self.itemButtons) {
            [itemButton performSelector:@selector(removeFromSuperview)];
        }
        self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
        self.center = self.foldCenter;
        self.pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self.bottomView removeFromSuperview];
    });
    _bloom = NO;
}

- (void)pathCenterButtonBlooom {
    AudioServicesPlaySystemSound(self.bloomSound);
    self.pathCenterButtonBloomCenter = self.center;
    
    self.frame = CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height);
    self.center = CGPointMake(self.bloomSize.width/2,self.bloomSize.height/2);
    
    [UIView animateWithDuration:0.0618f * 3
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _bottomView.alpha = 0.618f;
                     } completion:nil];
    [UIView animateWithDuration:0.1575f
                           animations:^{
                               _pathCenterButton.transform = CGAffineTransformMakeRotation(- 0.75f * M_PI);
                           }];
    self.pathCenterButton.center = self.pathCenterButtonBloomCenter;
    
    CGFloat basicAngel = 180 / (self.itemButtons.count + 1);
    
    for (int i = 1; i < self.itemButtons.count; i ++) {
        
        DCPathItemButton *pathItemButton = self.itemButtons[i - 1];
        
        pathItemButton.delegate = self;
        pathItemButton.tag = i - 1;
        pathItemButton.transform = CGAffineTransformMakeTranslation(1, 1);
        pathItemButton.alpha = 1.0f;
        
        CGFloat currentAngel = (basicAngel * i)/180;
        pathItemButton.center = self.pathCenterButtonBloomCenter;
        [self insertSubview:pathItemButton belowSubview:self.pathCenterButton];
        
        CGPoint endPoint = [self createEndPointWithRadius:self.bloomRadius andAngel:currentAngel];
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 10.0f andAngel:currentAngel];
        CGPoint nearPoint = [self createEndPointWithRadius:self.bloomRadius - 5.0f andAngel:currentAngel];
        
        CAAnimationGroup *bloomAnimation = [self bloomAnimationWithEndPoint:endPoint andFarPoint:farPoint andNearPoint:nearPoint];
        [pathItemButton.layer addAnimation:bloomAnimation forKey:@"bloomAnimation"];
    }
    _bloom = YES;
}

- (CAAnimationGroup *)bloomAnimationWithEndPoint:(CGPoint)endPoint andFarPoint:(CGPoint)farPoint andNearPoint:(CGPoint)nearPoint {

    CAKeyframeAnimation *rotationAnimaiton = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimaiton.values = @[@(0.0), @(-M_PI), @(- M_PI *1.5), @(-M_PI * 2)];
    rotationAnimaiton.duration = 0.3f;
    rotationAnimaiton.keyTimes = @[@(0.0), @(0.3), @(0.6), @(1.0)];
    
    CAKeyframeAnimation *movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,  NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    CGPathMoveToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathMoveToPoint(path, NULL, nearPoint.x, nearPoint.y);
    CGPathMoveToPoint(path, NULL, endPoint.x, endPoint.y);
    
    movingAnimation.path = path;
    movingAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
    movingAnimation.duration = 0.3f;
    CGPathRelease(path);
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.animations = @[rotationAnimaiton, movingAnimation];
    animations.duration = 0.3f;
    animations.delegate = self;
    
    return animations;
}

- (void)addPathItems:(NSArray *)pathItemButtons {
    [self.itemButtons addObjectsFromArray:pathItemButtons];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self pathCenterButtonFold];
}

- (void)itemButtonTapped:(DCPathItemButton *)itemButton {
    if ([_delegate respondsToSelector:@selector(itemButtonTappedAtIndex:)]) {
        DCPathItemButton *selectedButton = self.itemButtons[itemButton.tag];
        
        AudioServicesPlayAlertSound(self.selectedSound);
        [UIView animateWithDuration:0.0618 *5 animations:^{
            selectedButton.transform = CGAffineTransformMakeScale(3, 3);
            selectedButton.alpha = 0.0f;
        }];
        
        for (int i = 0; i < self.itemButtons.count; i ++) {
            if (i == selectedButton.tag) {
                continue;
            }
            DCPathItemButton *unselectedButton = self.itemButtons[i];
            [UIView animateWithDuration:0.0618f * 2 animations:^{
                unselectedButton.transform = CGAffineTransformMakeScale(0, 0);
            }];
        }
        [_delegate itemButtonTappedAtIndex:itemButton.tag];
        
        [self resizeToFoldFrame];
    }
}












































































@end
