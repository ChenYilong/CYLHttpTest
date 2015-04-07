//
//  NSDictionary+SwitchKeyLowercase.m
//  CYLKDTXMLDemo
//
//  Created by CHENYI LONG on 14-10-22.
//  Copyright (c) 2014年 CHENYI LONG. All rights reserved.
//

#import "NSDictionary+SwitchKeyLowercase.h"

@implementation NSDictionary (SwitchKeyLowercase)
- (NSMutableDictionary *)switchKeyLowercase {
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]
                                       initWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
 
        id oneValue = [self valueForKey:key];
        id oneCopy = nil;
        //        value是字典
        if ([oneValue respondsToSelector:@selector(switchKeyLowercase)])
        {
            oneCopy = [oneValue switchKeyLowercase];
        }
        //        value不是字典
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
        {
            if ([oneValue isKindOfClass:[NSArray class]]) {
                NSArray *oneValueArr = oneValue;
                NSMutableArray *oneVallueMutableArr = [NSMutableArray arrayWithCapacity:[oneValueArr count]];
                for (NSDictionary *obj in oneValueArr) {
//                    肯定是字典
                   [oneVallueMutableArr addObject:[obj switchKeyLowercase]];
            }
                oneCopy = oneVallueMutableArr;
        }
            //如果不是数组
            else
            {oneCopy = [oneValue mutableCopy];}
        }
        //        value是nil
        if (oneCopy == nil)
        {
            oneCopy = [oneValue copy];
        }
        
        [returnDict setValue:oneCopy forKey:[key lowercaseString]];
    }
    return returnDict;
}

@end
