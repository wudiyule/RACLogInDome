//
//  DataViewModel.h
//  RACLogInDome
//
//  Created by 马克吐温° on 2018/1/17.
//  Copyright © 2018年 马克吐温°. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACCommand;
@interface DataViewModel : NSObject
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *password;

- (RACCommand *)verifyAccountAndPasswor;

@end
