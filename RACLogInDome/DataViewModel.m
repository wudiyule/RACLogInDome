//
//  DataViewModel.m
//  RACLogInDome
//
//  Created by 马克吐温° on 2018/1/17.
//  Copyright © 2018年 马克吐温°. All rights reserved.
//

#import "DataViewModel.h"
#import "ReactiveObjC.h"
#import "MBProgressHUD+HM.h"
#define verifyNumber 3
@interface DataViewModel()
@end

@implementation DataViewModel
#pragma mark -
#pragma mark ----------本地验证用户名&&密码----------
- (RACCommand *)verifyAccountAndPasswor{
    /**<验证账号*/
    RACSignal *accountSignal = [RACObserve(self, account) map:^id _Nullable(NSString *str) {
        return @(str.length >= verifyNumber ? YES : NO);
    }];
    /**<验证密码*/
    RACSignal *passwordSignal = [RACObserve(self, password) map:^id _Nullable(NSString *str) {
        return @(str.length >= verifyNumber ? YES : NO);
    }];
    /**<合并账号,密码 信号量*/
    RACSignal *combineLatest = [RACSignal combineLatest:@[accountSignal, passwordSignal] reduce:^id (NSNumber *accountValue, NSNumber *passwordValue){
        return @([accountValue boolValue] && [passwordValue boolValue]);
    }];
    /**<返回验证结果*/
    return [[RACCommand alloc] initWithEnabled:combineLatest signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self logInWithAccount:self.account password:self.password];
    }];
}
#pragma mark -
#pragma mark ----------模拟网路登陆----------
- (RACSignal *)logInWithAccount:(NSString *)account password:(NSString *)password{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            /**<请求成功发送信号*/
            [subscriber sendNext:@"登陆成功"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
