//
//  Test.m
//  CKHCrashPreventor
//
//  Created by Kenway-Pro on 2019/5/28.
//  Copyright © 2019 Kenway. All rights reserved.
//

#import "Test.h"
#import <UIKit/UIKit.h>

@implementation Test

+ (NSString *)getID{
    NSString *readUserData = (NSString *)[self load:@"idfv_Key"];
    if (!readUserData)
    {//如果是第一次 肯定获取不到 这个时候就存储一个
        
        NSString *deviceIdStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];//获取IDFV
        //NSLog(@"identifierStr==%@",identifierStr);
        
        //进行存储 并返回这个数据
        [self save:@"idfv_Key" data:deviceIdStr];
        
        return deviceIdStr;
    }else{
        return readUserData;
    }
    
    return readUserData;
}

+ (NSMutableDictionary *)getValueForKey:(NSString *)key{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys: (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass, key, (__bridge id)kSecAttrService, key, (__bridge id)kSecAttrAccount, (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible, nil];
}

//储存
+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service
{
    id ret = nil;
    
    NSMutableDictionary *keychainQuery = [self getValueForKey:service];
    
    //Configure the search setting
    
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {NSLog(@"Unarchive of %@ failed: %@", service, e);}
        @finally
        {}
    }
    
    if (keyData)
        CFRelease(keyData);
    
    return ret;
}

@end
