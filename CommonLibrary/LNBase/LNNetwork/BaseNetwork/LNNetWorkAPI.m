//
//  LNNetWorkAPI.m
//  MobileProject
//
//  Created by 云网通 on 2017/1/13.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "LNNetWorkAPI.h"
@interface LNNetWorkAPI ()
@property (strong , nonatomic) NSString *url;
@property (assign , nonatomic) LCRequestMethod method;
@property (assign , nonatomic) BOOL ignoreUnified;
@property (assign , nonatomic) BOOL isuseCustomApiMethodName;
@end
@implementation LNNetWorkAPI

-(instancetype) initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        
        self.url = url;
        self.method = LCRequestMethodPost;
        self.ignoreUnified = NO;
        self.isuseCustomApiMethodName = NO;
    }
    return self;
}
-(instancetype) initWithUrl:(NSString *)url parameters:(NSDictionary *) param {
    self = [super init];
    if (self) {
        self.requestArgument = param;
        self.url = url;
        self.ignoreUnified = NO;
        self.method = LCRequestMethodPost;
        self.isuseCustomApiMethodName = NO;
        
    }
    return self;
}
-(instancetype) initWithUrl:(NSString *)url parameters:(NSDictionary *) param method:(LCRequestMethod )method{
    self = [super init];
    if (self) {
        self.requestArgument = param;
        self.url = url;
        self.method = (method);
        self.ignoreUnified = NO;
        self.isuseCustomApiMethodName = NO;
    }
    
    return self;

}
-(instancetype) initWithUrl:(NSString *)url parameters:(NSDictionary *) param method:(LCRequestMethod )method ignoreUnified :(BOOL)ignoreUnified{
    self = [super init];
    if (self) {
        self.requestArgument = param;
        self.url = url;
        self.method = (method);
        self.ignoreUnified = ignoreUnified;
        self.isuseCustomApiMethodName = NO;
    }
    return self;
}

-(instancetype) initWithUrl:(NSString *)url parameters:(NSDictionary *) param method:(LCRequestMethod )method isuseCustomApiMethodName :(BOOL)isuseCustomApiMethodName {
    self = [super init];
    if (self) {
        self.requestArgument = param;
        self.url = url;
        self.method = (method);
        self.ignoreUnified = NO;
        self.isuseCustomApiMethodName = isuseCustomApiMethodName;
    }
    
    return self;

}
// 接口地址
- (NSString *)apiMethodName{
    return [NSString stringWithFormat:@"%@",self.url];
}

// 请求方式
- (LCRequestMethod)requestMethod{
    return self.method;
}

// 是否缓存数据
- (BOOL)cacheResponse{
    return NO;
}

- (id)responseProcess:(id)responseObject{
    return responseObject;
}

// 忽略统一的 Response 加工
- (BOOL)ignoreUnifiedResponseProcess{
    return self.ignoreUnified;
}

- (BOOL)useCustomApiMethodName{
    return self.isuseCustomApiMethodName;
}

- (BOOL)removesKeysWithNullValues{
    return YES;
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]multipart/form-data
         4. 上传文件的[mimeType]
         */
        for (int i=0; i<self.imageArray.count; i++) {
            UIImage *image = self.imageArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
            
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = [NSString stringWithFormat:@"yyyyMMddHHmmssios%d",i];
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"multipart/form-data"];
        }
    };
}

- (void)dealloc{
//    [super dealloc];
    NSLog(@"%s", __func__);
}
@end
