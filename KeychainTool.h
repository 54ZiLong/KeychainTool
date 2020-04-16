//
//  KeychainTool.h
//  RuntimeTest
//
//  Created by user on 2020/4/15.
//  Copyright © 2020 zilong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BRIDGE(type, object) (__bridge type)object

typedef NS_ENUM(NSInteger, KeyChainExecuteStatus) {
    KeyChainExecuteStatusFailure = 0,// 操作失败
    KeyChainExecuteStatusSuccess// 操作成功
};

@interface KeychainToolStatus : NSObject

/// 执行状态
@property (nonatomic, assign) KeyChainExecuteStatus executeStatus;
/// 数据
@property (nonatomic, strong) NSData *executeData;

@end

@interface KeychainTool : NSObject

+ (KeychainTool *)sharedKeychain;

//===============================  快捷存储 ============================

/// 增加Keychain
/// @param key 标识（主标识）
/// @param serviceKey 标识（副标识）
/// @param value 插入的值 须转成NSData类型
- (BOOL)addKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey value:(NSData *)value;

/// 查询
/// @param key 标识（主标识）
/// @param serviceKey 标识（副标识）
- (KeychainToolStatus *)queryKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey;

/// 更新
/// @param key 标识（主标识）
/// @param serviceKey 标识（副标识）
/// @param value 更新的值 插入的值 须转成NSData类型
- (BOOL)updateKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey changeValue:(NSData *)value;

/// 删除
/// @param key 标识（主标识）
/// @param serviceKey 标识（副标识）
- (BOOL)deleteKeychainWithKey:(NSString *)key serviceKey:(NSString *)serviceKey;

//============================== 自定义存储 ===================================


/// 添加
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
/// @param dataValue 插入的数据
- (BOOL)addKeychainWithKeyDictionary:(NSDictionary *)cfDictionary dataValue:(NSData *)dataValue;

/// 查询
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
- (KeychainToolStatus *)queryKeychainWithKeyDictionary:(NSDictionary *)cfDictionary;

/// 更新
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
/// @param updateData 更新的数据
- (BOOL)updateKeychainWithKeyDictionary:(NSDictionary *)cfDictionary updateData:(NSData *)updateData;

/// 删除
/// @param cfDictionary 自定义Dictionary 包含类型和标识等
- (BOOL)deleteKeychainWithKeyDictionary:(NSDictionary *)cfDictionary;

@end



NS_ASSUME_NONNULL_END
