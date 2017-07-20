//
//  ExNSString.m
//  Eruntech
//
//  Created by 杜明悦 on 13-3-1.
//
//
#import "ESNSString.h"


@implementation NSString (ESNSString)

/**
 替换字符串中指定字符
 @param search：原字符串
 @param replace：替换后字符串
 @return 替换后的字符串
 */
-(NSString*) replaceWithSearch:(NSString *)searchStr replace:(NSString *)replaceStr
{
    NSMutableString *mutableStr = [NSMutableString stringWithString:self];
    if (mutableStr!=nil && [mutableStr length]>0) {
        NSRange subStr = [mutableStr rangeOfString:searchStr];
        while (subStr.location!=NSNotFound) {
            [mutableStr replaceCharactersInRange:subStr withString:replaceStr];
            subStr=[mutableStr rangeOfString:searchStr];
        }
        return mutableStr;
    }
    return NULL;
}

/**
 去除字符串左右两边的空格
 @return 去空格后的字符串
 */
-(NSString*)trim{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 判断字符串是否为空
 @return 是否为空
 */
- (BOOL)isEmpty{
    if (self!=nil) {
        return [[self trim] isEqualToString:@""];
    }
    return YES;
}

/**
 计算文本占用的宽高
 @param font    显示的字体
 @param maxSize 最大的显示范围
 @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}


/**
 Base64解码
 @return Base64解码后的字符串
 */
-(NSString*)deCode
{
        NSMutableString *result = [NSMutableString new];
        NSString *temp = @"";        
        NSString *flag = @"_";
        
        unsigned short asciiNum = 0;
        if([self isEqualToString:@""] || [self length]==0)
            return @"";
        
        for(int i = 0; i < self.length; i++)
        {
            NSRange range = NSMakeRange(i ,1);
            
            temp = [self substringWithRange:range];
            range = [temp rangeOfString:@"["];
            if(range.length>0)
            {
                i++;
                range = NSMakeRange(i ,1);
                temp = [self substringWithRange:range];
            }
            
            range = [temp rangeOfString:@"]"];
            if(range.length>0)
            {
                flag = @"_";
                continue;
            }
            
            range = [temp rangeOfString:@"~"];
            if(range.length>0)
            {
                flag = @"~";
                i++;
            }
            
            range = [temp rangeOfString:@"#"];
            if(range.length>0)
            {
                flag = @"#";
                i++;                
            }
            
            range = [temp rangeOfString:@"~"];
            if(range.length>0)
            {
                range = NSMakeRange(i ,2);
                temp = [self substringWithRange:range];
                asciiNum = strtoul([temp UTF8String],0,16);
                temp = [NSString stringWithFormat:@"%C", asciiNum];
                [result appendString:temp];
                i++;
            }
            
            range = [flag rangeOfString:@"#"];
            if(range.length>0)
            {
                range = NSMakeRange(i ,4);
                temp = [self substringWithRange:range];
                temp = [temp uppercaseString];
                range = [temp rangeOfString:@"FFFF"];
                if(range.length>0)
                {
                    i += 4;
                    range = NSMakeRange(i ,4);
                    temp = [self substringWithRange:range];
                }
                
                asciiNum = strtoul([temp UTF8String],0,16); 
                temp = [NSString stringWithFormat:@"%C", asciiNum];
                [result appendString:temp];
                i += 3;
                
            }
            
            range = [flag rangeOfString:@"_"];
            if(range.length>0)
            {
                [result appendString:temp];
            }
            
        }
        return result;
}

/**
 转换为Base64编码
 @return Base64编码后的字符串
 */
-(NSString*) enCode
{
    if ( self == nil ) {
        return self;
    }
    NSMutableString *s = [NSMutableString new];
    NSString *temp = @"";
    NSString *flag = @"_";
    
    int asciiNum = 0;
    if (self==nil || [self isEqualToString:@""])
    {
        return @"";
    }
    int n = 0;
    NSInteger length = self.length;
    
    while (n < length)
    {
        NSRange range = NSMakeRange(n ,1);
        temp = [self substringWithRange:range];
        asciiNum = [temp characterAtIndex:0];
        temp = [self toHex16:asciiNum];
        if (asciiNum > 255 ||(asciiNum <0))
        {            
            temp = [self fillLeftWithZero:temp:4];
            if ([flag isEqualToString:@"_"])
            {
                flag = @"#";
                [s appendString:@"[#"];
                [s appendString:temp];
            }
            else if ([flag isEqualToString:@"~"])
            {
                flag = @"#";
                [s appendString:@"#"];
                [s appendString:temp];
                //s += "#" + temp;
            }
            else if ([flag isEqualToString:@"#"])
            {
                [s appendString:temp];
                //s += temp ;
            }
        }
        else if ((asciiNum < 48) || (asciiNum > 57&&asciiNum < 65)||(asciiNum > 90&&asciiNum < 97)||(asciiNum >122))
        {
            temp = [self fillLeftWithZero:temp:2];
            //if (flag.equals("_"))
            if([flag isEqualToString:@"_"])
            {
                flag = @"~";
                [s appendString:@"[~"];
                [s appendString:temp];
                //s += "[~" + temp;
            }
            else if ([flag isEqualToString:@"~"])//(flag.equals("~"))
            {
                [s appendString:temp];
                //s += temp;
            }
            else if ([flag isEqualToString:@"#"])//(flag.equals("#"))
            {
                flag = @"~";
                [s appendString:@"~"];
                [s appendString:temp];
                //s += "~" + temp;
            }
            
        }
        else
        {
            //if ((flag.equals("#"))||(flag.equals("~")))
            if ([flag isEqualToString:@"#"] || [flag isEqualToString:@"~"])
            {
                flag = @"_" ;
                [s appendString:@"]"];
                NSString *charStr = [NSString stringWithFormat:@"%c", asciiNum];
                [s appendString:charStr];
                //s += "]" + (char)asciiNum;
            }
            else
            {
                NSString *charStr = [NSString stringWithFormat:@"%c", asciiNum];
                [s appendString:charStr];
                //s += (char)asciiNum;
            }
            
        }
        n ++;
    }
    
    return s;
}

/**
 char转换为UTF8转换为GBK编码
 @param val 输入char类型数据
 @return GBK编码后的字符串
 */
+(NSString*)UTF8ToGBK:(char*) val
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString* str = [[NSString alloc]initWithBytes:val length:strlen(val) encoding:enc ];
    return str;
}

