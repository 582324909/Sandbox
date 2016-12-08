//
//  ViewController.m
//  沙盒
//
//  Created by 张伟伟 on 2016/12/8.
//  Copyright © 2016年 张伟伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    // 沙盒目录操作
    // 文件创建
    NSString *path = [self fileCreate:@"myInfo.plist"];
    // 文件写
    //[self writeFileByDictionary:path];
    // 文件读
    [self readFileByDictionary:path];
    
    // 普通字符串操作
    //    NSString *path2 = [self fileCreate:@"myInfo.txt"];
    //    [self writeFileByString:path2];
    
    // 本地项目文件读取
    //[self readFileFromProject];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -文件存储
/**
 * 文件创建 并返回创建的地址
 */
- (NSString *)fileCreate:(NSString *)path {
    // 1.创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 2.获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    // 3.定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:path];
    NSLog(@"filePath=%@", filePath);
    
    // 4.查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
    
}

/**
 * 文件读取 此处是字典类型读取
 */
- (void)readFileByDictionary: (NSString *)filePath {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"readFile...dict=%@", dict);
}

/**
 * 文件写入 此处是字典类型读取写入
 */
- (void)writeFileByDictionary: (NSString *)filePath {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"zww123" forKey:@"name"];
    NSLog(@"WriteFile...filePath=%@", filePath);
    [dict writeToFile:filePath atomically:YES];
}

/**
 * 文件写入 此处是普通字符串写入
 */
- (void)writeFileByString: (NSString *)filePath {
    // 1、创建数据缓冲区
    NSMutableData *writer = [[NSMutableData alloc] init];
    // 2、将字符串添加到缓冲中
    [writer appendData:[@"Hello World" dataUsingEncoding:NSUTF8StringEncoding]];
    // 3、将其他数据添加到缓冲中
    //将缓冲的数据写入到文件中
    [writer writeToFile:filePath atomically:YES];
}

#pragma mark -项目目录下文件操作
/**
 * 文件读取 此处是项目目录文件下的文件读取
 */
- (void)readFileFromProject {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"project" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"project...dict=%@", dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
