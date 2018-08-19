//
//  Helper.h
//  macOSSnippet
//
//  Created by user on 2018/08/19.
//  Copyright © 2018年 coolchic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSString *)identifyOriginalPath:(NSString *)aliasPath;
+ (NSString *)newIdentifyOriginalPath:(NSString *)aliasPath;

@end
