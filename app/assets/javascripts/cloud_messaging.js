  // [START get_messaging_object]
  // Retrieve Firebase Messaging object.
  const messaging = firebase.messaging();
  // [END get_messaging_object]
  // [START set_public_vapid_key]
  // Add the public key generated from the console here.
  messaging.usePublicVapidKey(fcmPublicKey);
  // [END set_public_vapid_key]

  // IDs of divs that display Instance ID token UI or request permission UI.
  const permissionDivId = 'permission_div';

  const url = '/admin/device_ids'

  // [START refresh_token]
  // Callback fired if Instance ID token is updated.

  messaging.onTokenRefresh(() => {
    messaging.getToken().then((refreshedToken) => {
      console.log('Token refreshed.');
      // Indicate that the new Instance ID token has not yet been sent to the
      // app server.
      setTokenSentToServer(false);
      // Send Instance ID token to app server.
      sendTokenToServer(refreshedToken);
    }).catch((err) => {
      console.log('Unable to retrieve refreshed token ', err);
    });
  });
  // [END refresh_token]

  // [START receive_message]
  // Handle incoming messages. Called when:
  // - a message is received while the app has focus
  // - the user clicks on an app notification created by a service worker
  //   `messaging.setBackgroundMessageHandler` handler.
  messaging.onMessage((payload) => {
    console.log('Message received. ', payload);
    // toastr.info(payload.notification.body, payload.notification.title);
    alertify.set('notifier','position', 'bottom-right');
    // notification = document.createElement('div'); 
    // notification.innerHTML = "<b>"+payload.notification.title + "</b><hr>" + payload.notification.body;
    alertify.notify(payload.notification.body, 'custom', 5, function(isClicked) {
      if(isClicked) {
        window.location = payload.notification.click_action;
      } 
    });
  });
  // [END receive_message]

  function resetUI() {
    // [START get_token]
    // Get Instance ID token. Initially this makes a network call, once retrieved
    // subsequent calls to getToken will return from cache.
    messaging.getToken().then((currentToken) => {
      if (currentToken) {
        sendTokenToServer(currentToken);
        updateUIForPushEnabled(currentToken);
      } else {
        // Show permission request.
        console.log('No Instance ID token available. Request permission to generate one.');
        // Show permission UI.
        requestPermission();
        // updateUIForPushPermissionRequired();
        // TODO: Add option on admin panel to manually turn on notifications
        setTokenSentToServer(false);
      }
    }).catch((err) => {
      console.log('An error occurred while retrieving token. ', err);
      setTokenSentToServer(false);
    });
    // [END get_token]
  }

  // Send the Instance ID token your application server, so that it can:
  // - send messages back to this app
  // - subscribe/unsubscribe the token from topics
  function sendTokenToServer(currentToken) {
    if (!isTokenSentToServer()) {
      console.log('Sending token to server...');
      sendRequestToServer(currentToken);
    } else {
      console.log('Token already sent to server so won\'t send it again ' +
          'unless it changes');
    }
  }

  function isTokenSentToServer() {
    return window.localStorage.getItem('sentToServer') === '1';
  }

  function setTokenSentToServer(sent) {
    window.localStorage.setItem('sentToServer', sent ? '1' : '0');
  }

  function showHideDiv(divId, show) {
    const div = document.querySelector('#' + divId);
    if (show) {
      div.style = 'display: visible';
    } else {
      div.style = 'display: none';
    }
  }

  function requestPermission() {
    console.log('Requesting permission...');
    // [START request_permission]
    Notification.requestPermission().then((permission) => {
      if (permission === 'granted') {
        console.log('Notification permission granted.');
        // TODO(developer): Retrieve an Instance ID token for use with FCM.
      } else {
        console.log('Unable to get permission to notify.');
      }
    });
    // [END request_permission]
  }

  function deleteToken() {
    // Delete Instance ID token.
    // [START delete_token]
    messaging.getToken().then((currentToken) => {
      messaging.deleteToken(currentToken).then(() => {
        console.log('Token deleted.');
        setTokenSentToServer(false);
      }).catch((err) => {
        console.log('Unable to delete token. ', err);
      });
      // [END delete_token]
    }).catch((err) => {
      console.log('Error retrieving Instance ID token. ', err);
    });

  }

  function updateUIForPushEnabled(currentToken) {
    //showHideDiv(permissionDivId, false);
  }

  function updateUIForPushPermissionRequired() {
    // showHideDiv(permissionDivId, true);
  }

  function sendRequestToServer(token) {
    // Send the current token to the server.
    $.ajax(url, {
      type: "post",
      dataType:'json',
      data: { device_id: token },
      success: function(result) {
        console.log('Token sent to server');
        setTokenSentToServer(true);
      },
      error: function(error) {
        console.log('Token cannot be sent to server')
      }
    });
  }

  resetUI();