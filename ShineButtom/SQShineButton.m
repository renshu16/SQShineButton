//
//  SQShineButton.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/18.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineButton.h"


@interface SQShineButton()

@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *fillColor;
@property(nonatomic,retain)UIImage *image;

@property(nonatomic,strong)SQShineClickLayer *clickLayer;
@property(nonatomic,strong)SQShineLayer *shineLayer;


@end


/**
 将多个动画组合起来
 1.----------按钮image缩放动画(SQShineClickLayer)---------
 2.--圆环缩放动画(SQShineLayer)--
 3.              ----------shine扩展动画(SQShineAngleLayer)--------
 */
@implementation SQShineButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _params = [[SQShineParams alloc] init];
        [self initLayers];
    }
    return self;
}

- (void)initLayers
{
    _clickLayer = [[SQShineClickLayer alloc] init];
    _clickLayer.frame = self.bounds;
    [self.layer addSublayer:_clickLayer];
    
    _shineLayer = [[SQShineLayer alloc] init];
    _shineLayer.frame = self.bounds;
    [self.layer addSublayer:_shineLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.clickLayer.clicked == NO) {
        self.clickLayer.clicked = !self.clickLayer.clicked;
        [self.clickLayer startAnim];
        [self.shineLayer startAnim];
    }else{
        self.clickLayer.clicked = !self.clickLayer.clicked;
    }
    
}

- (void)setParams:(SQShineParams *)params
{
    _params = params;
    self.shineLayer.params = _params;
}

@end
