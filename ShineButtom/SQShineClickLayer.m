//
//  SQShineClickLayer.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineClickLayer.h"
#import "SQShineParams.h"


@interface SQShineClickLayer()

@property(nonatomic,strong)CALayer *maskLayer;


@end

@implementation SQShineClickLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mask = self.maskLayer;
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
        self.mask = self.maskLayer;
    }
    return self;
}

- (void)defaultConfig
{
    _animDuration = 0.5;
    _color = [UIColor lightGrayColor];
    _fillColor = RGBCOLOR(255, 102, 102);
    self.image = [SQShineParams imageFromBundle:@"heart"];
}

- (void)startAnim
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = self.animDuration;
    anim.values = @[@0.4,@1,@0.9,@1];
    anim.calculationMode = @"cubic";
    [self.maskLayer addAnimation:anim forKey:@"scale"];
}

- (void)layoutSublayers
{
    NSLog(@"layoutSublayers");
    self.maskLayer.frame = self.bounds;
    if (self.clicked) {
        self.backgroundColor = self.fillColor.CGColor;
    }else{
        self.backgroundColor = self.color.CGColor;
    }
    self.maskLayer.contents = (__bridge id _Nullable)(self.image.CGImage);
}

- (CALayer *)maskLayer
{
    if (_maskLayer == nil){
        _maskLayer = [[CALayer alloc] init];
    }
    return _maskLayer;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.maskLayer.contents = (__bridge id _Nullable)(_image.CGImage);
}

- (void)setClicked:(BOOL)clicked
{
    _clicked = clicked;
    if (_clicked) {
        self.backgroundColor = self.fillColor.CGColor;
    }else{
        self.backgroundColor = self.color.CGColor;
    }
}

@end
