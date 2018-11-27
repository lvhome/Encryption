//
//  ViewController.m
//  Encryption
//
//  Created by MAC on 2018/11/22.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "CommonCrypto/CommonDigest.h"
#import "LHRSA.h"
#import "LHAES.h"
#import "LHDES.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     NSLog(@"1");
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     dispatch_sync(dispatch_get_main_queue(), ^{
     NSLog(@"2- %@",[NSThread currentThread]);
     });
     });
     //或者
     dispatch_async(dispatch_get_main_queue(), ^{
     NSLog(@"4- %@",[NSThread currentThread]);
     
     });
     NSLog(@"3");
     */
    // 常用的加密算法简单使用
    //MD5加密 是HASH算法一种、 是生成32位的数字字母混合码。 MD5主要特点是 不可逆
    /*
    MD5算法还具有以下性质：
    1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。
    
    2、容易计算：从原数据计算出MD5值很容易。
    
    3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。
    
    4、弱抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。
    
    5、强抗碰撞：想找到两个不同的数据，使它们具有相同的MD5值，是非常困难的。
    */
    //终端代码：$ echo -n 123456|openssl md5 给字符串123456加密 输出是小写的
    //代码实现
    NSLog(@"小写：%@",[self lowerMD5:@"123456"]);
    NSLog(@"大写：%@",[self upperMD5:@"123456"]);
    
    //为了让MD5码更加安全 ，我们现在都采用加盐，盐要越长越乱，得到的MD5码就很难查到。
    static NSString * salt =@"asdfghjklpoiuytrewqzxcvbnm";
    NSLog(@"加盐小写：%@",[self lowerMD5:[@"123456" stringByAppendingString:salt]]);
    NSLog(@"加盐大写：%@",[self upperMD5:[@"123456" stringByAppendingString:salt]]);

    //sha1 算法是哈希算法的一种
    [self sha1:@"123456"];
    //rsa 公钥 和私钥生成
    /*RSA非对称加密算法
     非对称加密算法需要两个密钥：公开密钥（publickey）和私有密钥（privatekey）
     公开密钥与私有密钥是一对，用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；
     特点：
     非对称密码体制的特点：算法强度复杂、安全性依赖于算法与密钥但是由于其算法复杂，而使得加密解密速度没有对称加密解密的速度快
     对称密码体制中只有一种密钥，并且是非公开的，如果要解密就得让对方知道密钥。所以保证其安全性就是保证密钥的安全，而非对称密钥体制有两种密钥，其中一个是公开的，这样就可以不需要像对称密码那样传输对方的密钥了
     */
    //公钥
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVtz/hQUNiLE1prYofqLlmYtK0OupHN7wk+ZaeYVoQqk0v+1w/MIUm20BGKNjVAo9ZBH7IDWSQ25Mhh9+niizPULk+tWqvm5wWOwEy5R/dbjNmGDFCrFXC0gYAXI4uLhcVNGNWbu3mm3BVh9LmVU+d3qr1ZxILkJ+36x/VCe/vIQIDAQAB";
    //私钥
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJW3P+FBQ2IsTWmtih+ouWZi0rQ66kc3vCT5lp5hWhCqTS/7XD8whSbbQEYo2NUCj1kEfsgNZJDbkyGH36eKLM9QuT61aq+bnBY7ATLlH91uM2YYMUKsVcLSBgBcji4uFxU0Y1Zu7eabcFWH0uZVT53eqvVnEguQn7frH9UJ7+8hAgMBAAECgYBrkxpRTkWOmuqczlb63I8q5EMlwVdpCMEliDkTYDwI0XVYzrG/rate+hc60krK82Xwvmwibo0eEMetRiYMChqbWrwnNwTRP0dJGRxiaVAaS7rBW79swNhzzz985cszkJ5fo7fIym6hbZjRFBz1dwtVNsCg4Ts5OCCrEoRn163m6QJBAMPKfihawOV9IKIBJ+J/jTUojuwuw/3MPLrVth27I0F0ET7MdtFG4qpmzmZtr0ZuV7ewGqRiT1Q7MfrvoHTYJ0sCQQDDwYWG8NAlv8FO56WlEuouuq4q+Pp6XOuGR6IUa4En+E+nvkYUc6Rmqy5Q/wuyiHEfAAgwE72nJHRDdHwPSGPDAkEAvGQXSBUrDqZ7w+aAzjwVT1UbUL8e7xKaTNxeQ/VRUyWvglGS8oPWjkglygE4afi6hpD40buWwWHEEcSJDGUASQJAdzuyhyS6w6NurQ7vmAJTXa8bUtVgS5O5aYrMMD/i5WObsQJ2URK2+kod5fvTNiVhMY6lbhM4G0xa/JNA1VY0XQJAJJ8pT9ienNfAxZSgF+4Q8WIq+bnz78L/FKKYRD0BOie23rgGHtBn2XCxPS46Vh3CT9FFKEfXv4r2TiFGF3yqYg==";
    //要加密的数据
    NSString *sourceStr = @"123456";
    //公钥加密
    NSString *encryptStr = [LHRSA encryptString:sourceStr publicKey:publicKey];
    //私钥解密
    NSString *decrypeStr = [LHRSA decryptString:encryptStr privateKey:privateKey];
    NSLog(@"\n加密后的数据:%@ \n 解密后的数据:%@",encryptStr,decrypeStr);
    
  
    //AES 对称密钥加密
    //用来密钥
    NSString * key = @"123456";
    //用来发送的原始数据
    NSString * secret = @"654321";
    //用密钥加密
    NSData * result = [LHAES AES256EncryptWithKey:key encryptString:secret];
    
    //输出测试
    NSLog(@"AES加密 :%@",result);
    //解密方法
    NSData * data = [LHAES AES256DecryptWithKey:key DecryptString:result];
    NSLog(@"AES解密 :%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //DES  DES加密 ：先将内容加密一下，然后转十六进制，传过去
        //DES解密 ：把收到的数据转二进制，decode一下，然后再解密，得到原本的数据
    //用来密钥
    NSString * keyDES = @"123456";
    //用来发送的原始数据
    NSString * secretDES = @"654321";
    NSString * resultDES = [LHDES encryptUseDES2:secretDES key:keyDES];
    NSLog(@"DES加密 :%@",resultDES);
    NSString * decryptResult = [LHDES decryptUseDES:resultDES key:keyDES];
    NSLog(@"DES解密 :%@",decryptResult);

    //参考文档 https://www.jianshu.com/p/d5f932967818
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//输出小写
- (NSString *)lowerMD5:(NSString *)inPutText
{
    //传入参数,转化成char
    const char *cStr = [inPutText UTF8String];
    //开辟一个16字节的空间
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
      把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];  //大小写注意
}

//输出大写

- (NSString *)upperMD5:(NSString *)inPutText
{
    //传入参数,转化成char
    const char *cStr = [inPutText UTF8String];
    //开辟一个16字节的空间
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];  //大小写注意
}



//sha1
- (NSString *)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    //使用对应的   CC_SHA1_DIGEST_LENGTH,CC_SHA224_DIGEST_LENGTH,CC_SHA256_DIGEST_LENGTH,CC_SHA384_DIGEST_LENGTH,CC_SHA512_DIGEST_LENGTH的长度分别是20,28,32,48,64。；看你们需求选择对应的长度
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    NSLog(@"sha----->%@",output);
    return output;
}

@end
