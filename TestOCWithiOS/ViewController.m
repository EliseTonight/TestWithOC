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
@property (assign,nonatomic) NSInteger goods;
@property (nonatomic,strong) NSThread *thread1;
@property (nonatomic,strong) NSThread *thread2;
@property (nonatomic,strong) NSThread *thread3;
@property (nonatomic,strong) NSLock *lock;

@end

@implementation ViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goods = 20;
    [self.testThreadButton addTarget:self action:@selector(testThreadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.testLockButton addTarget:self action:@selector(testLockButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIView *oneView = [[UIView alloc] init];
    NSMutableArray *anArray = [[NSMutableArray alloc] init];
    NSMutableSet *anSet = [[NSMutableSet alloc] init];
    self.lock = [[NSLock alloc] init];
    
    [anArray addObject:oneView];
    [anArray addObject:oneView];
    [anSet addObject:oneView];
    [anSet addObject:oneView];
    
    NSLog(@"anArray is %@",anArray);
    NSLog(@"anSet is %@",anSet);
    /*
     上述是对Array与Set的区别测试
     
     */
    
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(buyProduct) object:nil];
    self.thread1.name = @"custom1";
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(buyProduct) object:nil];
    self.thread2.name = @"custom2";

    //锁
    [self.lock lock];
    
    
    
    
    [anArray removeObject:oneView];
    
    [anSet removeObject:oneView];
    
    
    
    [self.lock unlock];
    
    NSLog(@"anArray is %@",anArray);
    
    NSLog(@"anSet is %@",anSet);
    
    
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
}
- (void)buyProduct {
    
    
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
    //为什么到－2停止了，，，有趣－ －
    while (self.goods >= 0) {
        //锁定
        @synchronized (self) {
            
            NSInteger goodsCopy = self.goods;
            if (goodsCopy)
                
            [NSThread sleepForTimeInterval:0.5];
            
            self.goods -= 1;
            
            NSThread *currentThread = [NSThread currentThread];
            NSLog(@"customer is %@, goods left %d",currentThread,self.goods);
        }
    }
    [NSThread exit];
    self.goods = 20;
    
}





@end
