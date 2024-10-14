#import "wifi.h"
#import <NetworkExtension/NetworkExtension.h>
#import <CoreLocation/CoreLocation.h>

@implementation wifi

- (void) getConnectedInfo:(CDVInvokedUrlCommand *)command{
    CLLocationManager *manager;
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
    NEHotspotConfigurationManager* hs_manager = [NEHotspotConfigurationManager sharedManager];
    
    [NEHotspotNetwork fetchCurrentWithCompletionHandler:^(NEHotspotNetwork * _Nullable currentNetwork) {
        NSDictionary *wifiDic;
        if(currentNetwork.SSID != nil){
            NSLog(@"current :%@", ESPTools.getCurrentWiFiSsid);
            wifiDic = @{
                @"ssid":currentNetwork.SSID,
                @"bssid":currentNetwork.BSSID,
                @"state":@"Connected"
            };
        }else if(ESPTools.getCurrentWiFiSsid != nil){
            NSLog(@"current :%@", ESPTools.getCurrentWiFiSsid);
            wifiDic = @{
                @"ssid":ESPTools.getCurrentWiFiSsid,
                @"bssid":ESPTools.getCurrentBSSID,
                @"state":@"Connected"
            };
        }else{
            wifiDic = @{
                @"state":@"bad request"
            };
        }
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:wifiDic];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];

  
}

@end
