var exec = require('cordova/exec');

module.exports = {
  start: function (apSsid, apBssid, apPassword, deviceCountData, broadcastData, successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch", "start", [apSsid, apBssid, apPassword, deviceCountData, broadcastData]);
  },
  stop: function (successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch", "stop", []);
  },
  v2start: function (apSsid, apBssid, apPassword, deviceCountData, broadcastData, successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch", "start", [apSsid, apBssid, apPassword, deviceCountData, broadcastData]);
  },
  v2stop: function (successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch", "stop", []);
  }
}