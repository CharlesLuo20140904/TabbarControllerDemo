//
//  SecondViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/8/21.
//  Copyright (c) 2015年 jecansoft. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "Second_BlueTooothTableViewCell.h"

static NSString * const kServiceUUID = @"1C85D7B7-17FA-4362-82CF-85DD0B76A9A5";
static NSString * const kCharacteristicUUID = @"7E887E40-95DE-40D6-9AA0-36EDE2BAE253";

@interface SecondViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,CBPeripheralManagerDelegate,QRCodeReaderDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) CBCentralManager * centerManager;
@property (strong, nonatomic) CBPeripheral * peripheral;
@property (strong, nonatomic) CBCharacteristic * characteristic;

//外设
@property (strong, nonatomic) CBPeripheralManager * peripheralManager;
@property (strong, nonatomic) CBCharacteristic * customCharacteristic;
@property (strong, nonatomic) CBMutableService * customService;

@property (strong, nonatomic) UIActivityIndicatorView * indictorView;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * peripheralArrs;
@property (strong, nonatomic) UIScrollView * scrollView;
@end

@implementation SecondViewController


-(UIActivityIndicatorView *)indictorView{
    if (_indictorView == nil) {
        _indictorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indictorView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImageView * qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 35.0f, 35.0f)];
        qrImageView.image = [UIImage imageNamed:@"qrcode"];
        UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showQrcodeView)];
        [qrImageView addGestureRecognizer:leftTap];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:qrImageView];
        self.navigationItem.leftBarButtonItem = leftItem;
        UIImageView * bluetoothImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 35.0f, 35.0f)];
        bluetoothImageView.image = [UIImage imageNamed:@"second_bluetooth"];
        UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
        [bluetoothImageView addGestureRecognizer:rightTap];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:bluetoothImageView];
        self.navigationItem.rightBarButtonItem = rightItem;
        [self.view addSubview:[self customLoadViewWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 100.0f)]];
    }
    return self;
}

-(void)showQrcodeView{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader                        = [QRCodeReaderViewController new];
            reader.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:reader animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)showMenu:(UIButton*)btn{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:false],CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    [self.centerManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:dic];
    [self startIndicatorView];
}

#pragma mark - QRCodeReader Delegate Methods
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - System Methods
-(void)viewDidLoad{
    [super viewDidLoad];
    self.peripheralArrs = [NSMutableArray array];
    //    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //    }
    self.automaticallyAdjustsScrollViewInsets = NO;//    自动滚动调整，默认为YES
//    self.navigationController.navigationBar.translucent= NO;
//    //Set this property so that the tababr will not be transperent
//    self.tabBarController.tabBar.translucent=NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, ScreenWith,ScreenHeight-64.0f-44.0f)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith,1.0f)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.scrollView addSubview:self.tableView];
    [self.view addSubview:self.tableView];
    dispatch_queue_t centralQueue = dispatch_queue_create("com.manmanlai", DISPATCH_QUEUE_SERIAL);
//    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@YES,
//                              CBCentralManagerOptionRestoreIdentifierKey:@YES};
    self.centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:nil];
    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - corebluetooth Delegate Methods

#pragma mark - 创建外设 Methods
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state)
    {
        case CBPeripheralManagerStatePoweredOn:
        {
            [self setupService];
        }
            break;
            
        default:
        {
            NSLog(@"Peripheral Manager did change state");
        }
            break;
    }
}

//当发现周边设备的蓝牙是可以的时候，这就需要去准备你需要广播给其他中央设备的服务和特征了，这里通过调用setupService方法来实现。
//每一个服务和特征都需要用一个UUID（unique identifier）去标识，UUID是一个16bit或者128bit的值。如果你要创建你的中央-周边App，你需要创建你自己的128bit的UUID。你必须要确定你自己的UUID不能和其他已经存在的服务冲突。如果你正要创建一个自己的设备，需要实现标准委员会需求的UUID；如果你只是创建一个中央-周边App，我建议你打开Mac OS X的Terminal.app，用uuidgen命令生成一个128bit的UUID。你应该用该命令两次，生成两个UUID，一个是给服务用的，一个是给特征用的。然后，你需要添加他们到中央和周边App中。现在，在view controller的实现之前，我们添加以下的代码：
- (void)setupService
{
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    
    self.customCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    
    self.customService = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    [self.customService setCharacteristics:@[self.customCharacteristic]];
    [self.peripheralManager addService:self.customService];
    
    
}

