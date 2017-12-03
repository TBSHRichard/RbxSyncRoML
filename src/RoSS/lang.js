(function() {
  const nodelua = require('node-lua');

  const NUMBER_OF_PARSE_ARGS = 1;
  const NUMBER_OF_PARSE_RETURN_VALUES = 1;
  const NUMBER_OF_COMPILE_ARGS = 2;
  const NUMBER_OF_COMPILE_RETURN_VALUES = 1;

  var extractRomlName;

  module.exports = {
    info: {
      extension: '.ross',
      syntax: 'ross',
      sendToRobloxStudio: true,
      originalSourceValueName: 'RoSS',
      unallowedRobloxClasses: [ 'Script', 'LocalScript' ],
      defaultSource: 'Part\n  Name: "Hello, world!"',
      initializationShortcuts: [
        {
          type: 'extension',
          value: '.roml'
        }
      ],
      luaIncludes: [
        {
          file: 'roml.lua',
          name: 'roml',
          version: '0.1.0',
          destination: 'ReplicatedStorage.com.blacksheepherd'
        }
      ]
    },
    transpile: function(file, fileSource, addCommand, guid) {
      setImmediate(function() {
        try {
          var lua = new nodelua.LuaState();

          var cpath = __dirname.replace(/\\/g, '/');
          lua.DoString(`package.cpath = package.cpath .. ';${cpath}/lpeg/?.dll'`);
          lua.DoString(`package.path = package.path .. ';${cpath}/ROBLOX-Markup-Language/lib/?.lua'`);

          lua.DoFile(__dirname + '/ROBLOX-Markup-Language/lib/com/blacksheepherd/ross/RossParser.lua');
          var parser = lua.GetTop();

          lua.DoFile(__dirname + '/ROBLOX-Markup-Language/lib/com/blacksheepherd/ross/RossCompiler.lua');
          var compiler = lua.GetTop();

          lua.GetField(compiler, 'Compile');
          lua.Push(extractRomlName(file));

          lua.GetField(parser, 'Parse');
          lua.Push(fileSource);

          lua.Call(NUMBER_OF_PARSE_ARGS, NUMBER_OF_PARSE_RETURN_VALUES);
          lua.Call(NUMBER_OF_COMPILE_ARGS, NUMBER_OF_COMPILE_RETURN_VALUES);

          var luaOut = lua.ToValue(lua.GetTop());
          lua.Pop();

          lua.Close();

          addCommand('update', {
            guid: guid,
            source: luaOut,
            originalSource: fileSource
          });
        }
        catch (err) {
          addCommand('output', {
            text: err
          });
        }
      });
    }
  };

  extractRomlName = function(file) {
    var lastSlashIndex = file.lastIndexOf('\\') > -1 ? file.lastIndexOf('\\') : file.lastIndexOf('/');
    var filename = file.substring(lastSlashIndex + 1);
    var extensionIndex = filename.indexOf('.module.ross');
    return filename.substring(0, extensionIndex);
  }
}).call();
