___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Bigin SDK",
  "categories": ["AFFILIATE_MARKETING", "MARKETING"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "\bBiginsight",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABgCAMAAACJzMQuAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAzUExURUdwTC1l/yFO/x9K/yhh/ypj/zRz/x9M/yli/ylj/x5L/yhi/yZq/yJb/yBS/x1H/xk6/wmdH8IAAAALdFJOUwAsxdPnWAl08r7u+pjeFwAAAgJJREFUWMPtmNuugyAQRa1Ci0XA///ag4hcVFrmkvPUSfrUZGUJgjN7mJdlmXV/CTncl+csGkLSsgnyfzKQlqCkR0Ul7UYMpGhk9EQk7UbGF5EUjTbUJCikbGSMoJAKI2sppMLIWvvGk7KRDaQJS6qNCKSTkbPvEUc6GzlncaQNlHbNCzlfKFI8ISY+WgChSLVRVMKQstGxRs6t6wonZaPt0aKQQ5CCkdG1EcYpGpn0HmFI6pnWSF+MIKS5MjJ5+3fQ2nvVzc9qjZKQx4BIgbODlmO1XUL1k3bOIPJhK5USSXRyhsdLvj6W6ON8r4fg4XwmQTifSDBOmwTltEhwzj0Jw7kj4ThXEpZzJuE5NYnCKUk0TiZROQeJzvGkrWVn4AySCcT1aFyLzbX9XC8k1xHhOrRc1wjXxcZ11XJd/lyfI64PZO8n+/H6UqqziVDVwHZta1RvW3PqIUMzumIarVNXG42wrV/u2Cqj3rb2aEavRsj2uLFG8Ib96LNtZYQYIcpZZDfySrihJvTZ1XQEeS5ZpjWn6Qg5+BWzCHioVbKesnUUog3H9XT0xviURgcHGUUURuBIQ8lrNpJCFnRcUxtBQi0l7/KjfY0mWhCVdo3gUxnRYr9sBOEo2cohtRnpgWZAjTSfZESPjxdwoK1kO8/mCMZnpdT2661mVP+rX/3qX+oPORys52hm83IAAAAASUVORK5CYII\u003d"
  },
  "description": "Implement User identifying event and E-commerce event and Custom Event.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const copyFromDataLayer = require('copyFromDataLayer');
const callInWindow = require('callInWindow');

const tackingDataLayer = copyFromDataLayer('bigin');

const getEventModel = function (eventName) {
  const eventNamePrefix = 'bg:';
  const eventType = tackingDataLayer[eventName].eventType ? tackingDataLayer[eventName].eventType.toLowerCase() : undefined;
  const eventData = tackingDataLayer[eventName].segment;

  switch (eventType) {
    case 'track':
      return {
        eventType: 'bigin.track',
        eventName: eventName,
        segment: eventData
      };
    case 'user':
      return {
        eventType: "bigin.user",
        eventName: eventName.search(eventNamePrefix) >= 0 ? eventName.replace(eventNamePrefix, '') : eventName,
        segment: eventData
      };
    case 'ecommerce':
      return {
        eventType: "bigin.event",
        eventName: eventName.search(eventNamePrefix) >= 0 ? eventName: eventNamePrefix + eventName,
        segment: eventData
      };
    case 'custom':
      return {
        eventType: 'bigin.event',
        eventName: eventName,
        segment: eventData
      };
    default:
      return null;
  }
};

const executeEvent = function (eventName) {
  const eventModel = getEventModel(eventName);
  if(eventModel) {
    callInWindow(eventModel.eventType, eventModel.eventName, eventModel.segment);
  }
};

const eventKeys = Object.keys(tackingDataLayer);
if (eventKeys && eventKeys.length) {
  eventKeys.forEach(executeEvent);
  data.gtmOnSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.user"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.event"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.track"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "bigin"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []
setup: |-
  const createQueue = require('createQueue');
  const getTimeStamp = require('getTimestamp');
  const copyFromWindow = require('copyFromWindow');
  const setInWindow = require('setInWindow');
  const injectScript = require('injectScript');

  const projectId = data.projectId;
  const currencyCode = data.currencyCode;

  const biginQueue = createQueue('_b_g_e_b_f');
  const bigin = copyFromWindow('bigin') ? copyFromWindow('bigin') : {};

  bigin.user = function (commend, data) {
    biginQueue.push({type: 'user', commend: commend, data: data});
  };

  bigin.event = function (commend, data, timestamp) {
    biginQueue.push({
      type: 'event',
      commend: commend,
      data: data,
      timestamp: timestamp ? timestamp : getTimeStamp()
    });
  };

  bigin.track = function (commend, data) {
    biginQueue.push({
      type: 'track',
      commend: commend,
      data: data
    });
  };

  setInWindow('bigin', bigin, false);

  const onInjectBiginSuccess = function () {
    bigin && bigin.config({
      projectId: projectId,
      currencyCode: currencyCode
    });

    if (biginQueue && biginQueue.length > 0) {
      biginQueue.forEach(function(event) {
        event.type(event.commend, event.data, event.timestamp);
      });
    }

    data.gtmOnSuccess();
  };

  const onInjectBiginFailure = function () {
    data.gtmOnFailure();
  };

  injectScript('https://sdk.bigin.io/v1/bigin.sdk.js', onInjectBiginSuccess, onInjectBiginFailure);


___NOTES___

Created on 2022. 2. 17. 오후 4:36:00


