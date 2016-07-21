//
//  BottomAlert.m
//  saveImage
//
//  Created by ycd15 on 16/7/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "BottomAlert.h"

#define TitleHeight 44
#define kSpaceVer 4
#define LineHeight 0.7

@implementation BottomAlert

{
    CGRect _frame;
}

+ (void)showAlert:(NSArray *)array {
    BottomAlert * alertView = [BottomAlert.alloc initWithArray:array];
    [alertView show];
}

+ (void)showAlert:(NSArray *)array clickBlock:(void (^)(NSInteger))block {
    BottomAlert * alertView = [BottomAlert shareInstanceWithArray:array];
    [alertView show];
    block = alertView.selectedBlock;
}

+ (instancetype)shareInstanceWithArray:(NSArray *)array {
    static BottomAlert * view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [BottomAlert.alloc initWithArray:array];
    });
    return view;
}

+ (instancetype)initAlert:(NSArray *)array {
    BottomAlert * alertView = [BottomAlert.alloc initWithArray:array];
    [alertView show];
    return alertView;
}

- (instancetype)initWithArray:(NSArray *)array {
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT - TitleHeight * (array.count + 1) - kSpaceVer, SCREEN_WIDTH,  TitleHeight * (array.count + 1) + kSpaceVer);
    _frame = frame;
    
    if ([super initWithFrame:frame]) {
        self.titleArray = [array copy];
        
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        
        CGFloat minX = 0;
        CGFloat minY = 0;
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = TitleHeight - LineHeight;
        
        int i = 0;
        for (NSString * title in array) {
            UIButton * button = [self createBtn:CGRectMake(minX, minY, width, height) title:title];
            UIView * lineView = [self lineView:CGRectMake(minX, minY + TitleHeight - LineHeight, SCREEN_WIDTH, LineHeight)];
            minY += TitleHeight;
            [self.btnArray addObject:button];
            [self addSubview:button];
            
            if (i++ != array.count - 1) {
                [self addSubview:lineView];
            }
        }
        minY += kSpaceVer;
        UIButton * cancelBtn = [self createBtn:CGRectMake(minX, minY, width, height + LineHeight) title:@"取消"];
        [self addSubview:cancelBtn];
    }
    
    return self;
}

- (void)show {
    //UIView * currentView = [self getCurrentVC].view;
    UIWindow * currentWindow = [self getCurrentWindow];
    UIView * currentView = [self p_nextTopForViewController:currentWindow.rootViewController].view;
    
    [currentView addSubview:self];
    /*
    [UIView animateWithDuration:5.0 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.frame = _frame;
    } completion:^(BOOL finished) {
        [currentView addSubview:self];
    }];*/
}

- (void)hiden {
    [self removeFromSuperview];
}

- (void)tapBtnAction:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self hiden];
    }else {
        if (self.selectedBlock) {
            self.selectedBlock([self.btnArray indexOfObject:button]);
        }
    }
}

- (UIButton *)createBtn:(CGRect)frame title:(NSString *)title {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0]] forState:UIControlStateHighlighted];
    
    return button;
}

- (UIView *)lineView:(CGRect)frame {
    UIView * view = [UIView.alloc initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    return view;
}


//获取当前屏幕显示的viewcontroller
/*这个不是很好用
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
*/

- (UIWindow *)getCurrentWindow {
    return [[UIApplication sharedApplication].windows lastObject];
}

/* 这个在AppDelegate中实现
- (UIViewController *)activityViewController {
    __block UIWindow *normalWindow = [self.delegate window];
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        [self.windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop        = YES;
            }
        }];
    }
    
    return [self p_nextTopForViewController:normalWindow.rootViewController];
}
*/

//判断是哪个VC
- (UIViewController *)p_nextTopForViewController:(UIViewController *)inViewController {
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self p_nextTopForViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
    } else if ([inViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *selectedVC = [self p_nextTopForViewController:((UINavigationController *)inViewController).visibleViewController];
        return selectedVC;
    } else {
        return inViewController;
    }
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
