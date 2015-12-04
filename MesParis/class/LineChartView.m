//
//  LineChartView.m
//  DrawDemo
//
//  Created by 东子 Adam on 12-5-31.
//  Copyright (c) 2012年 热频科技. All rights reserved.
//

#import "LineChartView.h"

@interface LineChartView()
{
    CALayer *linesLayer;
    
    
    UIView *popView;
    UILabel *disLabel;
}

@end

@implementation LineChartView

@synthesize array;

@synthesize hInterval,vInterval;

@synthesize hDesc,vDesc;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        hInterval = 30;
        vInterval = 40;
        
        linesLayer = [[CALayer alloc] init];
        linesLayer.masksToBounds = YES;
        linesLayer.contentsGravity = kCAGravityLeft;
        linesLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        
        [self.layer addSublayer:linesLayer];
    }
    return self;
}

#define ZeroPoint CGPointMake(10,260)

- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画背景线条------------------
    CGColorRef backColorRef = [UIColor clearColor].CGColor;
    CGFloat backLineWidth = 1.f;
    CGFloat backMiterLimit = 0.f;
    
    CGContextSetLineWidth(context, backLineWidth);//主线宽度
    CGContextSetMiterLimit(context, backMiterLimit);//投影角度  
    
    //CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 4, backColorRef);//设置双条线
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    

    
    int x = 260 ;
    int y = 140 ;

    for (int i=0; i<vDesc.count; i++) {
        
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 10)];
        [label setCenter:CGPointMake(bPoint.x-20, bPoint.y-10)];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[vDesc objectAtIndex:i]];
        [self addSubview:label];
        
        CGContextMoveToPoint(context, bPoint.x, bPoint.y-10);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-10);
        
        y -= 15;
        
    }
    
    for (int i=0; i<hDesc.count-1; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*vInterval+40, 120, 40, 60)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        label.numberOfLines = 1;
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumFontSize = 1.0f;
        [label setText:[hDesc objectAtIndex:i]];
        
        [self addSubview:label];
    }
    
    
//    //画点线条------------------
    CGFloat pointLineWidth = 2.0f;
    CGFloat pointMiterLimit = 0.0f;
    
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度  

    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

	//绘图
    if (array.count > 0) {
        CGPoint p1 = [[array objectAtIndex:0] CGPointValue];
        int i = 1;
        CGContextMoveToPoint(context, p1.x+30, 130-p1.y);
        for (; i<[array count]; i++)
        {
            p1 = [[array objectAtIndex:i] CGPointValue];
            CGPoint goPoint = CGPointMake(p1.x+15, 120-p1.y*vInterval/8);
            //if(i > 1)
            CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
            
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [bt setBackgroundColor:[UIColor colorWithRed:0.1 green:0.85 blue:0.85 alpha:1]];
            
            [bt setFrame:CGRectMake(0, 0, 7, 7)];
            bt.layer.cornerRadius = 3;
            [bt setCenter:goPoint];
            
            [self addSubview:bt];
            
        }
    }
	
	CGContextStrokePath(context);
    
}


@end
