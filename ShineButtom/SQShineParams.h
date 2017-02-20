//
//  SQShineParams.h
//  ShineButtom
//
//  Created by ToothBond on 17/2/18.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface SQShineParams : NSObject

@property(nonatomic,assign)BOOL allowRandomColor;
@property(nonatomic,assign)double animDuration;
@property(nonatomic,retain)UIColor *bigShieColor;
@property(nonatomic,assign)BOOL enableFlashing;
@property(nonatomic,assign)int shineCount;
@property(nonatomic,assign)float shineTurnAngle;
@property(nonatomic,assign)float shineDistanceMutiple;
@property(nonatomic,assign)float smallShineOffsetAngle;
@property(nonatomic,retain)UIColor *smallShineColor;
@property(nonatomic,assign)CGFloat shineSize;

@property(nonatomic,retain)NSArray<UIColor *> *colorRandom;

+ (UIImage *)imageFromBundle:(NSString *)imageName;

@end

