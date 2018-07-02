const linear16 = require('linear16');
linear16('./new-ENCODED.mp3', './output.wav')
   .then(outPath => console.log(outPath));
