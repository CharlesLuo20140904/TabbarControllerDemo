//
//  SearchBarDemoViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/18.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "SearchBarDemoViewController.h"

@interface SearchBarDemoViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar* searchBar;
@end

@implementation SearchBarDemoViewController

-(UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 64.0f, ScreenWith, 40.0f)];
        _searchBar.delegate = self;
        _searchBar.barStyle = 0;                            //设置类型，1和2背景为黑色
//        _searchBar.backgroundColor = [UIColor greenColor];  //后背景颜色
//        _searchBar.prompt = @"let me guess";              //提示内容，居中显示，编辑时也存在
        _searchBar.placeholder = @"请输入需要搜索的内容";      //提示文字
        _searchBar.tintColor = [UIColor yellowColor];       //光标颜色
//        _searchBar.barTintColor = [UIColor redColor];       //前背景颜色
//        _searchBar.showsBookmarkButton = YES;             //编辑的时候出现翻书的button
//        _searchBar.showsCancelButton = YES;               //显示编辑的按钮
//        _searchBar.showsSearchResultsButton = YES;        //显示搜索历史列表按钮
        _searchBar.searchBarStyle = UISearchBarStyleDefault;// UISearchBarStyleMinimal无边框，呈圆角矩形
        _searchBar.showsScopeBar = YES;                     //范围栏
        _searchBar.scopeButtonTitles = @[@"英语",@"中文",@"甲骨文"];
        _searchBar.selectedScopeButtonIndex = 2;            //默认甲骨文为选中状态
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"second_bluetooth"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];//设置背景图片
    }
    return _searchBar;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
}

//默认返回yes，如果是no，则不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"开始编辑");
}

//如果no，则一直都是第一响应者，即是键盘一直显示
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"编辑结束");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"编辑内容发生改变");
}

//在内容改编之前执行
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"键盘的搜索按钮被摸了");
}

//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
//- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
//
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"我的搜索范围是%@",searchBar.scopeButtonTitles[selectedScope]);
}


@end
