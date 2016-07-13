//
//  SAWebServiceHelper.m
//  StocksApp
//
//  Created by Kape Man on 13/07/2016.
//  Copyright © 2016 Kape Man. All rights reserved.
//

#import "SAWebServiceHelper.h"
#import <AFNetworking/AFNetworking.h>

#define kURL @"http://dev.markitondemand.com/Api/v2/"

@implementation SAWebServiceHelper

+ (id)sharedHelper {
    static SAWebServiceHelper *sharedHelper = nil;
    @synchronized(self) {
        if (sharedHelper == nil)
            sharedHelper = [[self alloc] init];
    }
    return sharedHelper;
}

-(void) getPath:(NSString *) path withParam:(NSDictionary *) param withHandler:(void(^)(NSURLResponse *response, id  responseObject, NSError *error)) handler{
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@%@/json", kURL, path] parameters:param error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [[manager dataTaskWithRequest:req completionHandler:handler] resume];
}

@end
