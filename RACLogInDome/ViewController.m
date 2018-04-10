//
//  ViewController.m
//  RACLogInDome
//
//  Created by 马克吐温° on 2018/1/17.
//  Copyright © 2018年 马克吐温°. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "DataViewModel.h"
#import "MBProgressHUD+HM.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBT;
@property (nonatomic, strong)DataViewModel *dataViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindDataAndRefreshView];
}

- (void)bindDataAndRefreshView{
    /**<数据绑定*/
    RAC(self.dataViewModel, account) = self.accountTF.rac_textSignal;
    RAC(self.dataViewModel, password) = self.passwordTF.rac_textSignal;
    
    /**<绑定信号*/
    self.loginBT.rac_command = [self.dataViewModel verifyAccountAndPasswor];
    
    /**<信号回调--正确信号*/
    [[self.loginBT.rac_command executionSignals]subscribeNext:^(id  _Nullable x) {
        [MBProgressHUD showMessage:@"正在登陆"];
        [x subscribeNext:^(id  _Nullable x) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:x];
        }];
    }];
    
    /**<信号回调--错误信号*/
    [self.loginBT.rac_command.errors subscribeError:^(NSError * _Nullable error) {
        [MBProgressHUD showMessage:error.domain];
    }];
}

- (DataViewModel *)dataViewModel{
    if (!_dataViewModel) {
        _dataViewModel = [[DataViewModel alloc] init];
    }
    return _dataViewModel;
}

@end
