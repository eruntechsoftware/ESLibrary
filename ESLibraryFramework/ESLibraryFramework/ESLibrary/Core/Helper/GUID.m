//
//  GUID.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-26.
//
//

#import "GUID.h"

@implementation GUID


+(NSString*)newGUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}
@end
