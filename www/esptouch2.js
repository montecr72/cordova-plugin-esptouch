var exec = require('cordova/exec');

module.exports = {
  start: function (apSsid, apPassword, customData,aesKey, successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "start", [apSsid, apPassword, customData,aesKey]);
  },
  stop: function (successCallback, failCallback) {
    exec(successCallback, failCallback, "esptouch2", "stop", []);
  }
}
