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

-(NSArray *) getStocksForCategory:(NSString *)category{
    if([category.lowercaseString isEqualToString:@"top"]){
        return [self mockTop];
    }
    else if([category.lowercaseString isEqualToString:@"gain"]){
        return [self mockActive];
    }
    else if([category.lowercaseString isEqualToString:@"lose"]){
        return [self mockDecline];
    }
    return nil;
}

-(NSArray *) mockTop{
    return @[
             @"SAGE",
             @"MYOK",
             @"STX",
             @"VNRBP",
             @"LGCYO",
             @"AAL",
             @"XENE",
             @"DMTX",
             @"CCLP",
             @"AREX"
             ];
}

-(NSArray *) mockActive{
    return @[
             @"AMZN",
             @"QQQ",
             @"AAPL",
             @"TLT",
             @"FB",
             @"MSFT",
             @"NFLX",
             @"TSLA",
             @"INTC",
             @"GOOGL"
             ];
}

-(NSArray *) mockDecline{
    return @[
             @"LONE",
             @"ONS",
             @"VOXX",
             @"XBIT",
             @"SPU",
             @"UGLD",
             @"TTOO",
             @"PTIE",
             @"ADHD",
             @"OCUL"
             ];
}

@end
