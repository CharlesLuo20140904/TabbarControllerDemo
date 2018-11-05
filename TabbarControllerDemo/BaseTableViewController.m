//
//  BaseTableView.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/21.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ActivityViewController.h"
#import "CoreImageDemoViewController.h"
#import <AsyncSocket.h>
#import <ReactiveCocoa.h>
#import "CollectionDempViewController.h"
#import "CustomLayoutViewController.h"
#import "SearchBarDemoViewController.h"
#import "PasteBoardDemoViewController.h"
#import "RuntimeDemoViewController.h"

@interface BaseTableViewController ()
@property (strong, nonatomic) NSArray * textLabelTextArr;
@property (strong, nonatomic) NSArray * detailTextLabelTextArr;
@property (strong, nonatomic) NSString * input;
@end

@implementation BaseTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
//    self.tableView.allowsMultipleSelection = YES;
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor = [UIColor whiteColor];
    self.textLabelTextArr = @[@"分享",@"滤镜",@"socket",@"卡片式布局",@"自定义layout",@"自定义searchBar",@"粘贴板",@"动态创建类"];
    self.detailTextLabelTextArr = @[@"UIActivityViewController",@"coreImage",@"AsyncSocket",@"collectionView",@"自定义lyout",@"自定义searchBar",@"UIPasteboard",@"runtime"];
    [RACObserve(self, input)
     subscribeNext:^(NSString* x){
         //发送一个请求
         NSLog(@"%@",@"input is change");
     }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)edit{
    [self.tableView setEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textLabelTextArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView* headView = [[UIView alloc] init];
//    headView.backgroundColor = [UIColor greenColor];
//    return headView;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.detailTextLabel.text = self.detailTextLabelTextArr[indexPath.row];
    cell.textLabel.text = self.textLabelTextArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* controllers = @[@"ActivityViewController",@"",@"CoreImageDemoViewController",@"CollectionDempViewController",@"CustomLayoutViewController",@"SearchBarDemoViewController",@"PasteBoardDemoViewController",@"RuntimeDemoViewController"];
    [self pushControllerWithControllerNmae:controllers[indexPath.row]];
}

-(void)pushControllerWithControllerNmae:(NSString*)controllerName{
    if (controllerName.length != 0) {
        id object = [[NSClassFromString(controllerName) alloc] init];
        [self.navigationController pushViewController:object animated:YES];
    }
}

/**
    id ViewController = objc_getClass();
    id SBApplication = objc_getClass("SBApplication");
    LSApplicationWorkspace * app = [objc_getClass("LSApplicationWorkspace") defaultWorkspace];
**/
@end