//当调用了CBPeripheralManager的addService方法后，这里就会响应CBPeripheralManagerDelegate的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error方法。这个时候就可以开始广播我们刚刚创建的服务了。
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error == nil)
    {
        [self.peripheralManager startAdvertising:@{ CBAdvertisementDataLocalNameKey : @"ICServer", CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:kServiceUUID]], CBAdvertisementDataServiceDataKey : @"asdasdasdasd"}];
    }
}

//当然到这里，你已经做完了peripheralManager的工作了，中央设备已经可以接受到你的服务了。不过这是静止的数据，你还可以调用- (BOOL)updateValue:(NSData *)value forCharacteristic:(CBMutableCharacteristic *)characteristic onSubscribedCentrals:(NSArray *)centrals方法可以给中央生成动态数据的地方。

//- (void)sendToSubscribers:(NSData *)data {
//    if (self.peripheral.state != CBPeripheralManagerStatePoweredOn) {
//        LXCBLog(@"sendToSubscribers: peripheral not ready for sending state: %d", self.peripheral.state);
//        return;
//    }
//    
//    BOOL success = [self.peripheral updateValue:data
//                              forCharacteristic:self.characteristic
//                           onSubscribedCentrals:nil];
//    if (!success) {
//        LXCBLog(@"Failed to send data, buffering data for retry once ready.");
//        self.pendingData = data;
//        return;
//    }
//}

//central订阅了characteristic的值，当更新值的时候peripheral会调用updateValue: forCharacteristic: onSubscribedCentrals:(NSArray*)centrals去为数组里面的centrals更新对应characteristic的值，在更新过后peripheral为每一个central走一遍下面的代理方法
//
//- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
//peripheral接受到一个读或者写的请求时，会响应以下两个代理方法
//
//- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
//
//- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests


#pragma mark - 创建中心设备进行扫描 Methods
//检测是否支持ble
//if ([central state] == CBCentralManagerStatePoweredOff) {
//    NSLog(@"CoreBluetooth BLE hardware is powered off");
//}
//else if ([central state] == CBCentralManagerStatePoweredOn) {
//    NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
//}
//else if ([central state] == CBCentralManagerStateUnauthorized) {
//    NSLog(@"CoreBluetooth BLE state is unauthorized");
//}
//else if ([central state] == CBCentralManagerStateUnknown) {
//    NSLog(@"CoreBluetooth BLE state is unknown");
//}
//else if ([central state] == CBCentralManagerStateUnsupported) {
//    NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
//}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
//            [self.centerManager scanForPeripheralsWithServices:nil options:nil];
            NSLog(@"current device is support ble");
            break;
        default:
            NSLog(@"Central Manager did change state");
            break;
    }
}

//扫描到外设之后进行跳转到tableview中选择外设进行连接
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"name:%@",peripheral);
    if (!peripheral || !peripheral.name || ([peripheral.name isEqualToString:@""])) {
        return;
    }
    
    if (peripheral || (self.peripheral.state == CBPeripheralStateDisconnected)) {
        peripheral.delegate = self;
        if (![self.peripheralArrs containsObject:peripheral]) {
             [self.peripheralArrs addObject:peripheral];
        }
        [self.tableView setFrame:CGRectMake(0.0f, 64.0f, ScreenWith, 80.0f*self.peripheralArrs.count)];
        self.scrollView.contentSize = CGSizeMake(0.0f, CGRectGetMaxY(self.tableView.frame));
        [self.tableView reloadData];
        [self stopIndicatorView];
    }
    
}

//外设连接失败的委托
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}

//链接成功之后
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    if (!peripheral) {
        return;
    }
    
    [self.centerManager stopScan];
    
    NSLog(@"peripheral did connect");
    [self.peripheral discoverServices:nil];
//    [self.peripheral discoverServices:@[ [CBUUID UUIDWithString:kServiceUUID]]];
    
}

//断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}

