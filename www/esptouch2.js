
var exec = require('cordova/exec');

module.exports = {
  start: function (apSsid, apBssid, apPassword, customData, aesKey, successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "start", [apSsid, apBssid, apPassword, customData, aesKey]);
  },
  stop: function (successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "stop", []);
  }
}


