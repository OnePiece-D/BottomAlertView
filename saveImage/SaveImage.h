//
//  SaveImage.h
//  saveImage
//
//  Created by ycd15 on 16/7/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SaveImage : NSObject

+ (instancetype)sharInstance;

+ (void)saveImage:(UIImage *)image;
- (void)saveImage:(UIImage *)image;

@property (nonatomic, copy) void (^saveHandle) (BOOL);


@end
