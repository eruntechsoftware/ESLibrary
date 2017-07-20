//
//  File.h
//  Eruntech
//  获取当前应用程序操作文件夹
//  Created by 杜明悦 on 12-12-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>  
#import <Foundation/NSFileManager.h>  
#import <Foundation/NSAutoreleasePool.h>  
#import <Foundation/NSPathUtilities.h>  

@interface ESFile : NSObject {
    
}


/**
 获取document路径
 @return 文件夹路径
 */
+(NSString*) documentPath;

/**
 获取缓存目录
 @return 文件夹路径
 */
+(NSString*) cachesPath;

/**
 获取应用程序根目录
 @return 文件夹路径
 */
+(NSString*) homePath;

/**
 获取应用程序临时目录
 @return 文件夹路径
 */
+(NSString*) tmpPath;

/**
 读取指定路径下的文件内容
 @param fileName 文件名，不包含后缀名
 @param type 后缀名
 @return 文件内容
 */
+(NSMutableString*) readFile:(NSString*)fileName extension:(NSString*)type;

/**
 查找指定文件的路径
 @param fileName 文件名，不包含后缀名
 @param type 后缀名
 @return 文件路径
 */
+(NSString*) findFile:(NSString*)fileName extension:(NSString*)type;

/**
 复制文件到指定位置
 @param sourcePath 源文件路径
 @param targetPath 目标路径
 @return 是否成功复制
 */
+(BOOL) copyFileWithSourcePath:(NSString*)sourcePath target:(NSString*)targetPath;

/**
 检查文件是否存在
 @param filePath 文件路径
 @return 是否存在
 */
+(BOOL) existsWithPath:(NSString*)filePath;
@end
