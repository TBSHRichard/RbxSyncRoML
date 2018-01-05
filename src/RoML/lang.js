(function() {
  const Language = require('./Language.js');

  var roml = new Language();
  roml.syntax = 'roml';
  roml.name = 'RoML';
  roml.defaultSource = '%Part{Name: "Hello, RoML!"}';
  roml.transpilerName = 'romlc';

  module.exports = {
    info: roml.createInfo(),
    transpile: function(file, fileSource, addCommand, guid) {
      roml.transpile(file, fileSource, addCommand, guid);
    }
  };
}).call();
