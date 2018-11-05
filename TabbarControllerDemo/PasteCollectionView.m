//
//  PasteCollectionView.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/19.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "PasteCollectionView.h"
#import "PasteCollectionCell.h"

@interface PasteCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PasteCellDelegate>
@property (strong, nonatomic) UICollectionView* collectionView;
@end

@implementation PasteCollectionView

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith, ScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = RANDOM_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[PasteCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0f, 10.0f, 5.0f, 10.0f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWith-30.0f)/2, (ScreenWith-30.0f)/2+25.0f);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PasteCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"second_bluetooth"];
        cell.nameLabel.text = @"funny guy";
    }
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
}

-(void)showPasteboardMenuForView:(id)view{
    UIView*clickView = (UIView*)view;
    [clickView.superview becomeFirstResponder];
    UIMenuController* menuController = [UIMenuController sharedMenuController];
    [menuController setTargetRect:clickView.frame inView:clickView.superview];
    [menuController setMenuVisible:YES animated:YES];
}

@end
