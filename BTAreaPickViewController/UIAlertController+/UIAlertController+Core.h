//
//  UIAlertController+Core.h
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/25.
//  Copyright © 2019 leishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Core)
- (void)bt_setViewController:(UIViewController*)vc height:(CGFloat)height;

- (void)bt_addActionWithTitle:(NSString *)title
                 withColor:(UIColor*)color
                 withStyle:(UIAlertActionStyle)style
                   handler:(void (^ __nullable)(UIAlertAction *action))handler;
@end

NS_ASSUME_NONNULL_END
