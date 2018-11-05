//
//  bleCentralManager.h
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/4.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface bleCentralManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@end
