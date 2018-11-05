//
//  FivethViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/8/21.
//  Copyright (c) 2015年 jecansoft. All rights reserved.
//

#import "FivethViewController.h"
#import "UIProgressView+addMethod.h"

@interface FivethViewController(){
    dispatch_source_t timer;
    dispatch_source_t stdinSource;
}
@property (strong, nonatomic) UIProgressView * progressIndicator;
@property (strong, nonatomic) UIImageView * imageView1;
@property (strong, nonatomic) UIImageView * imageView2;
@property (strong, nonatomic) UIImageView * imageView3;
@property (strong, nonatomic) UIView * currentView;
@property (strong, nonatomic) UIView * testView;
@property (strong , nonatomic) NSMutableArray * imageViewArr;

@property (strong, nonatomic) UIButton * clickButton1;
@property (strong, nonatomic) UIButton * clickButton2;
@property (strong, nonatomic) UIButton * clickButton3;
@property (strong, nonatomic) UIButton * clickButton4;
@end

@implementation FivethViewController
@synthesize progressIndicator;

-(UIButton *)clickButton1{
    if (_clickButton1 == nil) {
        _clickButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickButton1.backgroundColor = RANDOM_COLOR;
        _clickButton1.frame = CGRectMake(0.0f, 0.0f, 80.0f, 80.0f);
//        _clickButton1.maskView
        [self.clickButton1 addTarget:self action:@selector(clickB) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton1;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        progressIndicator = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//        progressIndicator.frame = CGRectMake(0.0f, 100.0f, 300.0f, 10.0f);
//        progressIndicator.progress = 0.0f;
////        progressIndicator.progressTintColor = [UIColor redColor];
////        progressIndicator.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:progressIndicator];
        
        self.imageViewArr = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 0.0f, ScreenWith-40.0f-20.0f*(2-i), ScreenWith-40.0f)];
            imageView.layer.cornerRadius = 10.0f;
            imageView.clipsToBounds = YES;
            imageView.center = CGPointMake(ScreenWith/2, ScreenHeight/2+10.0f*i);
            imageView.backgroundColor = RANDOM_COLOR;
            imageView.userInteractionEnabled = YES;
            UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImageViewFromLeft:)];
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            [imageView addGestureRecognizer:swipeLeft];
            UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImageViewFromRight:)];
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
            [imageView addGestureRecognizer:swipeRight];
            [self.view addSubview:imageView];
            switch (i) {
                case 0:
                    self.imageView1 = imageView;
                    break;
                    
                case 1:
                    self.imageView2 = imageView;
                    break;
                    
                case 2:
                    self.imageView3 = imageView;
                    break;
                default:
                    break;
            }
            [self.imageViewArr addObject:imageView];
        }
        
    }
    return self;
}

-(void)dismissImageViewFromLeft:(UISwipeGestureRecognizer*)swipe{
    [self keyAnimationWithLayer:swipe.view andEndPoint:-2*swipe.view.layer.position.x];
//    [swipe.view.layer removeAllAnimations];
//    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    basicAnimation.autoreverses=true; //动画结束后再回复到初始状态 (两个动画)
//    basicAnimation.repeatCount=HUGE_VALF;
//    basicAnimation.removedOnCompletion=NO;
//    basicAnimation.fillMode = kCAFillModeForwards;
//    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    basicAnimation.toValue = [NSNumber numberWithFloat:0.2];
//    [swipe.view.layer addAnimation:basicAnimation forKey:nil];
    
//    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
//    keyAnimation.keyPath = @"position";
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, swipe.view.layer.position.x, swipe.view.layer.position.y);
//    CGPathAddLineToPoint(path, NULL, -2*swipe.view.layer.position.x, swipe.view.layer.position.y);
//    keyAnimation.path = path;
////    keyAnimation.autoreverses = YES;
//    keyAnimation.delegate = self;
//    keyAnimation.removedOnCompletion = NO;
//    keyAnimation.fillMode = kCAFillModeForwards;
//    keyAnimation.duration = 0.5;
//    keyAnimation.repeatCount = 1;
//    [keyAnimation setValue:@"hao" forKey:@"tag"];
//    NSValue *key1=[NSValue valueWithCGPoint:swipe.view.layer.position];//对于关键帧动画初始值不能省略
//    NSMutableArray * pointArr = [NSMutableArray array];
//    [pointArr addObject:[NSValue valueWithCGPoint:[swipe locationInView:self.view]]];
//    CGPoint endPoint = [pointArr lastObject];
//    [allPoints addObject:key1];
//    [allPoints addObjectsFromArray:pointArr];
//    keyAnimation.values=allPoints;
//    
//    keyAnimation.duration = 1.0f;
//    keyAnimation.repeatCount = 10;
//    设置其他属性
//    keyAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
//    3.添加动画到图层，添加动画后就会执行动画
//    [swipe.view.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
////
//    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
//    //2.设置组中的动画和其他属性
//    animationGroup.animations=@[keyAnimation];
//    animationGroup.delegate=self;
//    animationGroup.duration=10;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
//    animationGroup.repeatCount = 1;
//    animationGroup.removedOnCompletion = NO;
//    animationGroup.fillMode = kCAFillModeBackwards;
//    animationGroup.autoreverses = NO;
//    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////    animationGroup.beginTime=CACurrentMediaTime()+5;//延迟五秒执行
//    //3.给图层添加动画
//    [swipe.view.layer addAnimation:keyAnimation forKey:@"KCGroupAnimation"];
//    self.currentView = swipe.view;
}

