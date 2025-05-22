#import "esptouch2.h"
#import "ESP_ByteUtil.h"

NSString *callback_ID2;

@implementation esptouch2

- (void)onProvisoningScanResult:(ESPProvisioningResult *)result {
    NSLog(@"onProvisonScanResult: address=%@, bssid=%@", result.address, result.bssid);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSDictionary *device =@{@"bssid":result.bssid,@"ip":result.address};
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: device];
        [pluginResult setKeepCallbackAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callback_ID2];
        // [self.resultArray addObject:result];
        // [self.resultView reloadData];
        // if ([self.request.deviceCount intValue] > 0) {
        //     // check result array size == expect size
        //     if (self.resultArray.count >= [self.request.deviceCount intValue]) {
        //         [self stopProvisioning:nil];
        //     }
        // }
    }];
}

- (void) start:(CDVInvokedUrlCommand *)command{
    [self.commandDelegate runInBackground:^{
        callback_ID2 = command.callbackId;
        NSString *apSsid = (NSString *)[command.arguments objectAtIndex:0];
        NSString *apBssid = (NSString *)[command.arguments objectAtIndex:1];
        NSString *apPassword = (NSString *)[command.arguments objectAtIndex:2];
        NSString *customData = (NSString *)[command.arguments objectAtIndex:3];
        NSString *aesKey = (NSString *)[command.arguments objectAtIndex:4];
        self.provisioner = [ESPProvisioner share];
        ESPProvisioningRequest *request = [[ESPProvisioningRequest alloc] init];
        request.ssid = [ESP_ByteUtil getBytesByNSString:apSsid];
        request.bssid = [ESP_ByteUtil getBytesByNSString:apBssid];
        request.password = [ESP_ByteUtil getBytesByNSString:apPassword];
        request.reservedData = [ESP_ByteUtil getBytesByNSString:customData];
        request.aesKey = aesKey;
                
        [self.provisioner startProvisioning:request withDelegate:self];
    }];
}

- (void) stop:(CDVInvokedUrlCommand *)command{
    [self.provisioner stopProvisioning];
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"cancel success"];
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
