//
//  SQShineLayer.h
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SQShineParams.h"
#import "SQShineAngleLayer.h"

@interface SQShineLayer : CALayer

@property(nonatomic,retain)UIColor* fillColor;
@property(nonatomic,retain)SQShineParams* params;


- (void)startAnim;

@end