-(void)dismissImageViewFromRight:(UISwipeGestureRecognizer*)swipe{
    [self keyAnimationWithLayer:swipe.view andEndPoint:3*swipe.view.layer.position.x];
}

-(void)keyAnimationWithLayer:(UIView*)view andEndPoint:(CGFloat)endPointX{
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, view.layer.position.x, view.layer.position.y);
    CGPathAddLineToPoint(path, NULL, endPointX, view.layer.position.y);
    keyAnimation.path = path;
    //    keyAnimation.autoreverses = YES;
    keyAnimation.delegate = self;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.duration = 0.3;
    keyAnimation.repeatCount = 1;
    [keyAnimation setValue:@"hao" forKey:@"tag"];
    [view.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
    self.currentView = view;
}

-(void)animationDidStart:(CAAnimation *)anim{
    self.view.userInteractionEnabled = NO;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.view.userInteractionEnabled = YES;
    if ([[anim valueForKey:@"tag"] isEqualToString:@"hao"]) {
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear  animations:^{
            [[self.imageViewArr objectAtIndex:0] setFrame:[[self.imageViewArr objectAtIndex:1] frame]];
            [[self.imageViewArr objectAtIndex:1] setFrame:self.currentView.frame];
        } completion:^(BOOL finished) {
            //
        }];
        [self.currentView.layer removeAllAnimations];
        self.currentView.frame = CGRectMake(20.0f, 0.0f, ScreenWith-40.0f-20.0f*2, ScreenWith-40.0f);
        self.currentView.center = CGPointMake(ScreenWith/2, ScreenHeight/2+10.0f*0);
        [self.view bringSubviewToFront:[self.imageViewArr objectAtIndex:0]];
        [self.view bringSubviewToFront:[self.imageViewArr objectAtIndex:1]];
        [self.imageViewArr removeLastObject];
        [self.imageViewArr insertObject:self.currentView atIndex:0];
    }
//    CABasicAnimation *basicAnimation=animationGroup.animations[0];
//    CAKeyframeAnimation *keyframeAnimation=animationGroup.animations[1];
//    CGFloat toValue=[[basicAnimation valueForKey:@"KCBasicAnimationProperty_ToValue"] floatValue];
//    CGPoint endPoint=[[keyframeAnimation valueForKey:@"KCKeyframeAnimationProperty_EndPosition"] CGPointValue];
//    
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    
//    //设置动画最终状态
//    _layer.position=endPoint;
//    _layer.transform=CATransform3DMakeRotation(toValue, 0, 0, 1);
//    
//    [CATransaction commit];
}

