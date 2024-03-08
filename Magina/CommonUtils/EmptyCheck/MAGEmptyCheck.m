//
//  MAGEmptyCheck.m
//  Magina
//
//  Created by AM on 2021/7/27.
//

#import "MAGEmptyCheck.h"

BOOL IsEmptyString(NSString *param)
{
    return ( !(param) ? YES : ([(param) isKindOfClass:[NSString class]] ? (param).length == 0 : NO) );
}

BOOL IsEmptyArray(NSArray *param)
{
    return ( !(param) ? YES : ([(param) isKindOfClass:[NSArray class]] ? (param).count == 0 : NO) );
}

BOOL IsEmptyDictionary(NSDictionary *param)
{
    return ( !(param) ? YES : ([(param) isKindOfClass:[NSDictionary class]] ? (param).count == 0 : NO) );
}
