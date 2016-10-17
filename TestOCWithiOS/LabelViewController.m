//
//  LabelViewController.m
//  TestOCWithiOS
//
//  Created by Elise on 16/10/16.
//  Copyright © 2016年 Elise. All rights reserved.
//

#import "LabelViewController.h"

@interface LabelViewController ()

@property (weak, nonatomic) IBOutlet UILabel *needLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation LabelViewController

#pragma mark - lifecycle

- (instancetype)init {
    self = [super init];
    NSLog(@"alloc init");
    return self;
}
- (void)loadView {
    [super loadView];
    NSLog(@"loadView");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    UITapGestureRecognizer *needLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
    [self.needLabel setUserInteractionEnabled:true];
    [self.needLabel addGestureRecognizer:needLabelTap];
    
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}
- (void)dealloc {
    NSLog(@"delloc");
}

#pragma mark - action
- (void)labelClick:(UITapGestureRecognizer *)sender {
    if (self.changeBlock) {
        //设置值,block
        self.changeBlock(@"I got it!");
    }
}

- (void)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
