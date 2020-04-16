//
//  KeychainTool.m
//  RuntimeTest
//
//  Created by user on 2020/4/15.
//  Copyright © 2020 zilong. All rights reserved.
//

#import "KeychainTool.h"

@implementation KeychainTool

+ (KeychainTool *)sharedKeychain {
    static KeychainTool *shareKeychainInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareKeychainInstance = [[self alloc] init];
    });
    return shareKeychainInstance;
}

- (BOOL)addKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey value:(NSData *)value {
    NSDictionary *add = @{BRIDGE(id, kSecAttrAccessible) : BRIDGE(id, kSecAttrAccessibleWhenUnlocked),
                          BRIDGE(id, kSecClass) : BRIDGE(id, kSecClassGenericPassword),
                          BRIDGE(id, kSecValueData) : value,
                          BRIDGE(id, kSecAttrAccount) : key,
                          BRIDGE(id, kSecAttrService) : serviceKey
    };
    return [self addKeychainWithKeyDictionary:add dataValue:value];
}

- (KeychainToolStatus *)queryKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey {
    NSDictionary *quary = @{BRIDGE(id, kSecClass) : BRIDGE(id, kSecClassGenericPassword),
                            BRIDGE(id, kSecReturnData) : @YES,
                            BRIDGE(id, kSecMatchLimit) : BRIDGE(id, kSecMatchLimitOne),
                            BRIDGE(id, kSecAttrAccount) : key,
                            BRIDGE(id, kSecAttrService) : serviceKey
    };
    return [self queryKeychainWithKeyDictionary:quary];
}

- (BOOL)updateKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey changeValue:(NSData *)value {
    NSDictionary *basics = @{BRIDGE(id, kSecClass) : BRIDGE(id, kSecClassGenericPassword),
                             BRIDGE(id, kSecAttrAccount) : key,
                             BRIDGE(id, kSecAttrService) : serviceKey
    };
    return [self updateKeychainWithKeyDictionary:basics updateData:value];
}

- (BOOL)deleteKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey {
    NSDictionary *delete = @{BRIDGE(id, kSecClass) : BRIDGE(id, kSecClassGenericPassword),
                             BRIDGE(id, kSecAttrAccount) : key,
                             BRIDGE(id, kSecAttrService) : serviceKey
    };
    return [self deleteKeychainWithKeyDictionary:delete];
}

/// 添加
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
/// @param dataValue 插入的数据
- (BOOL)addKeychainWithKeyDictionary:(NSDictionary *)cfDictionary dataValue:(NSData *)dataValue {
    CFTypeRef result;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)cfDictionary, &result);
    if (status == errSecSuccess) {
        NSLog(@"添加成功");
        return YES;
    } else {
        NSLog(@"添加失败");
        return NO;
    }
}

/// 查询
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
- (KeychainToolStatus *)queryKeychainWithKeyDictionary:(NSDictionary *)cfDictionary {
    KeychainToolStatus *toolStatus = [[KeychainToolStatus alloc] init];
    CFTypeRef dataTypeRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)cfDictionary, &dataTypeRef);
    if (status == errSecSuccess) {
        NSData *data = (__bridge NSData *)dataTypeRef;
        toolStatus.executeStatus = KeyChainExecuteStatusSuccess;
        toolStatus.executeData = data;
        NSLog(@"查询成功");
    } else {
        toolStatus.executeStatus = KeyChainExecuteStatusFailure;
        NSLog(@"查询失败");
    }
    return toolStatus;
}

/// 更新
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
/// @param updateData 更新的数据
- (BOOL)updateKeychainWithKeyDictionary:(NSDictionary *)cfDictionary updateData:(NSData *)updateData {
    NSDictionary *update = @{(__bridge id)kSecValueData : updateData};
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)cfDictionary, (__bridge CFDictionaryRef)update);
    if (status == errSecSuccess) {
        NSLog(@"更新成功");
        return YES;
    } else {
        NSLog(@"更新失败");
        return NO;
    }
}

/// 删除
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
- (BOOL)deleteKeychainWithKeyDictionary:(NSDictionary *)cfDictionary {
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)cfDictionary);
    if (status == errSecSuccess) {
        NSLog(@"删除成功");
        return YES;
    } else {
        NSLog(@"删除失败");
        return NO;
    }
}

@end

@implementation KeychainToolStatus


@end
