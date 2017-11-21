(function() {
  module.exports = {
    info: {
      extension: '.roml',
      syntax: 'roml',
      sendToRobloxStudio: true,
      originalSourceValueName: 'RoML',
      initializationShortcuts: [
        {
          type: 'extension',
          value: '.roml'
        }
      ],
      luaIncludes: [
        {
          file: 'roml.lua',
          version: '0.1.0',
          destination: 'ReplicatedStorage.com.blacksheepherd'
        }
      ]
    },
    transpile: function(file, fileSource, addCommand, guid) {
      console.log('Transpiling RoML!');
    }
  };
}).call();
