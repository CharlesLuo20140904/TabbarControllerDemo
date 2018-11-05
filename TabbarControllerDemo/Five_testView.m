//
//  Five_testView.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/10.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "Five_testView.h"

@implementation Five_testView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    //pickingFieldWidth:圆形框的直径
//    CGFloat pickingFieldWidth = width < height ? (width - kWidthGap) : (height - kHeightGap);
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(contextRef);
//    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);
//    CGContextSetLineWidth(contextRef, 3);
//    //计算圆形框的外切正方形的frame：
//    self.pickingFieldRect = CGRectMake((width - pickingFieldWidth) / 2, (height - pickingFieldWidth) / 2, pickingFieldWidth, pickingFieldWidth);
//    //创建圆形框UIBezierPath:
//    UIBezierPath *pickingFieldPath = [UIBezierPath bezierPathWithOvalInRect:self.pickingFieldRect];
//    //创建外围大方框UIBezierPath:
//    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
//    //将圆形框path添加到大方框path上去，以便下面用奇偶填充法则进行区域填充：
//    [bezierPathRect appendPath:pickingFieldPath];
//    //填充使用奇偶法则
//    bezierPathRect.usesEvenOddFillRule = YES;
//    [bezierPathRect fill];
//    CGContextSetLineWidth(contextRef, 2);
//    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
//    CGFloat dash[2] = {4,4};
//    [pickingFieldPath setLineDash:dash count:2 phase:0];
//    [pickingFieldPath stroke];
//    CGContextRestoreGState(contextRef);
//    self.layer.contentsGravity = kCAGravityCenter;
}

@end
