#import "wifi.h"
#import <NetworkExtension/NetworkExtension.h>
#import <CoreLocation/CoreLocation.h>

@implementation wifi

- (void) getConnectedInfo:(CDVInvokedUrlCommand *)command{
    CLLocationManager *manager;
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
    
    NSDictionary *wifiDic;

    NSLog(@"current :%@", ESPTools.getCurrentWiFiSsid);
    wifiDic = @{
        @"ssid":ESPTools.getCurrentWiFiSsid,
        @"bssid":ESPTools.getCurrentBSSID,
        @"state":@"Connected"
    };
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:wifiDic];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  
}

@end
