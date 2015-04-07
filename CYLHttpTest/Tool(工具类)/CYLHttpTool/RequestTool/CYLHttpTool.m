//
//  CYLHttpTool.h
//
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 技术博客http://www.cnblogs.com/ChenYilong/. All rights reserved.
//  封装任何的http请求

#import "CYLHttpTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "XMLReader.h"
#import "XMLWriter.h"
#import "NSDictionary+SwitchKeyLowercase.h"

@implementation CYLHttpTool

+ (void)postWithURL:(NSString *)url dataFormat:(NSString *)dataFormat params:(NSDictionary *)params success:(CYLHttpSuccess)success failure:(CYLHttpFailure)failure
{
    [self requestWithMethod:@"POST" url:url dataFormat:dataFormat params:params success:success failure:failure];
}

+ (void)getWithURL:(NSString *)url dataFormat:(NSString *)dataFormat params:(NSDictionary *)params success:(CYLHttpSuccess)success failure:(CYLHttpFailure)failure
{
    [self requestWithMethod:@"GET" url:url dataFormat:dataFormat params:params success:success failure:failure];
}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url dataFormat:(NSString *)dataFormat params:(NSDictionary *)params success:(CYLHttpSuccess)success failure:(CYLHttpFailure)failure
{
    if ([dataFormat isEqualToString:@"XML"]) {
        NSString *xmlStr = [XMLWriter XMLStringFromDictionary:params withHeader:NO];
        NSURL *urls = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urls];
        [request setTimeoutInterval:20.f];
        [request setHTTPMethod:method];
        NSString *msgLength = [NSString stringWithFormat:@"%d", [xmlStr length]];
        [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request setValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: [xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc]initWithRequest:request];
        NSLog(@"CYLHttpTool类向服务器POST的字符串\n%@", xmlStr);

        // 3.创建操作对象
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            id xml = [XMLReader dictionaryForXMLData:(NSData *)responseObject
                                           options:XMLReaderOptionsProcessNamespaces
                                           error:&error];
//            将XML的key统一转为小写
            NSDictionary *xmlKeyLowercase = [xml switchKeyLowercase];
            success(xmlKeyLowercase);
            NSLog(@"CYLHttpTool类_(requestWithMethod:url:params:success:failure:方法)\n成功后\n打印返回值\n%@", xmlKeyLowercase);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // 请求失败的时候会调用这里的代码
             // 通知外面的block，请求成功了
             if (failure) {
                 failure(error);
             }
         }];
        // 4.执行操作（真正发送请求）
        [operation start];
    }
    else if ([dataFormat isEqualToString:@"JSON"]) {
    // 1.创建client对象，设置url路径
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:url]];
    // 2.创建请求对象
        NSMutableURLRequest *request = [client requestWithMethod:method path:nil parameters:params];
        [request addValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"text/javascript" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"CYLHttpTool类_(requestWithMethod:url:params:success:failure:方法)打印参数%@",params);
    // 3.创建操作对象
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 请求成功的时候会调用这里的代码
        // 通知外面的block，请求成功了
        if (success) {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(json);
                NSLog(@"✅✅✅✅✅✅✅CYLHttpTool类_(requestWithMethod:url:params:success:failure:方法)打印返回值\n%@", json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求失败的时候会调用这里的代码
        
        // 通知外面的block，请求成功了
        if (failure) {
            failure(error);
        }
    }];
    // 4.执行操作（真正发送请求）
    [operation start];
    }
}

@end
