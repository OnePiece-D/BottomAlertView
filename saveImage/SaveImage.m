//
//  SaveImage.m
//  saveImage
//
//  Created by ycd15 on 16/7/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "SaveImage.h"

@implementation SaveImage

+ (instancetype)sharInstance {
    static SaveImage * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SaveImage alloc] init];
    });
    return instance;
}

+ (void)saveImage:(UIImage *)image {
    //@selector(image:didFinishSavingWithError:contextInfo:)
    UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
}

- (void)saveImage:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != NULL) {
        if (self.saveHandle) {
            self.saveHandle(NO);
        }
    }else {
        if (self.saveHandle) {
            self.saveHandle(YES);
        }
    }
}

@end
