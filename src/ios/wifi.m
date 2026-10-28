#import "wifi.h"
#import <NetworkExtension/NetworkExtension.h>
#import <CoreLocation/CoreLocation.h>
#import <NetworkExtension/NetworkExtension.h>

@implementation wifi

- (void) getConnectedInfo:(CDVInvokedUrlCommand *)command{
    /*
    CLLocationManager *manager;
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
    
    NSDictionary *wifiDic;

    if(ESPTools.getCurrentWiFiSsid){
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
    */

    NEHotspotNetwork fetchCurrentWithCompletionHandler:^(NEHotspotNetwork * _Nullable currentNetwork) {
    NSDictionary *wifiDic;
    
    if (currentNetwork != nil) {
        NSString *ssid = currentNetwork.SSID;
        NSString *bssid = currentNetwork.BSSID;
        
        wifiDic = @{
            @"ssid": ssid ? ssid : @"",
            @"bssid": bssid ? bssid : @"",
            @"state": @"Connected"
        };
    } else {
        // Если вернулся nil, значит всё ещё не хватает прав/Capabilities в Xcode
        wifiDic = @{
            @"state": @"bad request"
        };
    }
    
    // ВАЖНО: Так как метод асинхронный, отправку ответа в Cordova (CDVPluginResult)
    // нужно перенести СЮДА — внутрь этого блока completionHandler!
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:wifiDic];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}];
  
}

@end