-(void)viewDidLoad{
    [super viewDidLoad];

//    [self.image];
//    DISPATCH_SOURCE_TYPE_TIMER        定时响应
//    DISPATCH_SOURCE_TYPE_SIGNAL      接收到UNIX信号时响应
//    
//    DISPATCH_SOURCE_TYPE_READ   IO操作，如对文件的操作、socket操作的读响应
//    DISPATCH_SOURCE_TYPE_WRITE     IO操作，如对文件的操作、socket操作的写响应
//    DISPATCH_SOURCE_TYPE_VNODE    文件状态监听，文件被删除、移动、重命名
//    DISPATCH_SOURCE_TYPE_PROC  进程监听,如进程的退出、创建一个或更多的子线程、进程收到UNIX信号
//    DISPATCH_SOURCE_TYPE_MACH_SEND
//    DISPATCH_SOURCE_TYPE_MACH_RECV   上面2个都属于Mach相关事件响应
//    DISPATCH_SOURCE_TYPE_DATA_ADD
//    DISPATCH_SOURCE_TYPE_DATA_OR          上面2个都属于自定义的事件，并且也是有自己来触发
//    NSArray *name = @[@"a",@"b",@"c",@"d",@"e"];
    /*-------------------
     *用户事件有两种：DISPATCH_SOURCE_TYPE_DATA_ADD 和 DISPATCH_SOURCE_TYPE_DATA_OR,当使用 _ADD版本时，事件在联结时会把这些数
     *字相加。当使用 _OR版本时，事件在联结时会把这些数字逻辑与运算。当事件句柄执行时，我们可以使用dispatch_source_get_data函数访问当
     *前值，然后这个值会被重置为0
     第1个参数：要监听的事件类型
     第2个参数：可以理解为句柄、索引或id，假如要监听进程，需要传入进程的ID
     第3个参数：根据参数2，可以理解为描述，提供更详细的描述，让它知道具体要监听什么
     第4个参数：当事件发生时，将block添加至哪个队列来执行
     *
     *
     --------------------*/
//    dispatch_source_t  source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_event_handler(source, ^{
//        NSLog(@"%lu 人已交卷",dispatch_source_get_data(source));
//    });
//    dispatch_resume(source);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(5, queue, ^(size_t index) {
//        NSLog(@"收到 %@ 试卷",name[index]);
//        dispatch_source_merge_data(source, 1); //发出信号
//    });
    
//    NSArray *array = @[@"0.1",@"0.2",@"0.3",@"0.4",@"0.5"];
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_event_handler(source, ^{
//        self.view.backgroundColor = [UIColor whiteColor];
//        [progressIndicator incrementBy:dispatch_source_get_data(source)];
//    });
//    dispatch_resume(source);
//    dispatch_queue_t globalQueue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply([array count], globalQueue, ^(size_t index) {
//        // do some work on data at index
//        dispatch_source_merge_data(source, 1);
//    });
    
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    stdinSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ,2,0,globalQueue);
//    dispatch_source_set_event_handler(stdinSource, ^{
//        char buf[1024];
//        long len = read(STDIN_FILENO, buf, sizeof(buf));
//        NSLog(@"---%ld",len);
//        if(len > 0)
//            NSLog(@"Got data from stdin: %ld*%s", len, buf);
//    });
//    dispatch_resume(stdinSource);
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,//类型：定时器
//                                   0, 0,
//                                   queue);//block会被压入queue执行
//    /* step 2 */
//    dispatch_source_set_timer(timer,//dispatch source
//                              dispatch_time(DISPATCH_TIME_NOW, 0* NSEC_PER_SEC),//现在开始
//                              1* NSEC_PER_SEC,//间隔 1s
//                              0);//精度0
//    /* step 3 */
//    dispatch_source_set_event_handler(timer, ^{
//        NSLog(@"!");//整秒报时时的操作
//    });
//    /* step 4 */
//    dispatch_resume(timer);//恢复source
    
//    __block int timeout=300; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
//    dispatch_source_set_event_handler(timer, ^{
//        NSLog(@"%i",timeout);
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(timer);
////            dispatch_release(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//            });
//        }else{
//            int minutes = timeout / 60;
//            int seconds = timeout % 60;
//            NSString * strTime = [NSString stringWithFormat:@"%d分%.2d秒后重新获取验证码",minutes, seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"%@",strTime);
//            });
//            timeout--;
//            
//        }    
//    });    
//    dispatch_resume(timer);
    
//    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t dispatchGroup = dispatch_group_create();
//    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
//        NSLog(@"dispatch-1");
//    });
//    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
//        NSLog(@"dspatch-2");
//    });
//    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
//        NSLog(@"end");
//    });
    
//    int data = 3;
//    __block int mainData = 0;
//    __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    
//    dispatch_queue_t queue = dispatch_queue_create("StudyBlocks", NULL);
//    
//    dispatch_async(queue, ^(void) {
//        int sum = 0;
//        for(int i = 0; i < 5; i++)
//        {
//            sum += data;
//            
//            NSLog(@" >> Sum: %d", sum);
//        }
//        
//        dispatch_semaphore_signal(sem);
//    });
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    for(int j=0;j<5;j++)
//    {
//        mainData++;
//        NSLog(@">> Main Data: %d",mainData);
//    }
    
//    dispatch_queue_t queue = dispatch_queue_create("**test.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"dispatch_async1");
//    });
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:4];
//        NSLog(@"dispatch_async2");
//    });
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"dispatch_barrier_async");
//        [NSThread sleepForTimeInterval:4];
//    });
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:1]; 
//        NSLog(@"dispatch_async3"); 
//    });
    
    
//    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        // 执行5次
//        NSLog(@"----))))_____");
//    });
    
//    NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"asdasd");
//    }];
//    NSInvocationOperation * invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fuck) object:nil];
//    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 2;
//    [queue addOperation:blockOperation];
//    [queue addOperation:invocationOperation];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
//    keyAnimation.keyPath = @"position";
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, self.testView.layer.position.x, self.testView.layer.position.y);
//    CGPathAddLineToPoint(path, NULL, ScreenWith, self.testView.layer.position.y);
//    keyAnimation.path = path;
//    keyAnimation.duration = 2;
//    keyAnimation.repeatCount=MAXFLOAT;
//    keyAnimation.removedOnCompletion = NO;
//    keyAnimation.fillMode = kCAFillModeForwards;
//    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    keyAnimation.delegate=self;
//    [self.testView.layer addAnimation:keyAnimation forKey:nil];
//}

//-(void)fuck{
//    NSLog(@"ssss");
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
