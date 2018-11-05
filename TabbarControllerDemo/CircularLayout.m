//
//  CircularLayout.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/15.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "CircularLayout.h"

@implementation CircularLayout

- (NSMutableArray *)attrsArray{
    if (_attrsArray == nil){
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    //移除所有旧的布局属性
    [self.attrsArray removeAllObjects];
    //获取元素的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //布局所有的元素
    for (NSInteger i = 0; i<count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //设置并获取indexPath位置元素的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        //将indexPath位置元素的布局属性添加到所有布局属性数组中
        [self.attrsArray addObject:attrs];
    }
}

//布局indexPath位置的元素
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //获取元素的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    /**设置圆心布局*/
    //设置圆形的半径
    CGFloat radius = 70;
    //圆心的位置
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
    //获取indexPath位置的元素的布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置尺寸
    attrs.size = CGSizeMake(50, 50);
    //设置位置
    if (count == 1)
    {
        attrs.center = CGPointMake(oX, oY);
    }
    else
    {
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        CGFloat centerX = oX + radius * sin(angle);
        CGFloat centerY = oY + radius * cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    }
    //返回indexPath位置元素的布局属性
    return attrs;
}

//布局指定区域内所有的元素
- (UICollectionViewLayoutAttributes*)layoutAttributesForElementsInRect:(CGRect)rect{
    //返回所有元素的布局属性
    return (UICollectionViewLayoutAttributes*)self.attrsArray;
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake((arc4random()%(int)CGRectGetMidX(self.collectionView.bounds))+0, (arc4random()%(int)CGRectGetMaxY(self.collectionView.bounds))+0);
    
    return attr;
}

/****************************
 - (void)prepareLayout
 {
 //通常在该方法中完成布局的初始化操作
 }
 当尺寸改变时，是否更新布局
 - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
 {
 //默认返回YES
 }
 布局UICollectionView的元素
 - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
 {
 //该方法需要返回rect区域中所有元素布局属性的数组
 }
 - (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 //该方法返回indexPath位置的元素的布局属性
 }
 修改UICollectionView停止滚动时的偏移量
 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
 {
 //返回值是，UICollectionView最终停留的点
 }
 ****************************/

@end
