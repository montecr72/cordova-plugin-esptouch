var exec = require('cordova/exec');

module.exports = {
  start: function (apSsid, apPassword, customData, successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "start", [apSsid,apBssid, apPassword, customData,aesKey]);
  },
  stop: function (successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "stop", []);
  }
}
