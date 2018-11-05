//
//  CollectionDempViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/6.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "CollectionDempViewController.h"
#import "DemoCollectionViewCell.h"

@interface CollectionDempViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DemoCellDelegate>
@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) NSArray* widthArr;
//@property (strong)
@end

@implementation CollectionDempViewController

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith, ScreenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"typecell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"productcell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.widthArr = @[@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3*2+5.0f),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3),@((ScreenWith-20.0f)/3)];
    [self.view addSubview:self.collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 3;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake([self.widthArr[indexPath.row] floatValue],(ScreenWith-20.0f)/3);
    }else{
        return CGSizeMake((ScreenWith-15.0f)/2, (ScreenWith-15.0f)/2+30.0f);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
        
    }else{
        return CGSizeMake(ScreenWith, 40.0f);
    }
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return nil;
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, ScreenWith, 20.0f)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"更多商品";
            titleLabel.textColor = [UIColor colorWithRed:190.0f/255 green:31.0f/255 blue:44.0f/255 alpha:1.0f];
            [headerView addSubview:titleLabel];
            return headerView;
        }else{
            return nil;
        }
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DemoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typecell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.backgroundColor = [UIColor greenColor];
        CGRect rect = cell.frame;
        cell.frame = rect;
        return cell;
    }else{
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productcell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
}

-(void)moveWithCell:(id)cell{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
}

-(void)updateWithGesture:(UILongPressGestureRecognizer *)gesture{
    [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
}

-(void)end{
    [self.collectionView endInteractiveMovement];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //请在这里做数据的转换
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
