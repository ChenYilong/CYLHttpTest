

//CYLHttpTestTool.h

#import "CYLHttpTestResult.h"
#import "CYLHttpTestParam.h"
//#import "CYLHttpTestInfo.h"
#import "CYLHttpTool.h"

typedef void(^CYLHttpTestSuccess)(CYLHttpTestResult*result);

@interface CYLHttpTestTool : NSObject

+ (void)operateNetHttpTestWithParam:(CYLHttpTestParam*)param success:(CYLHttpTestSuccess)success failure:(CYLHttpFailure)failure;

@end
