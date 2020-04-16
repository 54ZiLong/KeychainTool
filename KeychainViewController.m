//
//  KeychainViewController.m
//  RuntimeTest
//
//  Created by user on 2020/4/15.
//  Copyright © 2020 zilong. All rights reserved.
//

#import "KeychainViewController.h"
#import <Security/Security.h>
#import "KeychainTool.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface KeychainViewController ()

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *keyField;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *queryBtn;
@property (nonatomic, strong) UIButton *updateBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) KeychainTool *keychainTool;

@end

@implementation KeychainViewController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.keyField];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.queryBtn];
    [self.view addSubview:self.updateBtn];
    [self.view addSubview:self.deleteBtn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark - Action

- (void)addAction {
    BOOL success = [[KeychainTool sharedKeychain] addKeychainWithKey:self.phoneField.text serviceKey:@"test" value:[self.keyField.text dataUsingEncoding:NSUTF8StringEncoding]];
    if (success) {
        // 成功
    } else {
        // 失败
    }
}

- (void)queryAction {
    KeychainToolStatus *queryStatus = [[KeychainTool sharedKeychain] queryKeychainWithKey:self.phoneField.text serviceKey:@"test"];
    if (queryStatus.executeStatus == KeyChainExecuteStatusSuccess) {
        // 查询成功
        
        NSLog(@"查询成功 %@", [[NSString alloc] initWithData:queryStatus.executeData encoding:NSUTF8StringEncoding]);
    } else {
        // 查询失败
        NSLog(@"查询失败");
    }
}

- (void)updateAction {
    BOOL success = [[KeychainTool sharedKeychain] updateKeychainWithKey:self.phoneField.text serviceKey:@"test" changeValue:[self.keyField.text dataUsingEncoding:NSUTF8StringEncoding]];
    if (success) {
        // 成功
    } else {
        // 失败
    }
}

- (void)deleteAction {
    BOOL success = [[KeychainTool sharedKeychain] deleteKeychainWithKey:self.phoneField.text serviceKey:@"test"];
    if (success) {
        // 成功
    } else {
        // 失败
    }
}

#pragma mark - Get

- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH - 60, 40)];
        _phoneField.backgroundColor = [UIColor grayColor];
        _phoneField.textColor = [UIColor blackColor];
        _phoneField.placeholder = @"号码";
    }
    return _phoneField;
}

- (UITextField *)keyField {
    if (!_keyField) {
        _keyField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH - 60, 40)];
        _keyField.backgroundColor = [UIColor grayColor];
        _keyField.textColor = [UIColor blackColor];
        _keyField.placeholder = @"密码";
    }
    return _keyField;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 170, 60, 40)];
        _addBtn.backgroundColor = [UIColor cyanColor];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)queryBtn {
    if (!_queryBtn) {
        _queryBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 170, 60, 40)];
        _queryBtn.backgroundColor = [UIColor cyanColor];
        [_queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(queryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryBtn;
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 240, 60, 40)];
        _updateBtn.backgroundColor = [UIColor cyanColor];
        [_updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_updateBtn setTitle:@"更新" forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 240, 60, 40)];
        _deleteBtn.backgroundColor = [UIColor cyanColor];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (KeychainTool *)keychainTool {
    if (!_keychainTool) {
        _keychainTool = [[KeychainTool alloc] init];
    }
    return _keychainTool;
}

@end
