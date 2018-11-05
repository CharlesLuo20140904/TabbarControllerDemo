//
//  RuntimeDemoViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/20.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "RuntimeDemoViewController.h"
#import <objc/runtime.h>

@implementation RuntimeDemoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNewClass];
}
/**
1.  增加

增加函数:class_addMethod

增加实例变量:class_addIvar

增加属性:@dynamic标签，或者class_addMethod，因为属性其实就是由getter和setter函数组成

增加Protocol:class_addProtocol (说实话我真不知道动态增加一个protocol有什么用,-_-!!)

2.  获取

获取函数列表及每个函数的信息(函数指针、函数名等等):class_getClassMethod method_getName ...

获取属性列表及每个属性的信息:class_copyPropertyList property_getName

获取类本身的信息,如类名等：class_getName class_getInstanceSize

获取变量列表及变量信息：class_copyIvarList

获取变量的值

3.    替换

将实例替换成另一个类：object_setClass

替换类方法的定义：class_replaceMethod

4.其他常用方法：

交换两个方法的实现：method_exchangeImplementations.

设置一个方法的实现：method_setImplementation.
**/
-(void)createNewClass{
    /*objc_allocateClassPair创建新的类*/
    Class newClass = objc_allocateClassPair([UIView class],"GreenView",0);
    /*class_addMethod在新类中添加方法*/
    class_addMethod(newClass, @selector(changeColor), (IMP)changeTheColorForView, 0);
    /*class_addProperty在类中添加属性*/
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = {"C", ""};  //c=copy
    objc_property_attribute_t backingivar = {"V", "_privateName"};
    objc_property_attribute_t attrs[] = {type, ownership,backingivar};
    class_addProperty([newClass class], "name", attrs, 3);
    /*objc_registerClassPair注册类*/
    objc_registerClassPair(newClass);
    
    id newClassObject = [[newClass alloc] init];
    [newClassObject performSelector:@selector(changeColor)]; // 执行方法
    /*获取成员变量列表，invarscnt为类成员变量的数量，每个成员变量都是ivar类型的结构体*/
    unsigned int ivarsCnt = 0;
    Ivar* ivars = class_copyIvarList([UIView class], &ivarsCnt);
    for (const Ivar* p = ivars; p<ivars + ivarsCnt; ++p) {
        Ivar const ivar = *p;
        //获取变量名
        NSString* key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"这里输出变量名%@",key);
    }
    
    u_int count;
    Method* methods = class_copyMethodList([UIView class], &count);
    for (int i=0; i<count; i++) {
        SEL name = method_getName(methods[i]);
        NSString* strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"这里输出方法名%@",strName);
    }
    
}

void changeTheColorForView(id self,SEL _cmd){
    NSLog(@"这里输出isa指针指向的对象：%p",object_getClass([NSObject class]));
    NSLog(@"这里输出该对象%p",[NSObject class]);
}

@end
