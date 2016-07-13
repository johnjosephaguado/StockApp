//
//  SAWebServiceHelper.h
//  StocksApp
//
//  Created by Kape Man on 13/07/2016.
//  Copyright © 2016 Kape Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAWebServiceHelper : NSObject

+ (id)sharedHelper;
-(void) getPath:(NSString *) path withParam:(NSDictionary *) param withHandler:(void(^)(NSURLResponse *response, id  responseObject, NSError *error)) handler;
-(NSArray *) getStocksForCategory:(NSString *)category;
@end
