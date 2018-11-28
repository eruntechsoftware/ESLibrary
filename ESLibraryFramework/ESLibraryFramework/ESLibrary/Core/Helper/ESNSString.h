//
//  ExNSString.h
//  Eruntech
//
//  Created by 杜明悦 on 13-3-1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <CommonCrypto/CommonCryptor.h>
//#import <sqlite3.h>

@interface NSString (ESNSString)

/**
 替换字符串中指定字符
 @param searchStr 原字符串
 @param replaceStr 替换后字符串
 @return 替换后的字符串
 */
-(NSString*) replaceWithSearch:(NSString *)searchStr replace:(NSString *)replaceStr;

/**
 去除字符串左右两边的空格
 @return 去空格后的字符串
 */
-(NSString*) trim;
/**
 判断字符串是否为空
 @return 是否为空
 */
- (BOOL)isEmpty;

/**
 计算文本占用的宽高
 @param font    显示的字体
 @param maxSize 最大的显示范围
 @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 保留小数位数
 */
-(NSString *)notRounding:(float)price afterPoint:(int)position;

/**
 Base64解码
 @return Base64解码后的字符串
 */
-(NSString*) deCode;

/**
 转换为Base64编码
 @return Base64编码后的字符串
 */
-(NSString*) enCode;

/**
 char转换为UTF8转换为GBK编码
 @param val 输入char类型数据
 @return GBK编码后的字符串
 */
+(NSString*)UTF8ToGBK:(char*) val;


@end
