//
//  UIAlertController+Core.m
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/25.
//  Copyright © 2019 leishen. All rights reserved.
//

#import "UIAlertController+Core.h"


@implementation UIAlertController (Core)
- (void)bt_setViewController:(UIViewController*)vc height:(CGFloat)height{
    if (vc==nil)return;
    [self setValue:vc forKey:@"contentViewController"];
    if (height>0) {
        vc.preferredContentSize = CGSizeMake(vc.preferredContentSize.width, height);
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, height);
    }
}

- (void)bt_addActionWithTitle:(NSString *)title
                 withColor:(UIColor*)color
                 withStyle:(UIAlertActionStyle)style
                   handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertAction * action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    if (color) {
        [action setValue:color forKey:@"titleTextColor"];
    }
    [self addAction:action];
}
@end
