/*
 * Copyright (c) 2017 Frank Morgner
 *
 * This file is part of NotificationProxy.
 *
 * NotificationProxy is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * NotificationProxy is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * NotificationProxy.  If not, see <http://www.gnu.org/licenses/>.
 */

/* based on http://stackoverflow.com/a/36670245 */

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[])
{
    NSString *sTitle = @"";
    NSString *sSubTitle = @"";
    NSString *sText = @"";
    NSString *sIcon = @"";
    NSString *sSound = @"";
    NSString *sId = @"";
    @try {
        sTitle = @(argv[1]);
        sSubTitle = @(argv[2]);
        sText = @(argv[3]);
        sIcon = @(argv[4]);
        sId = @(argv[5]);
        sSound = @(argv[6]);
    } @catch (...) {
    }
    
    if (argc <= 1) {
        NSString *script = @"tell app \"Keychain Access\" to activate";
        NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
        [appleScript executeAndReturnError:nil];
        exit(0);
    }
    
    NSUserNotification *n = [[NSUserNotification alloc] init];
    
    if (![sTitle isEqualToString:@""]) {
        n.title = sTitle;
    }
    
    if (![sSubTitle isEqualToString:@""]) {
        n.subtitle = sSubTitle;
    }
    
    if (![sText isEqualToString:@""]) {
        n.informativeText = sText;
    }
    
    if (![sIcon isEqualToString:@""]) {
        NSURL *fileURL = [NSURL fileURLWithPath:@"file://"];
        NSURL *imageURL = [NSURL URLWithString:sIcon relativeToURL:fileURL];
        n.contentImage = [[NSImage alloc] initWithContentsOfURL:imageURL];
    }
    
    if (![sSound isEqualToString:@""]) {
        n.soundName = sSound;
    }
    
    if (![sId isEqualToString:@""]) {
        NSMutableDictionary *sInfo = [NSMutableDictionary dictionary];
        sInfo[@"sId"] = sId;
        n.userInfo = sInfo;
        
        NSUserNotificationCenter *c = [NSUserNotificationCenter defaultUserNotificationCenter];
        for (NSUserNotification *n in c.deliveredNotifications) {
            if ([n.userInfo[@"sId"] isEqualToString:sId]) {
                [c removeDeliveredNotification:n];
            }
        }
    }
    
    [NSUserNotificationCenter.defaultUserNotificationCenter deliverNotification:n];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    
    return 0;
    
}
