//
//  UIDevice+Info.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UIDevice+Info.h"

#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation UIDevice (Info)

+ (NSString *)name
{
    return ([[UIDevice currentDevice] name] ?: @"");
}
+ (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}
+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (NSString *)systemBuildIdentifier
{
    static NSString *__gBuildIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *build = nil;
        int mib[] = { CTL_KERN, KERN_OSVERSION };
        size_t size;
        sysctl(mib, 2, NULL, &size, NULL, 0);
        char *str = malloc(size);
        if (sysctl(mib, 2, str, &size, NULL, 0) >= 0) {
            build = [NSString stringWithCString:str encoding:NSUTF8StringEncoding];
        }
        free(str);
        __gBuildIdentifier = build ?: @"";
    });
    return __gBuildIdentifier;
}
+ (NSString *)model
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)platform
{
    static NSString *__gPlatfrom = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        free(machine);
        __gPlatfrom = platform ?: @"";
    });
    return __gPlatfrom;
}

+(NSString*)deviceString
{
    NSString * platform = [self platform];
    //    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    //    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    //    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    //    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    //    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    //    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    //    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    //    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    //    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    //    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    //    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    //    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    //    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    //    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    //    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    //
    //    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    //    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    //    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    //    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    //    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    //
    //    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    //
    //    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    //    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    //    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    //    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    //    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    //    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    //    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    //
    //    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    //    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    //    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    //    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    //    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    //    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    //
    //    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    //    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    //    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    //    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    //    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    //    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    //
    //    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    //    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"I4";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"I4";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"I4";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"I4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"I4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"I4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"I4";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"I5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"I5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"I5";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"I5";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"I5";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"I5";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"I6P";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"I6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"I6";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"I6P";
    if ([platform isEqualToString:@"i386"])      return @"I6P";
    if ([platform isEqualToString:@"x86_64"])    return @"I6P";
    
    DLog(@"NOTE: Unknown device type: %@", platform);
    return @"I6";
}

+ (NSString *)carrierString
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier_t = [netInfo subscriberCellularProvider];
    NSString *carrier = [carrier_t carrierName];
    return carrier ?: @"";
}

+ (NSString *)currentWiFiSSID
{
    NSString *ssid = nil;
#if !TARGET_IPHONE_SIMULATOR
    NSArray *interfaces = CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *name in interfaces) {
        CFStringRef interface = (__bridge CFStringRef)name; // @"en0"
        NSDictionary *info = CFBridgingRelease(CNCopyCurrentNetworkInfo(interface));
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
            break;
        }
    }
#endif
    return ssid;
}

+ (NSString *)deviceIdentifier
{
#if !TARGET_IPHONE_SIMULATOR
    //        return [OpenUDID value];
#endif
    return @"0000000000000000000000000000000000000000";
}

+ (NSString *)IDFA
{
//#if !TARGET_IPHONE_SIMULATOR
//    NSString *idfa = nil;
//    Class cls = NSClassFromString(@"ASIdentifierManager");
//    if (cls) {
//        idfa = [[[cls sharedManager] advertisingIdentifier] UUIDString];
//    }
//    return idfa ?: @"";
//#else
//    return @"00000000-0000-0000-0000-000000000000";
//#endif
////    return @"";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * idfa = esString([defaults stringForKey:kClientId]);
    if ([idfa isEqualToString:@""]) {
        idfa = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [defaults setValue:idfa forKey:kClientId];
        [defaults synchronize];
    }
    return idfa;
}

+ (BOOL)isJailBroken
{
    static BOOL __isJailBroken = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *jbApps = @[@"/Application/Cydia.app",
                            @"/Application/limera1n.app",
                            @"/Application/greenpois0n.app",
                            @"/Application/blackra1n.app",
                            @"/Application/blacksn0w.app",
                            @"/Application/redsn0w.app",
                            @"/private/var/lib/apt/",
                            ];
        for (NSString *path in jbApps) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                __isJailBroken = YES;
                break;
            }
        }
        //                if (!__isJailBroken && 0 == system("ls")) {
        //                        __isJailBroken = YES;
        //                }
    });
    
    return __isJailBroken;
}

//获取推送设置状态
+(BOOL)isAllowedNotification{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Screen

+ (CGSize)screenSize
{
    return [[UIScreen mainScreen] currentMode].size;
}

+ (NSString *)screenSizeString
{
    CGSize size = [self screenSize];
    if (size.width > size.height) {
        float t = size.width;
        size.width = size.height;
        size.height = t;
    }
    return [NSString stringWithFormat:@"%dx%d", (int)size.width, (int)size.height];
}


+ (BOOL)isIPhoneRetina4InchScreen
{
    return CGSizeEqualToSize([self screenSize], CGSizeMake(640.f, 1136.f));
}

+ (BOOL)isIPhoneRetina35InchScreen
{
    return CGSizeEqualToSize([self screenSize], CGSizeMake(640.f, 960.f));
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Locale
+ (NSTimeZone *)localTimeZone
{
    return [NSTimeZone localTimeZone];
}

+ (NSInteger)localTimeZoneFromGMT
{
    return ([[NSTimeZone localTimeZone] secondsFromGMT] / 3600);
}

+ (NSLocale *)currentLocale
{
    return [NSLocale currentLocale];
}

+ (NSString *)currentLocaleLanguageCode
{
    return [[self currentLocale] objectForKey:NSLocaleLanguageCode];
}

+ (NSString *)currentLocaleCountryCode
{
    return [[self currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)currentLocaleIdentifier
{
    return [[self currentLocale] localeIdentifier];
}

@end
