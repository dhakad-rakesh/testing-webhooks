importScripts('https://www.gstatic.com/firebasejs/7.18.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/7.18.0/firebase-messaging.js');

var config = {
    apiKey: "AIzaSyBg8filP9pbMMYC07XvPp0fA2A7WTL8PUQ",
    authDomain: "koorabet-75ef9.firebaseapp.com",
    databaseURL: "https://koorabet-75ef9.firebaseio.com",
    projectId: "koorabet-75ef9",
    storageBucket: "koorabet-75ef9.appspot.com",
    messagingSenderId: "87591408182",
    appId: "1:87591408182:web:64dbe4f61e873edfc0be97",
    measurementId: "G-TPWEE5RQ2G"
  }
// Initialize firebase
firebase.initializeApp(config);

const messaging = firebase.messaging();

// messaging.setBackgroundMessageHandler(function(payload) {
//     console.log('[firebase-messaging-sw.js] Received background message ', payload);
//     // Customize notification here
//     const notificationTitle = 'Background Message Title';
//     const notificationOptions = {
//       body: 'Background Message body.',
//       icon: '/firebase-logo.png'
//     };
//   
//     return self.registration.showNotification(notificationTitle,
//       notificationOptions);
//   });
  // [END background_handler]
;
