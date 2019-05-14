//
//  LNBaseTableViewAPI.h
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//

#import "LCBaseRequest.h"

@interface LNBaseTableViewAPI : LCBaseRequest<LCAPIRequest>

-(instancetype) initWithUrl:(NSString *)url parameters:(NSDictionary *)param;

@end
