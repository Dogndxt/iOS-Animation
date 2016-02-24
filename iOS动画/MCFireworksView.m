//
//  MCFireworksView.m
//  iOS动画
//
//  Created by 杨杨 on 16/2/5.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "MCFireworksView.h"

@interface MCFireworksView ()

@property (strong, nonatomic) NSArray *emitterCells;
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation MCFireworksView

- (void)setup {
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20f;
    explosionCell.alphaSpeed = - 1.0f;
    
    explosionCell.lifetime = 0.7f;
    explosionCell.lifetimeRange = 0.3f;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.00f;
    explosionCell.velocityRange = 10.00;
    
    _explosionLayer =[CAEmitterLayer layer];
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize = CGSizeMake(25, 0);
    _explosionLayer.emitterCells = @[explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    _explosionLayer.seed = 1366128504;
    [self.layer addSublayer:_explosionLayer];
    
    CAEmitterCell *chageCell = [CAEmitterCell emitterCell];
    chageCell.name = @"charge";
    chageCell.alphaRange = 0.20f;
    chageCell.alphaSpeed = -1.0;
    
    chageCell.lifetime = 0.3;
    chageCell.lifetimeRange = 0.1f;
    chageCell.birthRate = 0;
    chageCell.velocity = -40.0f;
    chageCell.velocityRange = 0.00;
    
    _chargeLayer = [CAEmitterLayer layer];
    _chargeLayer.name = @"emitterLayer";
    _chargeLayer.emitterShape = kCAEmitterLayerCircle;
    _chargeLayer.emitterMode = kCAEmitterLayerOutline;
    _chargeLayer.emitterSize = CGSizeMake(25, 0);
    _chargeLayer.emitterCells = @[chageCell];
    _chargeLayer.renderMode = kCAEmitterLayerOldestFirst;
    _chargeLayer.masksToBounds = NO;
    _chargeLayer.seed = 1366128504;
    [self.layer addSublayer:_chargeLayer];
    self.emitterCells = @[chageCell, explosionCell];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.chargeLayer.emitterPosition = center;
    self.explosionLayer.emitterPosition = center;
}

- (void)animate {
    self.chargeLayer.beginTime = CACurrentMediaTime();
    [self.chargeLayer setValue:@80 forKey:@"emitterCells.charge.birthRate"];
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

- (void)explode {
    [self.chargeLayer setValue:@0 forKey:@"emitterCells.charge.birthRage"];
    self.explosionLayer.beginTime = CACurrentMediaTime();
    [self.explosionLayer setValue:@500 forKey:@"emitterCells.exposion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop {
    [self.chargeLayer setValue:@0 forKey:@"emtterCells.charge.birthRate"];
    [self.explosionLayer setValue:@0 forKey:@"emitterCells.explosion.birthRate"];
}

#pragma mark - Properties - set method
- (void)setParticleImage:(UIImage *)particleImage {
    _particleImage = particleImage;
    for (CAEmitterCell *cell in self.emitterCells) {
        cell.contents = (id)[particleImage CGImage];
    }
}

- (void)setParticleScale:(CGFloat)particleScale {
    _particleScale = particleScale;
    for (CAEmitterCell *cell in self.emitterCells) {
        cell.scaleRange = particleScale;
    }
}

- (void)setParticleScaleRange:(CGFloat)particleScaleRange {
    _particleScaleRange = particleScaleRange;
    for (CAEmitterCell *cell in self.emitterCells) {
        cell.scaleRange = particleScaleRange;
    }
}

@end

