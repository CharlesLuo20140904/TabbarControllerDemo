//
//  CustomLayoutViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/15.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "CustomLayoutViewController.h"
#import "CircularLayout.h"
#import "HorizationLayout.h"
#import "DefaultLayout.h"

@interface CustomLayoutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) CircularLayout* layout;
@property (strong, nonatomic) HorizationLayout* hLayout;
@property (strong, nonatomic) DefaultLayout* defalutLayout;
@property (strong, nonatomic) NSMutableArray* dataArr;
@end

@implementation CustomLayoutViewController

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        self.layout = [[CircularLayout alloc] init];
        self.hLayout = [[HorizationLayout alloc] init];
        self.defalutLayout = [[DefaultLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith, ScreenHeight) collectionViewLayout:self.defalutLayout];
        _collectionView.backgroundColor = RANDOM_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(startEdit:)];
        UIBarButtonItem* changeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(changeLayout:)];
        self.navigationItem.rightBarButtonItems = @[editItem,changeItem];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.dataArr = [NSMutableArray arrayWithArray:@[@"a",@"s",@"c",@"c",@"c",@"c",@"c",@"c",@"c",@"c",@"c",@"c"]];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWith-15.0f)/10, (ScreenWith-15.0f)/10+30.0f);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


-(void)startEdit:(UIBarButtonItem*)item{
    [self.dataArr insertObject:@"c" atIndex:self.dataArr.count-1];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.dataArr.count-1 inSection:0]]];
}

-(void)changeLayout:(UIBarButtonItem*)item{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:self.layout animated:YES];
    }else if ([self.collectionView.collectionViewLayout isKindOfClass:[CircularLayout class]]) {
        [self.collectionView setCollectionViewLayout:self.hLayout animated:YES];
    }else{
        [self.collectionView setCollectionViewLayout:self.defalutLayout animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
