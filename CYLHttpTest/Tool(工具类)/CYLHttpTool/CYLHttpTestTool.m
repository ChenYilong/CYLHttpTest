
#define SEVERURL @"http://123.57.73.61/mf/handler.aspx?api=Question.GetList"

#import "CYLHttpTestTool.h"
#import "MJExtension.h"

@implementation CYLHttpTestTool

+ (void)operateNetHttpTestWithParam:(CYLHttpTestParam*)param success:(CYLHttpTestSuccess)success failure:(CYLHttpFailure)failure {
    
    // 1.封装请求参数
    NSDictionary *params = param.keyValues;
    NSLog(@"CYLHttpTestTool将模型转为字典\n%@",params);
    NSString *urlStr = SEVERURL;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 2.发送请求
    [CYLHttpTool postWithURL:urlStr dataFormat:@"JSON" params:params success:^(id jsonOrXml) {
//        NSLog("%@",jsonOrXml);
            [jsonOrXml writeToFile:@"/Users/chenyilong/Documents/咨询记录接口返回值.plist" atomically:YES];
        CYLHttpTestResult *result = [CYLHttpTestResult objectWithKeyValues:jsonOrXml];
        success(result);
    }failure:failure];
}
@end
//使用方法如何封装AFNetworking XML解析之Model封装