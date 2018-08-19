//
//  Helper.m
//  macOSSnippet
//
//  Created by user on 2018/08/19.
//  Copyright © 2018年 coolchic. All rights reserved.
//

#import "Helper.h"

@implementation Helper

// https://jongampark.wordpress.com/2008/12/23/resolving-aliases-using-cocoa/
+ (NSString *)identifyOriginalPath:(NSString *)aliasPath
{
    NSString *resolvedPath = nil;
    
    CFURLRef url = CFURLCreateWithFileSystemPath( kCFAllocatorDefault,
                                                 (CFStringRef)aliasPath,
                                                 kCFURLPOSIXPathStyle, NO);
    if (url != NULL)
    {
        FSRef fsRef;
        if (CFURLGetFSRef(url, &fsRef))
        {
            Boolean targetIsFolder, wasAliased;
            OSErr err = FSResolveAliasFile (&fsRef, true, &targetIsFolder, &wasAliased);
            if ((err == noErr) && wasAliased)
            {
                CFURLRef resolvedUrl = CFURLCreateFromFSRef(kCFAllocatorDefault, &fsRef);
                if (resolvedUrl != NULL)
                {
                    resolvedPath = (NSString*)CFURLCopyFileSystemPath(resolvedUrl, kCFURLPOSIXPathStyle);
                    CFRelease(resolvedUrl);
                }
            }
        }
        CFRelease(url);
    }
    
    // If not resolved, just pass the aliasPath
    if (resolvedPath == nil)
    {
        resolvedPath = [[NSString alloc] initWithString:aliasPath];
    }
    
    return [resolvedPath autorelease];
}

+ (NSString *)newIdentifyOriginalPath:(NSString *)aliasPath
{
    NSURL *url = [NSURL fileURLWithPath:aliasPath];
    CFErrorRef *errorRef = NULL;
    CFDataRef bookmark = CFURLCreateBookmarkDataFromFile (NULL, (CFURLRef)url, errorRef);
    if (bookmark == NULL){
        return aliasPath;
    }
    CFURLRef resolvedUrl = CFURLCreateByResolvingBookmarkData (NULL,
                                                               bookmark,
                                                               kCFBookmarkResolutionWithoutUIMask,
                                                               NULL,
                                                               NULL,
                                                               false,
                                                               errorRef);
    CFRelease(bookmark);
    if (resolvedUrl == NULL){
        return aliasPath;
    }
    NSString *resolvedPath = [(NSURL *)resolvedUrl path];
    CFRelease(resolvedUrl);
    return resolvedPath;
}


@end
