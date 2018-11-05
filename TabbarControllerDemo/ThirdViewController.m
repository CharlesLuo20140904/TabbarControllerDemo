//
//  ThirdViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/8/21.
//  Copyright (c) 2015年 jecansoft. All rights reserved.
//

#import "ThirdViewController.h"
#import "BaseTableViewController.h"

@interface ThirdViewController ()
@property (strong, nonatomic) UIImageView * animationImageView;
@property (strong, nonatomic) UIImageView * anotherImageView;
@end

@implementation ThirdViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(showTableView)];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 100.0f, 70.0f)];
        self.animationImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://p1.55tuanimg.com/static/goods/richText/2014/10/15/15/b9902192a25e39066bc31f963fae2d8b_690_457.jpg"]]];
        [self.view addSubview:self.animationImageView];
        self.anotherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 270.0f, 100.0f, 70.0f)];
        self.anotherImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://p1.55tuanimg.com/static/goods/richText/2014/10/15/15/b9902192a25e39066bc31f963fae2d8b_690_457.jpg"]]];
        [self.view addSubview:self.anotherImageView];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.animationImageView.layer.transform = CATransform3DMakeRotation(M_PI/3, 0.0f, 1.0f, 0.0f);
    self.animationImageView.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)showTableView{
    BaseTableViewController * tableController = [[BaseTableViewController alloc] init];
    [self.navigationController pushViewController:tableController animated:YES];
}
@end
