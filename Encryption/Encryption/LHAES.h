//
//  LHAES.h
//  Encryption
//
//  Created by MAC on 2018/11/27.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHAES : NSObject


+ (NSData *)AES256EncryptWithKey:(NSString *)key encryptString:(NSString *)str;   //加密
+ (NSData *)AES256DecryptWithKey:(NSString *)key DecryptString:(NSData *)str;   //解密

@end
