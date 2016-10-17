//
//  LabelViewController.h
//  TestOCWithiOS
//
//  Created by Elise on 16/10/16.
//  Copyright © 2016年 Elise. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明block类型
typedef void(^changeLabelBlock)(NSString *);

@interface LabelViewController : UIViewController

@property (nonatomic,copy) changeLabelBlock changeBlock;

@end