/**
 字符串从左边补0
 */
-(NSString*)fillLeftWithZero:(NSString*)inStr :(int)len
{
    NSMutableString *temp = [NSMutableString new];
    NSUInteger count= inStr.length;
    while(count <len){
        [temp appendString:@"0"];
        count= temp.length;
    }
    [temp appendString:inStr];
    return temp;
}

-(NSString *)toHex16:(long long int)tmpid
{
    NSString *nLetterValue = @"";
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue = @"A";break;
            case 11:
                nLetterValue = @"B";break;
            case 12:
                nLetterValue = @"C";break;
            case 13:
                nLetterValue = @"D";break;
            case 14:
                nLetterValue = @"E";break;
            case 15:
                nLetterValue = @"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }          
    }
    return str;
}

-(int)toHex10:(NSString*)tmpid
{
    int int_ch;
    
    unichar hex_char1 = [tmpid characterAtIndex:0]; ////两位16进制数中的第一位(高位*16)
    int int_ch1;
    if(hex_char1 >= '0' && hex_char1 <='9')
        int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
    else if(hex_char1 >= 'A'&& hex_char1 <='F')
    {
        int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
    }
    else
    {
        int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
    }
    
    unichar hex_char2 = [tmpid characterAtIndex:1]; ///两位16进制数中的第二位(低位)
    int int_ch2;
    if(hex_char2 >= '0'&& hex_char2 <='9')
    {
        int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
    }
    else if(hex_char1 >= 'A'&& hex_char1 <='F')
    {
        int_ch2 = hex_char2-55; //// A 的Ascll - 65
    }
    else
    {
        int_ch2 = hex_char2-87; //// a 的Ascll - 97
    }
    int_ch = int_ch1+int_ch2;
    NSLog(@"int_ch=%d",int_ch);
    return int_ch;
}

@end
