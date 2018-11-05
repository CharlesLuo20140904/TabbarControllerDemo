//
//  PasteBoardDemoViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/18.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "PasteBoardDemoViewController.h"
#import "PasteCollectionView.h"

@interface PasteBoardDemoViewController ()
@property (strong, nonatomic) PasteCollectionView* pasteView;
@property (assign, nonatomic) BOOL menuVisible;
@end

@implementation PasteBoardDemoViewController

-(PasteCollectionView *)pasteView{
    if (_pasteView == nil) {
        _pasteView = [[PasteCollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith, (ScreenWith-30.0f)/2+30.0f)];
    }
    return _pasteView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(readDataFromPasteboard:)];
        self.navigationItem.rightBarButtonItem = barItem;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"复制粘贴"];
    [self.view addSubview:self.pasteView];
}

-(void)readDataFromPasteboard:(UIBarButtonItem*)item{
    [self setTitle:[NSString stringWithFormat:@"Pasteboard = %@",
                    [[UIPasteboard generalPasteboard] string]]];
}

@end
