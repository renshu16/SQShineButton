//
//  ViewController.m
//  ShineButtom
//
//  Created by ToothBond on 17/2/18.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "ViewController.h"
#import "SQShineButton.h"

@interface ViewController ()
{
    SQShineClickLayer *clickLayer;
    SQShineLayer *cycleLayer;
    SQShineAngleLayer *angleLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SQShineButton *heartBtn = [[SQShineButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];

    [heartBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heartBtn];
    
    
    
    //单独测试 layer
    clickLayer = [[SQShineClickLayer alloc] init];
    clickLayer.frame = CGRectMake(100, 200, 60, 60);
    [self.view.layer addSublayer:clickLayer];

    cycleLayer = [[SQShineLayer alloc] init];
    cycleLayer.frame = CGRectMake(100, 300, 60, 60);
    [self.view.layer addSublayer:cycleLayer];
    

    
}

- (void)action:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__FUNCTION__);
    [clickLayer startAnim];
    
    [cycleLayer startAnim];
    
    SQShineParams *params = [[SQShineParams alloc] init];
    angleLayer = [[SQShineAngleLayer alloc] initWithFrame:CGRectMake(100, 400, 60, 60) params:params];
    [self.view.layer addSublayer:angleLayer];
    [angleLayer startAnim];
    
    
}


@end
