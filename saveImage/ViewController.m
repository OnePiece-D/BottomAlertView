//
//  ViewController.m
//  saveImage
//
//  Created by ycd15 on 16/7/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "ViewController.h"
#import "BottomAlert.h"

@interface ViewController ()

@property (nonatomic, strong) UIImage * image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    self.image = [UIImage imageNamed:@"image"];
    imageView.image = self.image;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"123131" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    //BottomAlert * view = [[BottomAlert alloc] initWithArray:@[@"保存",@"你是",@"谁啊"]];
    //[self.view addSubview:view];
    
}


- (void)action {
    BottomAlert * view = [BottomAlert initAlert:@[@"保存",@"你是",@"谁啊"]];
    view.selectedBlock = ^(NSInteger index) {
        NSLog(@"%ld",index);
        if (index == 0) {
            //保存
            [SaveImage saveImage:self.image];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
