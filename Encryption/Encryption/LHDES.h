//
//  LHDES.h
//  Encryption
//
//  Created by MAC on 2018/11/27.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHDES : NSObject
+ (NSString *)encryptUseDES2:(NSString *)content key:(NSString *)key;
+ (NSString *)decryptUseDES:(NSString *)content key:(NSString *)key;

@end
