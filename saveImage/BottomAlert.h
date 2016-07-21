//
//  BottomAlert.h
//  saveImage
//
//  Created by ycd15 on 16/7/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

//保存图片到本地相册
#import "SaveImage.h"

@class SelectedBtn;

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BottomAlert : UIView

@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSMutableArray * btnArray;

@property (nonatomic, copy) void (^selectedBlock) (NSInteger);

+ (void)showAlert:(NSArray *)array;
+ (void)showAlert:(NSArray *)array clickBlock:(void (^)(NSInteger))block;

+ (instancetype)shareInstanceWithArray:(NSArray *)array;
+ (instancetype)initAlert:(NSArray *)array;

- (instancetype)initWithArray:(NSArray *)array;

- (void)show;

@end



@interface SelectedBtn : UIButton



@end