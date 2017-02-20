//
//  SQShineParams.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/18.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQShineParams.h"

@implementation SQShineParams

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animDuration = 1;
        _bigShieColor = RGBCOLOR(255, 102, 102);
        _shineCount = 7;
        _shineTurnAngle = 20;
        _enableFlashing = YES;
        _shineDistanceMutiple = 1.5;
        _smallShineOffsetAngle = 20;
        _smallShineColor = [UIColor lightGrayColor];
        
        _colorRandom = @[RGBCOLOR(255, 255, 153),
                         RGBCOLOR(255, 204, 204),
                         RGBCOLOR(153, 102, 153),
                         RGBCOLOR(255, 102, 102),
                         RGBCOLOR(255, 255, 102),
                         RGBCOLOR(244, 67, 54),
                         RGBCOLOR(102, 102, 102),
                         RGBCOLOR(204, 204, 0),
                         RGBCOLOR(102, 102, 102),
                         RGBCOLOR(153, 153, 51)];
    }
    
    return self;
}

+ (UIImage *)imageFromBundle:(NSString *)imageName
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"WCLShineButton" ofType:@"bundle"];
    NSBundle *resBundle = [NSBundle bundleWithPath:path];
    
    NSBundle *imageBundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@%@",resBundle.bundlePath,@"/resource"]];
    
    NSString *fileName = [imageBundle pathForResource:imageName ofType:@"png"];
    NSLog(@"fileName = %@",fileName);
    return [UIImage imageWithContentsOfFile:fileName];
}

@end
