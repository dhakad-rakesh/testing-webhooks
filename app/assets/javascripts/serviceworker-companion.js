if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/firebase-messaging-sw.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
