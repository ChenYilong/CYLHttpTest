//
//  CYLHttpTool.h
//
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 技术博客http://www.cnblogs.com/ChenYilong/. All rights reserved.
//  封装任何的http请求

#import <Foundation/Foundation.h>
/**
 *  请求成功后的回调
 *
 *  @param json 服务器返回的JSON数据
 */
typedef void (^CYLHttpSuccess)(id jsonOrXml);
/**
 *  请求失败后的回调
 *
 *  @param error 错误信息
 */
typedef void (^CYLHttpFailure)(NSError *error);


@interface CYLHttpTool : NSObject

/**
 *  发送一POST请求
 *  @param dataFormat    数据格式JSON或XML
 *  @param url    请求路径
 *  @param params 请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url dataFormat:(NSString *)dataFormat params:(NSDictionary *)params success:(CYLHttpSuccess)success failure:(CYLHttpFailure)failure;
/**
 *  发送一GET请求
 *  @param dataFormat    数据格式JSON或XML
 *  @param url    请求路径
 *  @param params 请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url dataFormat:(NSString *)dataFormat params:(NSDictionary *)params success:(CYLHttpSuccess)success failure:(CYLHttpFailure)failure;
@end
