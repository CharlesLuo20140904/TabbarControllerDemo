//
//  DefaultLayout.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/18.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "DefaultLayout.h"

@implementation DefaultLayout

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake((arc4random()%(int)CGRectGetMidX(self.collectionView.bounds))+0, (arc4random()%(int)CGRectGetMaxY(self.collectionView.bounds))+0);
    
    return attr;
}

@end
