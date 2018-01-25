var page = require('webpage').create();
page.viewportSize = { width:1280, height:768 };
page.open('https://google.com', function(status) {
  console.log("Status: " + status);
  page.render('/data/example.png');
  phantom.exit();
});
