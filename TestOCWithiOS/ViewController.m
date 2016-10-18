//
//  ViewController.m
//  TestOCWithiOS
//
//  Created by Elise on 16/10/15.
//  Copyright © 2016年 Elise. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UIButton *testThreadButton;
@property (weak, nonatomic) IBOutlet UIButton *testLockButton;
@property (nonatomic,assign) NSInteger goods;
@property (nonatomic,strong) NSThread *thread1;
@property (nonatomic,strong) NSThread *thread2;
@property (nonatomic,strong) NSThread *thread3;
@property (nonatomic,strong) NSLock *lock;
@property (nonatomic,strong) NSMutableSet *aSet;
@property (nonatomic,strong) NSMutableArray *anArray;

@end

@implementation ViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goods = 10;
    [self.testThreadButton addTarget:self action:@selector(testThreadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.testLockButton addTarget:self action:@selector(testLockButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.lock = [[NSLock alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - override
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LabelViewController *newView = (LabelViewController *)segue.destinationViewController;
    newView.changeBlock = ^(NSString *getString) {
        NSLog(@"%@", getString);
    };
}

#pragma mark - testArrayAndSet

- (void)testLockButtonClick {
    
    NSString *oneStr = [[NSString alloc] initWithString:@"oneStr"];
    self.anArray = [[NSMutableArray alloc] init];
    self.aSet = [[NSMutableSet alloc] init];
    
    [self.anArray addObject:oneStr];
    [self.anArray addObject:oneStr];
    [self.aSet addObject:oneStr];
    [self.aSet addObject:oneStr];
    
    NSLog(@"anArray is %@",self.anArray);
    NSLog(@"anSet is %@",self.aSet);
    
    
    //解决不同步，加锁
    [self.lock lock];
    [self.anArray removeObject:oneStr];
    [self.aSet removeObject:oneStr];
    [self.lock unlock];
    
    NSLog(@"anArray is %@",self.anArray);
    NSLog(@"anSet is %@",self.aSet);
    /*
     上述是对Array与Set的区别测试
     */
    
    //闭包实验
    NSInteger(^getMaxNumber)(NSInteger,NSInteger) = ^(NSInteger a,NSInteger b) {
        if (a > b) {
            return a;
        }
        else {
            return b;
        }
    };
    
    int c = getMaxNumber(12,11);
    NSLog(@"max c is %d",c);
}


#pragma mark - testThread 

- (void)testThreadButtonClick {
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(buyProduct) object:nil];
    self.thread1.name = @"custom1";
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(buyProduct) object:nil];
    self.thread2.name = @"custom2";
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(buyProduct) object:nil];
    self.thread3.name = @"custom3";
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}
- (void)buyProduct {

    //nslock实现
//    [_lock lock];
//    while (self.goods >= 1) {
//        [NSThread sleepForTimeInterval:0.3];
//        self.goods -= 1;
//        NSThread *currentThread = [NSThread currentThread];
//        NSLog(@"customer is %@, goods left %d",currentThread,self.goods);
//    }
//    [_lock unlock];
//    [NSThread exit];
//    self.goods = 10;
    
    //为什么到－2停止了，，，有趣－ －
    //synchronized实现
    @synchronized (self) {
        //锁定
        while (self.goods >= 1) {
            [NSThread sleepForTimeInterval:0.3];
            self.goods -= 1;
            NSThread *currentThread = [NSThread currentThread];
            NSLog(@"customer is %@, goods left %d",currentThread,self.goods);
        }
        [NSThread exit];
        self.goods = 10;
    }
}





@end
