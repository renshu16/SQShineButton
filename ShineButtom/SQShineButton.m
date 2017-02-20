//
//  SQShineButton.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/18.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineButton.h"


@interface SQShineButton()

@property(nonatomic,retain)SQShineParams *params;

@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *fillColor;
@property(nonatomic,retain)UIImage *image;

@property(nonatomic,strong)SQShineClickLayer *clickLayer;
@property(nonatomic,strong)SQShineLayer *shineLayer;
@property(nonatomic,strong)SQShineAngleLayer *angleLayer;


@end

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
    
//    _angleLayer = [[SQShineAngleLayer alloc] initWithFrame:self.bounds params:self.params];
//    [self.layer addSublayer:_angleLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.clickLayer.clicked == NO) {
        self.clickLayer.clicked = !self.clickLayer.clicked;
        [self.clickLayer startAnim];
        [self.shineLayer startAnim];
        [self.angleLayer startAnim];
    }else{
        self.clickLayer.clicked = !self.clickLayer.clicked;
    }
    
}


@end
