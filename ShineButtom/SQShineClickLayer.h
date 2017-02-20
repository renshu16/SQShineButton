//
//  SQShineClickLayer.h
//  ShineButtom
//
//  Created by ToothBond on 17/2/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface SQShineClickLayer : CALayer

@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *fillColor;
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,assign)double animDuration;

@property(nonatomic,assign)BOOL clicked;

- (void)startAnim;

@end
