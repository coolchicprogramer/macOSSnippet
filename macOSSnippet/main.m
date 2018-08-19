//
//  main.m
//  macOSSnippet
//
//  Created by user on 2018/08/19.
//  Copyright © 2018年 coolchic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSLog(@"%@", [Helper identifyOriginalPath:@"/Users/user/Documents/alias"]);
        NSLog(@"%@", [Helper newIdentifyOriginalPath:@"/Users/user/Documents/alias"]);
    }
    return 0;
}
