//
//  File.m
//  Eruntech
//
//  Created by 杜明悦 on 12-12-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESFile.h"


@implementation ESFile

/**
 获取document路径
 @return 文件夹路径
 */
+(NSString*) documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    return documents;
}

/**
 获取缓存目录
 @return 文件夹路径
 */
+(NSString*) cachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches = [paths objectAtIndex:0];
    return caches;
}

/**
 获取应用程序根目录
 @return 文件夹路径
 */
+(NSString*) homePath
{
    return NSHomeDirectory();
}

/**
 获取应用程序临时目录
 @return 文件夹路径
 */
+(NSString*) tmpPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

/**
 读取指定路径下的文件内容
 @param fileName 文件名，不包含后缀名
 @param type 后缀名
 @return 文件内容
 */
+(NSMutableString*) readFile:(NSString*)fileName extension:(NSString*)type
{
    NSString *filePath = [[NSBundle mainBundle] 
                            pathForResource:fileName 
                            ofType:type]; 
    NSMutableString *fileContent=[NSMutableString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]; 
    NSLog(@"bundel file path: %@ \nfile content: %@",filePath,fileContent);
    return fileContent;
}

/**
 查找指定文件的路径
 @param fileName 文件名，不包含后缀名
 @param type 后缀名
 @return 文件路径
 */
+(NSString*) findFile:(NSString*)fileName extension:(NSString*)type
{
    return  [[NSBundle mainBundle] pathForResource:fileName ofType:type]; 
}

/**
 复制文件到指定位置
 @param sourcePath 源文件路径
 @param targetPath 目标路径
 @return 文件是否存在
 */
+(BOOL) copyFileWithSourcePath:(NSString*)sourcePath target:(NSString*)targetPath
{
    BOOL isDir;
    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    //检查源文件路径是否为目录
    [fileManager fileExistsAtPath:sourcePath isDirectory:&isDir];
    if (isDir) {
        NSException *exception = [NSException exceptionWithName: @"FileException"
                                                         reason: @"源文件路径不能为目录！"
                                                       userInfo: nil];
        @throw exception;
    }
    else
    {
    //检查目标文件路径是否为目录
    [fileManager fileExistsAtPath:targetPath isDirectory:&isDir];
    if (isDir) {
        NSException *exception = [NSException exceptionWithName: @"FileException"
                                                         reason: @"目标文件路径不能为目录！"
                                                       userInfo: nil];
        @throw exception;
    }
    }
    
    if (isDir==NO) {
        //检查目标文件是否存在
        if ([sourcePath pathExtension]) {
            if ([fileManager isReadableFileAtPath:sourcePath]) {
                NSError *err;
                //删除目标文件,防止写入失败
                [fileManager removeItemAtPath:targetPath error:&err];
                if ([fileManager copyItemAtPath:sourcePath toPath:targetPath error:&err]==YES) {
                    NSLog(@"%@",@"成功创建目标文件！");
                    return TRUE;
                }
                else
                {
                    NSException *exception = [NSException exceptionWithName: @"FileException"
                                                                     reason: @"源文件复制到目标路径时出现错误！"
                                                                   userInfo: nil];
                    @throw exception;
                }
            }
            else
            {
                NSException *exception = [NSException exceptionWithName: @"FileException"
                                                                 reason: @"无法读取源文件，请重新检查文件！"
                                                               userInfo: nil];
                @throw exception;
            }
        }
        else
        {
            NSException *exception = [NSException exceptionWithName: @"FileException"
                                                             reason: @"源文件路径无效，请重新检查文件！"
                                                           userInfo: nil];
            @throw exception;
        }
    }
    return FALSE;
}

/**
 检查文件是否存在
 @param filePath 文件路径
 @return 文件是否存在
 */
+(BOOL) existsWithPath:(NSString*)filePath
{
    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}
@end