//寻找服务并寻找它的属性
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSArray *services = nil;
    
    if (peripheral != self.peripheral) {
        NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        NSLog(@"Error %@\n", error);
        return ;
    }
    
    services = [peripheral services];
    if (!services || ![services count]) {
        NSLog(@"No Services");
        return ;
    }
    
    for (CBService *service in services) {
        NSLog(@"service:%@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
//        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]])
//        {
//            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID],[CBUUID UUIDWithString:kWrriteCharacteristicUUID]] forService:service];
//        }
    }
    
}

//访问周边的服务，找到特征后读取数据
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"characteristics:%@",[service characteristics]);
    NSArray *characteristics = [service characteristics];
    
    if (peripheral != self.peripheral) {
        NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        NSLog(@"Error %@\n", error);
        return ;
    }
    
    self.characteristic = [characteristics firstObject];
    [self.peripheral readValueForCharacteristic:self.characteristic]; //毁掉用下面的didUpdateValueForCharacteristic方法
    [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
}

//读到数据后调用delegate方法
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSData *data = characteristic.value;
    NSLog(@"---->>%@",data);
    // Parse data ...
    
}

//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

//在設定註冊通知過程有點繁雜，所以我自行撰寫一個Method為notification，它可以從Service UUID及Characteristic UUID來找到Service與Characteristic的Object Point：。

////-----------start-----------
//-(void) notification:(CBUUID *) serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)p on:(BOOL)on {
//    
//    CBService *service = [self getServiceFromUUID:serviceUUID p:p];
//    if (!service) {
//        if (p.UUID == NULL) return; // zach ios6 addedche
//        NSLog(@"Could not find service with UUID on peripheral with UUID \n");
//        return;
//    }
//    CBCharacteristic *characteristic = [self getCharacteristicFromUUID:characteristicUUID service:service];
//    if (!characteristic) {
//        if (p.UUID == NULL) return; // zach ios6 added
//        NSLog(@"Could not find characteristic with UUID  on service with UUID  on peripheral with UUID\n");
//        return;
//    }
//    [p setNotifyValue:on forCharacteristic:characteristic];
//    
//}
//
//
//-(CBService *) getServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p {
//    
//    for (CBService* s in p.services){
//        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
//    }
//    return nil; //Service not found on this peripheral
//}
//
//-(CBCharacteristic *) getCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
//    
//    for (CBCharacteristic* c in service.characteristics){
//        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
//    }
//    return nil; //Characteristic not found on this service
//}
//------------end------------


//向设备写入数据
//[self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];

#pragma mark - UI init Methods
- (UIView*)customLoadViewWithFrame:(CGRect)frame{
    UIView * loadView = [[UIView alloc] initWithFrame:frame];
    loadView.hidden = YES;
    loadView.backgroundColor = [UIColor whiteColor];
    loadView.layer.cornerRadius = 10.0f;
    loadView.clipsToBounds = YES;
    loadView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    loadView.layer.shadowOpacity = 0.5;
    loadView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    loadView.layer.shadowRadius = 2.0f;
    loadView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    self.indictorView.frame = CGRectMake(frame.size.width/2, frame.size.height/2-10.0f, 0.0f, 0.0f);
    [loadView addSubview:self.indictorView];
    UILabel * warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.indictorView.frame)+20.0f, frame.size.width, 25.0f)];
    warningLabel.font = [UIFont systemFontOfSize:15];
    warningLabel.lineBreakMode = NSLineBreakByWordWrapping;
    warningLabel.numberOfLines = 0;
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.text = @"正在查找蓝牙设备...";
    [loadView addSubview:warningLabel];
    return loadView;
}

- (void)startIndicatorView{
    self.indictorView.superview.hidden = NO;
    [self.indictorView startAnimating];
}

