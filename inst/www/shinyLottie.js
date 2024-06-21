// Play Animation
Shiny.addCustomMessageHandler("lottie_js_play", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].play();
    });
  } else {
    window.lottieInstances[message.name].play();
  }
});

// Pause Animation
Shiny.addCustomMessageHandler("lottie_js_pause", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].pause();
    });
  } else {
    window.lottieInstances[message.name].pause();
  }
});

// Stop Animation
Shiny.addCustomMessageHandler("lottie_js_stop", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].stop();
    });
  } else {
    window.lottieInstances[message.name].stop();
  }
});

// Set Animation Speed
Shiny.addCustomMessageHandler("lottie_js_setSpeed", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].setSpeed(message.speed);
    });
  } else {
    window.lottieInstances[message.name].setSpeed(message.speed);
  }
});

// Set Direction
Shiny.addCustomMessageHandler("lottie_js_setDirection", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].setDirection(message.direction);
    });
  } else {
    window.lottieInstances[message.name].setDirection(message.direction);
  }
});

// Destroy
Shiny.addCustomMessageHandler("lottie_js_destroy", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].destroy();
    });
  } else {
    window.lottieInstances[message.name].destroy();
  }
});

// Set Subframe
Shiny.addCustomMessageHandler("lottie_js_setSubframe", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].setSubframe(message.flag);
    });
  } else {
    window.lottieInstances[message.name].setSubframe(message.flag);
  }
});


// Go To And Stop
Shiny.addCustomMessageHandler("lottie_js_goToAndStop", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].goToAndStop(message.value, message.isFrame);
    });
  } else {
    window.lottieInstances[message.name].goToAndStop(message.value, message.isFrame);
  }
});

// Go To And Play
Shiny.addCustomMessageHandler("lottie_js_goToAndPlay", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].goToAndPlay(message.value, message.isFrame);
    });
  } else {
    window.lottieInstances[message.name].goToAndPlay(message.value, message.isFrame);
  }
});

// Play Segments
Shiny.addCustomMessageHandler("lottie_js_playSegments", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].playSegments(message.segments, message.forceFlag);
    });
  } else {
    window.lottieInstances[message.name].playSegments(message.segments, message.forceFlag);
  }
});

// Set Loop
Shiny.addCustomMessageHandler("lottie_js_setLoop", function(message) {
  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      window.lottieInstances[key].setLoop(message.flag);
    });
  } else {
    window.lottieInstances[message.name].setLoop(message.flag);
  }
});

// Get Property
Shiny.addCustomMessageHandler("lottie_js_getProperty", function(message) {

  if (message.name === "all") {
    const output = {};
    Object.keys(window.lottieInstances).forEach(function(key) {
      output[key] = window.lottieInstances[key][message.property];
    });
    Shiny.setInputValue(message.property, output, {priority: "event"});
  } else {
    propertyValue = window.lottieInstances[message.name][message.property];
    Shiny.setInputValue(message.property, propertyValue, {priority: "event"});
  }

});

// Call Method
Shiny.addCustomMessageHandler("lottie_js_callMethod", function(message) {

  if (message.name === "all") {
    Object.keys(window.lottieInstances).forEach(function(key) {
      if (message.argument === "" || message.argument === undefined) {
        window.lottieInstances[key][message.method]();
      } else {
        window.lottieInstances[key][message.method](message.argument);
      }
    });
  } else {
    if (message.argument === "" || message.argument === undefined) {
      window.lottieInstances[message.name][message.method]();
    } else {
      window.lottieInstances[message.name][message.method](message.argument);
    }
  }

});


// Run JS
// Used for:
  // addEventListener
  // removeEventListener
Shiny.addCustomMessageHandler("lottie_js_runJS", function(message) {

  eval(message);

});
