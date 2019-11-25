//
//  ViewController.m
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import "ViewController.h"
#import "BTAreaPickViewController.h"
#import "UIAlertController+Core.h"

@interface ViewController ()<BTAreaPickViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)normalStyleAction:(id)sender {
    BTAreaPickViewController * vc = [[BTAreaPickViewController alloc]initWithDragDismissEnabal:YES];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)alertAction:(id)sender {
    UIAlertControllerStyle style = UIAlertControllerStyleAlert;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"地址选择器" message:nil preferredStyle:style];
    BTAreaPickViewController * vc = [[BTAreaPickViewController alloc]init];
    [alert bt_setViewController:vc height:style==UIAlertControllerStyleAlert?250:400];
    vc.hiddenToolbar = YES;
    vc.delegate = self;
    [self presentViewController:alert animated:YES completion:nil];
    
    [alert bt_addActionWithTitle:@"确定" withColor:UIColor.systemPinkColor withStyle:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",vc.model.description);
    }];
    
    [alert bt_addActionWithTitle:@"取消" withColor:UIColor.blackColor withStyle:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
}

- (IBAction)alertSheetAction:(id)sender {
    
    UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"地址选择器" message:nil preferredStyle:style];
    BTAreaPickViewController * vc = [[BTAreaPickViewController alloc]initWithDragDismissEnabal:NO];
    [alert bt_setViewController:vc height:style==UIAlertControllerStyleAlert?250:400];
    vc.hiddenToolbar = YES;
    vc.delegate = self;
    [self presentViewController:alert animated:YES completion:nil];
    
    [alert bt_addActionWithTitle:@"确定" withColor:UIColor.systemPinkColor withStyle:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",vc.model.description);
    }];
    
    [alert bt_addActionWithTitle:@"取消" withColor:UIColor.blackColor withStyle:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - BTAreaPickViewControllerDelegate

- (void)areaPickerView:(BTAreaPickViewController *)areaPickerView doneAreaModel:(BTAreaPickViewModel *)model{
    NSLog(@"doneAreaModel %@",model.description);
}
@end
