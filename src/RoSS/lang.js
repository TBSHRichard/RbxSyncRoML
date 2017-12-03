(function() {
  const Language = require('./Language.js');

  var ross = new Language();
  ross.syntax = 'ross';
  ross.name = 'RoSS';
  ross.defaultSource = 'Part\n  Name: "Hello, RoSS!"';
  ross.parserName = 'RossParser';
  ross.compilerName = 'RossCompiler';

  module.exports = {
    info: ross.createInfo(),
    transpile: function(file, fileSource, addCommand, guid) {
      ross.transpile(file, fileSource, addCommand, guid);
    }
  };
}).call();
