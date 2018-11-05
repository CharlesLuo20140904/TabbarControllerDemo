//
//  HorizationLayout.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/15.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "HorizationLayout.h"

@implementation HorizationLayout

- (void)prepareLayout
{
    [super prepareLayout];
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
//指定当尺寸改变时，更新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
//设置所有元素的布局属性
- (nullable NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获取rect区域中所有元素的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //获取UICollectionView的中点，以contentView的左上角为原点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //重置rect区域中所有元素的布局属性，即基于他们距离UICollectionView的中点的剧烈，改变其大小
    for (UICollectionViewLayoutAttributes *attribute in array)
    {
        //获取距离中点的距离
        CGFloat delta = ABS(attribute.center.x - centerX);
        //计算缩放比例
        CGFloat scale = 1 - delta / self.collectionView.bounds.size.width;
        //设置布局属性
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    //返回所有元素的布局属性
    return [array copy];
}

//设置UICollectionView停止滚动是的偏移量，使其为与中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算最终显示的矩形框
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    //获取最终显示在矩形框中的元素的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //获取UICollectionView的中点，以contentView的左上角为原点
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //获取所有元素到中点的最短距离
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attribute in array)
    {
        CGFloat delta = attribute.center.x - centerX;
        if (ABS(minDelta) > ABS(delta))
        {
            minDelta = delta;
        }
    }
    
    //改变UICollectionView的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
