//
//  SQShineAngleLayer.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineAngleLayer.h"

@interface SQShineAngleLayer()<CAAnimationDelegate>
{
    int flashCount;
}

@property(nonatomic,strong)NSMutableArray<CAShapeLayer*> *shineLayers;
@property(nonatomic,strong)NSMutableArray<CAShapeLayer*> *smallShineLayers;

@property(nonatomic,retain)CADisplayLink* displayLink;

@end

@implementation SQShineAngleLayer

- (instancetype)initWithFrame:(CGRect )frame params:(SQShineParams *)params
{
    if (self = [super init]) {
        self.frame = frame;
        _params = params;
        _shineLayers = [[NSMutableArray alloc] init];
        _smallShineLayers = [[NSMutableArray alloc] init];
        [self addShines];
    }
    return self;
}

- (void)addShines
{
    CGFloat startAngle = 0;
    CGFloat angle = M_PI*2/self.params.shineCount + startAngle;
    if (self.params.shineCount %2 != 0) {
        startAngle = M_PI*2 - angle/2;
    }
    CGFloat radius = self.frame.size.width/2 * self.params.shineDistanceMutiple;
    CGFloat bigWidth = radius * 0.25;
    CGFloat smallWidth = bigWidth*0.66;
    
    for (int i=0; i<self.params.shineCount; i++) {
        //绘制大shine
        CAShapeLayer *bigShine = [[CAShapeLayer alloc] init];
        if (self.params.shineRadius != 0) {
            bigWidth = self.params.shineRadius;
        }
        CGPoint center = [self getShineCenter:startAngle + angle*i radius:radius];
        CGPathRef path = [UIBezierPath bezierPathWithArcCenter:center radius:bigWidth
                                                    startAngle:0 endAngle:2*M_PI clockwise:NO].CGPath;
        bigShine.path = path;
        if (self.params.allowRandomColor) {
            bigShine.fillColor = self.params.colorRandom[((int)arc4random())%self.params.colorRandom.count].CGColor;
        }else{
            bigShine.fillColor = self.params.bigShieColor.CGColor;
        }
        [self addSublayer:bigShine];
        [self.shineLayers addObject:bigShine];
        //绘制小太阳
        CAShapeLayer *smallShine = [[CAShapeLayer alloc] init];
        CGFloat smallAngle = startAngle + angle*i - self.params.smallShineOffsetAngle*M_PI/180;
        CGPoint smallCenter = [self getShineCenter:smallAngle radius:radius - bigWidth];
        CGPathRef smallPath = [UIBezierPath bezierPathWithArcCenter:smallCenter radius:smallWidth
                                                         startAngle:0 endAngle:M_PI*2 clockwise:NO].CGPath;
        smallShine.path = smallPath;
        if (self.params.allowRandomColor) {
            smallShine.fillColor = self.params.colorRandom[((int)arc4random())%self.params.colorRandom.count].CGColor;
        }else{
            smallShine.fillColor = self.params.smallShineColor.CGColor;
        }
        [self addSublayer:smallShine];
        [self.smallShineLayers addObject:smallShine];
    }
}


/**
 计算shine的中点坐标
 */
- (CGPoint)getShineCenter:(CGFloat)angle radius:(CGFloat)radius
{
    CGFloat x0 = self.bounds.size.width/2;
    CGFloat y0 = self.bounds.size.height/2;
    int multiple = 0;
    if (angle >= 0 && angle <= 90 * M_PI/180) {
        multiple = 1;
    }
    else if(angle >= 90*M_PI/180 && angle <= M_PI){
        multiple = 2;
    }
    else if(angle >= M_PI && angle <= 270 *M_PI/180){
        multiple = 3;
    }
    else{
        multiple = 4;
    }
    CGFloat calcRadiusAngle = multiple * 90 * M_PI/180 - angle;
    CGFloat a = sin(calcRadiusAngle)*radius;
    CGFloat b = cos(calcRadiusAngle)*radius;
    if (multiple == 1) {
        return CGPointMake(x0+b, y0-a);
    }else if(multiple == 2){
        return CGPointMake(x0+a, y0+b);
    }else if(multiple == 3){
        return CGPointMake(x0-b, y0+a);
    }else{
        return CGPointMake(x0-a, y0-b);
    }
}

