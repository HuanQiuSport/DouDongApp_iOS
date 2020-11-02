//
//  SHA224.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

static inline NSString *SHA_224(NSString *string){
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }return output;
}
