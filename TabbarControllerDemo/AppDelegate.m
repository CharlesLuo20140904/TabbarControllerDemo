//
//  AppDelegate.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/8/20.
//  Copyright (c) 2015年 jecansoft. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ThourthViewController.h"
#import "FivethViewController.h"

@interface AppDelegate ()
{
    BOOL isClick;
}
@property (strong, nonatomic) NSMutableArray * viewArr;
@property (strong, nonatomic) NSMutableArray * refArr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FirstViewController * firstController = [[FirstViewController alloc] init];
    SecondViewController * secondController = [[SecondViewController alloc] init];
    ThirdViewController * thirdController = [[ThirdViewController alloc] init];
    ThourthViewController * thourController = [[ThourthViewController alloc] init];
    FivethViewController * fivethController = [[FivethViewController alloc] init];
    NSArray * controllers = @[firstController,secondController,thirdController,thourController,fivethController];
    NSMutableArray * ncArr = [NSMutableArray array];
    NSArray * titleArr = @[@"爆米花",@"咖啡",@"粮油",@"美酒",@"南瓜"];
    for (int i=0; i<5; i++) {
        UIViewController * controller = controllers[i];
        controller.view.backgroundColor = [UIColor colorWithRed:((arc4random()%255)+0)/255.0f green:((arc4random()%255)+0)/255.0f blue:((arc4random()%255)+0)/255.0f alpha:1.0f];
        controller.title = titleArr[i];
        UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:controller];
        [ncArr addObject:nc];
    }
    UITabBarController * tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = ncArr;
    self.window.rootViewController = tbc;
    UITabBar * tabbar = tbc.tabBar;
    UITabBarItem * item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem * item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem * item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem * item4 = [tabbar.items objectAtIndex:3];
    UITabBarItem * item5 = [tabbar.items objectAtIndex:4];
    item1.image = [[UIImage imageNamed:@"爆米花"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"爆米花--当前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"咖啡"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"咖啡--当前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"粮油"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"粮油--当前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"美酒"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"美酒--当前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.image = [[UIImage imageNamed:@"南瓜"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = [[UIImage imageNamed:@"南瓜--当前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:179.0f/255 green:34.0f/255 blue:44.0f/255 alpha:1.0f],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:179.0f/255 green:34.0f/255 blue:44.0f/255 alpha:1.0f]}];
    [self keyAnimation];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)keyAnimation{
    self.viewArr = [NSMutableArray array];
    self.refArr = [NSMutableArray array];
    UITabBarController * controller = (UITabBarController*)self.window.rootViewController;
    UINavigationController * nc = controller.viewControllers[0];
    UIViewController * vc = nc.viewControllers[0];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 25.0f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btn];
    for (int i=0; i<3; i++) {
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(btn.center.x-5.0f, btn.center.y-5.0f, 10.0f, 10.0f)];
        v.backgroundColor = [UIColor lightGrayColor];
        v.layer.cornerRadius = 5.0f;
        v.layer.masksToBounds = YES;
        [vc.view addSubview:v];
        [self.viewArr addObject:v];
    }
    CGMutablePathRef ref1 = CGPathCreateMutable();
    CGPathMoveToPoint(ref1, NULL, btn.center.x, btn.center.y);
    CGPathAddLineToPoint(ref1, NULL, btn.center.x+50.0f, btn.center.y);
    [self.refArr addObject:(__bridge id)(ref1)];
    CGPathRelease(ref1);
    CGMutablePathRef ref2 = CGPathCreateMutable();
    CGPathMoveToPoint(ref2, NULL, btn.center.x, btn.center.y);
    CGPathAddLineToPoint(ref2, NULL, btn.center.x+50.0f, btn.center.y);
    CGPathAddQuadCurveToPoint(ref2, NULL, btn.center.x+25.0f, btn.center.y+50.0f, btn.center.x, btn.center.y+50.0f);
    [self.refArr addObject:(__bridge id)(ref2)];
    CGPathRelease(ref2);
    CGMutablePathRef ref3 = CGPathCreateMutable();
    CGPathMoveToPoint(ref3, NULL, btn.center.x, btn.center.y);
    CGPathAddLineToPoint(ref3, NULL, btn.center.x+50.0f, btn.center.y);
    CGPathAddQuadCurveToPoint(ref3, NULL, btn.center.x, btn.center.y+75.0f, btn.center.x-50.0f, btn.center.y);
    [self.refArr addObject:(__bridge id)(ref3)];
    CGPathRelease(ref3);
}

- (void)showMenu:(UIButton*)btn{
    isClick = !isClick;
    if (isClick) {
        for (int i=0; i<self.viewArr.count; i++) {
            UIView * v = [self.viewArr objectAtIndex:i];
            [v.layer addAnimation:[self createAnimation:(__bridge CGMutablePathRef)(self.refArr[i])] forKey:@"1"];
        }
    }else{
        for (int i=0; i<self.viewArr.count; i++) {
            UIView * v = [self.viewArr objectAtIndex:i];
            [v.layer removeAllAnimations];
        }
    }
}

- (CAKeyframeAnimation*)createAnimation:(CGMutablePathRef)ref{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = ref;
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 1;
    return animation;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