- (void)startAnim
{
    CGFloat radius = self.frame.size.width/2 * self.params.shineDistanceMutiple * 1.4;
    CGFloat subRadius = self.frame.size.width/2 * self.params.shineDistanceMutiple * 0.15*0.66;
    CGFloat startAngle = 0;
    CGFloat angle = M_PI*2/self.params.shineCount + startAngle;
    if (self.params.shineCount %2 != 0) {
        startAngle = M_PI*2 - angle/self.params.shineCount;
    }
    for (int i=0; i<self.params.shineCount; i++) {
        CAShapeLayer *bigShine = self.shineLayers[i];
        CABasicAnimation *anim = [self getAngleAnim:bigShine angle:startAngle + angle*i radius:radius];
        CAShapeLayer *smallShine = self.smallShineLayers[i];
        CABasicAnimation *smallAnim = [self getAngleAnim:smallShine angle:startAngle + angle*i - self.params.smallShineOffsetAngle*M_PI/180 radius:radius - subRadius];
        [bigShine addAnimation:anim forKey:@"path"];
        [smallShine addAnimation:smallAnim forKey:@"path"];
        //透明度渐变动画
        if (self.params.enableFlashing) {
//            CABasicAnimation *flash = [self getFlashAnim];
//            CABasicAnimation *smallFlash = [self getFlashAnim];
//            [bigShine addAnimation:flash forKey:@"bigFlash"];
//            [smallShine addAnimation:smallFlash forKey:@"smallFlash"];
        }
    }
    
    //旋转动画，结合扩散动画同时进行，看起来的效果是带有弧度的扩散
    CABasicAnimation *angleAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    angleAnim.duration = self.params.animDuration * 0.87;
    angleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    angleAnim.fromValue = @0;
    angleAnim.toValue = @(self.params.shineTurnAngle *M_PI/180);
    angleAnim.delegate = self;
    [self addAnimation:angleAnim forKey:@"rotate"];
    if (self.params.enableFlashing) {
        [self startFlash];
    }
}

- (void)startFlash
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
        _displayLink.preferredFramesPerSecond = 6;
    }else{
        _displayLink.frameInterval = 10;
    }
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)flashAction
{
    NSLog(@"%s %d",__FUNCTION__, flashCount++);
    for (int i=0; i<self.params.shineCount; i++) {
        CAShapeLayer *bigShine = self.shineLayers[i];
        bigShine.fillColor = self.params.colorRandom[(int)(arc4random())%self.params.colorRandom.count].CGColor;
        CAShapeLayer *smallShine = self.smallShineLayers[i];
        smallShine.fillColor = self.params.colorRandom[(int)(arc4random())%self.params.colorRandom.count].CGColor;
    }
}

- (CABasicAnimation *)getFlashAnim
{
    CABasicAnimation *flashAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flashAnim.fromValue = @1;
    flashAnim.toValue = @0;
    flashAnim.duration = (arc4random()%20 + 60)/1000;
    flashAnim.repeatCount = MAXFLOAT;
    flashAnim.removedOnCompletion = NO;
    flashAnim.autoreverses = YES;
    flashAnim.fillMode = kCAFillModeForwards;
    return flashAnim;
}

//shine扩散的动画
- (CABasicAnimation *)getAngleAnim:(CAShapeLayer *)shine angle:(CGFloat)angle radius:(CGFloat)radius
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = self.params.animDuration * 0.87;
    anim.fromValue = (id)shine.path;
    CGPoint center = [self getShineCenter:angle radius:radius];
    CGPathRef path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:2*M_PI clockwise:NO].CGPath;
    anim.toValue = (__bridge id)path;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    return anim;
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self removeAllAnimations];
        [self removeFromSuperlayer];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

@end