- (void)stopIndicatorView{
    self.indictorView.superview.hidden = YES;
    [self.indictorView stopAnimating];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripheralArrs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    Second_BlueTooothTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[Second_BlueTooothTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CBPeripheral * peripheral = (CBPeripheral*)self.peripheralArrs[indexPath.row];
    cell.nameLabel.text = peripheral.name;
    if (peripheral.state == CBPeripheralStateDisconnected) {
        cell.stateLabel.text = @"not connect";
    }else if (peripheral.state == CBPeripheralStateConnecting){
        cell.stateLabel.text = @"connecting";
    }else if (peripheral.state == CBPeripheralStateConnected){
        cell.stateLabel.text = @"connected";
    }else if (peripheral.state == CBPeripheralStateDisconnecting){
        cell.stateLabel.text = @"disconnecting";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"connect peripheral");
    self.peripheral = (CBPeripheral*)[self.peripheralArrs objectAtIndex:indexPath.row];
    [self.centerManager connectPeripheral:self.peripheral options:nil];
}

//返现characteristic后可以读取它的值，也可以订阅它：
//[objc] view plaincopy
//[self.peripheral readValueForCharacteristic:characteristic];
//[self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
//以上两个方法都会调用代理方法：didUpdateValueForCharacteristic:error:
//
//向外设的某个characteristic写入值，可以这样写
//[objc] view plaincopy
//- (void)writeToperipheral:(CBPeripheral *)peripheral Service:(NSString *)serviceUUID characteristic:(NSString *)characteristicUUID data:(NSData *)data
//{
//    CBUUID *servUUID = [CBUUID UUIDWithString:serviceUUID];
//    CBUUID *charUUID = [CBUUID UUIDWithString:characteristicUUID];
//    CBService *service = nil;
//    CBCharacteristic *characteristic = nil;
//    for (CBService *ser in peripheral.services) {
//        if ([ser.UUID isEqual:servUUID]) {
//            service = ser;
//            break;
//        }
//    }
//    if (service) {
//        for (CBCharacteristic *charac in service.characteristics) {
//            if ([charac.UUID isEqual:charUUID]) {
//                characteristic = charac;
//                break;
//            }
//        }
//    }
//    if (characteristic) {
//        [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
//    }
//    else{
//        NSLog(@"not found that characteristic");
//    }
//}
//
//NSData的值可以这样组织，这与你的需求有关并不一定：
//[objc] view plaincopy
//char data;
//data = 0x15;
//NSData *d = [[NSData alloc] initWithBytes:&data length:1];
//
//读取某个characteristic的值
//[objc] view plaincopy
//- (void)readPeripheral:(CBPeripheral *)peripheral serviceUUID:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID
//{
//    CBUUID *servUUID = [CBUUID UUIDWithString:serviceUUID];
//    CBUUID *charUUID = [CBUUID UUIDWithString:characteristicUUID];
//    CBService *service = nil;
//    CBCharacteristic *characteristic = nil;
//    for (CBService *ser in peripheral.services) {
//        if ([ser.UUID isEqual:servUUID]) {
//            service = ser;
//            break;
//        }
//    }
//    if (service) {
//        for (CBCharacteristic *charac in service.characteristics) {
//            if ([charac.UUID isEqual:charUUID]) {
//                characteristic = charac;
//                break;
//            }
//        }
//    }
//    if (characteristic) {
//        [peripheral readValueForCharacteristic:characteristic];
//    }else{
//        NSLog(@"----------未找到当前的characteristic");
//    }
//}
//
//通过保存的identity来找到以前连接的设备
//保存identity
//[objc] view plaincopy
//NSUUID *uuid = peripheral.identifier;
//NSString *uuidString = uuid.UUIDString;
//[[NSUserDefaults standardUserDefaults] setObject:uuidString forKey:PERIPHERAL_UUID];
//[[NSUserDefaults standardUserDefaults] synchronize];
//然后通过identity，来搜索设备：
//[objc] view plaincopy
//NSString *uuidString = [[NSUserDefaults standardUserDefaults] stringForKey:PERIPHERAL_UUID];
//NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
//_peripheralArr = [NSMutableArray arrayWithArray: [self.centralManager retrievePeripheralsWithIdentifiers:@[uuid]]];
//for (CBPeripheral *peripheral in _peripheralArr) {
//    self.peripheral = peripheral;
//    [self.centralManager connectPeripheral:peripheral options:nil];
//}
//通过retrieveConnectedPeripheralsWithServices：函数来检索当前连接到系统的蓝牙设备：
//[objc] view plaincopy
//NSArray *atmp = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"180A"], nil nil];
//NSArray *retrivedArray = [myCenter retrieveConnectedPeripheralsWithServices:atmp];
//NSLog(@"retrivedArray:\n%@",retrivedArray);
//
//for (CBPeripheral* peripheral in retrivedArray) {
//    [self addPeripheral:peripheral advertisementData:nil  RSSI:nil];
//}


@end
