//
//  SQShineLayer.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineLayer.h"


@interface SQShineLayer()<CAAnimationDelegate>

@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@property(nonatomic,retain)CADisplayLink* displayLink;


@property(nonatomic,copy) void(^animEnd)();

@end

@implementation SQShineLayer

- (instancetype)init
{
    if (self = [super init]) {
        [self defaultConfig];
        [self initLayers];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
        [self defaultConfig];
        [self initLayers];
    }
    return self;
}

- (void)defaultConfig
{
    _fillColor = RGBCOLOR(255, 102, 102);
    _params = [[SQShineParams alloc] init];
//    _params.enableFlashing = NO;
}

- (void)initLayers
{
    _shapeLayer = [[CAShapeLayer alloc] init];
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _shapeLayer.strokeColor = self.fillColor.CGColor;
    _shapeLayer.lineWidth = 1.5;
    [self addSublayer:_shapeLayer];
}

- (void)startAnim
{
    //帧动画, 此处也可用基础动画实现，基础动画可以只能设置fromValue和toValue，相当于只能设置两帧的帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = self.params.animDuration * 0.1;
    CGSize size = self.frame.size;
    CGPoint centerPoint = CGPointMake(size.width/2, size.height/2);
    
    //创建圆弧
    //圆点，半径，起始角度，终止角度，是否顺时针
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                        radius:1
                                                    startAngle:0 endAngle:M_PI * 2.0 clockwise:NO];
    UIBezierPath *toPath =   [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                        radius:size.width/2 * self.params.shineDistanceMutiple
                                                    startAngle:0 endAngle:M_PI *2.0 clockwise:NO];
    anim.delegate = self;
//    anim.fromValue = (__bridge id _Nullable)(fromPath.CGPath);
//    anim.toValue = (__bridge id _Nullable)(toPath.CGPath);
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.values = @[(id)fromPath.CGPath,(id)toPath.CGPath];
    anim.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.shapeLayer addAnimation:anim forKey:@"path"];
    if (self.params.enableFlashing) {
        [self startFlash];
    }
}

///闪烁动画，使用displayLink修改shapeLayer的strokeColor
- (void)startFlash
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
        //每秒调用6次
        self.displayLink.preferredFramesPerSecond = 6;
    }else{
        //每隔10帧调用一次，对于iOS设备60Hz的刷新率来说，相当于每秒调用6次
        self.displayLink.frameInterval = 10; //DEPRECATED after iOS 10
    }
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)flashAction
{
    NSInteger colorIdx = ((int)arc4random())%self.params.colorRandom.count;
    self.shapeLayer.strokeColor = self.params.colorRandom[colorIdx].CGColor;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.shapeLayer removeAllAnimations];
        SQShineAngleLayer *angleLayer = [[SQShineAngleLayer alloc] initWithFrame:self.bounds params:self.params];
        [self addSublayer:angleLayer];
        [angleLayer startAnim];
    }
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.shapeLayer.strokeColor = _fillColor.CGColor;
}


@end
