//
//  LNBaseTableViewAPI.m
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//


#import "LNBaseTableViewAPI.h"

@interface LNBaseTableViewAPI ()

@property (strong , nonatomic) NSString *url;

@end

@implementation LNBaseTableViewAPI

-(instancetype)initWithUrl:(NSString *)url parameters:(NSDictionary *)param {
    self = [super init];
    if (self) {
        self.requestArgument = param;
        self.url = url;
    }
    return self;
}
// 接口地址
- (NSString *)apiMethodName{
    return [NSString stringWithFormat:@"%@",self.url];
}

// 请求方式
- (LCRequestMethod)requestMethod{
    return LCRequestMethodPost;
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
    return NO;
}

- (BOOL)useCustomApiMethodName{
    return NO;
}

- (BOOL)removesKeysWithNullValues{
    return YES;
}

- (void)dealloc{
    //    [super dealloc];
    NSLog(@"%s", __func__);
}
@end
