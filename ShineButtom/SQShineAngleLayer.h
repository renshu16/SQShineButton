//
//  SQShineAngleLayer.h
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SQShineParams.h"

@interface SQShineAngleLayer : CALayer

@property(nonatomic,retain)SQShineParams *params;

- (instancetype)initWithFrame:(CGRect )frame params:(SQShineParams *)params;
- (void)startAnim;


@end
