//
//  AlUtil.m
//  Chatt
//
//  Created by 张小明 on 2017/10/20.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AlUtil.h"

@implementation AlUtil
static NSString *ChainSerice=@"chatt_Chain_Serice";

+(NSString *)reqChainId{
  NSString *uuid=  [KeyChain load:ChainSerice];
    if(!uuid){
        uuid=[self getuuid];
        [KeyChain save:ChainSerice data:uuid];
    
    }
    return uuid;
}

+ (NSString *)getuuid{
    // create a new UUID which you own
    CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidref);
    
    NSString *result = (__bridge NSString *)uuid;
    //release the uuidref
    CFRelease(uuidref);
    // release the UUID
    CFRelease(uuid);
    
    return result;
}



+(bool)deleteDistoryFile:(NSString *)filePath{
    NSFileManager *manager=[[NSFileManager alloc]init];
    
    if( [manager fileExistsAtPath:filePath]){  //如果文件存在就删除
        return  [manager removeItemAtPath:filePath error:nil];
    }
    return false;
    
    
}
@end
