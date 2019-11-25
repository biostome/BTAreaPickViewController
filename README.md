# BTAreaPickViewController 

地址数据采集源自[中华人民共和国行政区划 Administrative-divisions-of-China](https://github.com/modood/Administrative-divisions-of-China)
目前的数据都是最新的，会不定时更新数据。
目前仅呈现三种地址选择样式，后期更新更多样式。


## Preview
![展示](https://raw.githubusercontent.com/biostome/BTAreaPickViewController/master/AreaPicker.gif)

## Easy Usg
```objc

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


```

## Author


biostome, 453816118@qq.com

## License

BTAreaPickViewController is available under the MIT license. See the LICENSE file for more info.
