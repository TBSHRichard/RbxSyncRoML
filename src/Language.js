(function() {
  const nodelua = require('node-lua');

  const NUMBER_OF_PARSE_ARGS = 1;
  const NUMBER_OF_PARSE_RETURN_VALUES = 1;
  const NUMBER_OF_COMPILE_ARGS = 2;
  const NUMBER_OF_COMPILE_RETURN_VALUES = 1;

  module.exports = class {
    constructor() {
      this.syntax = '';
      this.name = '';
      this.defaultSource = '';
      this.parserName = '';
      this.compilerName = '';
    }

    createInfo() {
      return {
        extension: `.${this.syntax}`,
        syntax: this.syntax,
        sendToRobloxStudio: true,
        originalSourceValueName: this.name,
        unallowedRobloxClasses: [ 'Script', 'LocalScript' ],
        defaultSource: this.defaultSource,
        initializationShortcuts: [
          {
            type: 'extension',
            value: `.${this.syntax}`
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
      };
    }

    transpile(file, fileSource, addCommand, guid) {
      try {
        var lua = new nodelua.LuaState();

        var cd = __dirname.replace(/\\/g, '/');
        lua.DoString(`package.cpath = package.cpath .. ';${cd}/lpeg/?.dll'`);
        lua.DoString(`package.path = package.path .. ';${cd}/ROBLOX-Markup-Language/lib/?.lua'`);

        lua.DoFile(`${cd}/ROBLOX-Markup-Language/lib/com/blacksheepherd/${this.syntax}/${this.parserName}.lua`);
        var parser = lua.GetTop();

        lua.DoFile(`${cd}/ROBLOX-Markup-Language/lib/com/blacksheepherd/${this.syntax}/${this.compilerName}.lua`);
        var compiler = lua.GetTop();

        lua.GetField(compiler, 'Compile');
        lua.Push(this.extractModuleName(file));

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
    }

    extractModuleName(file) {
      var lastSlashIndex = file.lastIndexOf('\\') > -1 ? file.lastIndexOf('\\') : file.lastIndexOf('/');
      var filename = file.substring(lastSlashIndex + 1);
      var extensionIndex = filename.indexOf(`.module.${this.syntax}`);
      return filename.substring(0, extensionIndex);
    }
  }
}).call();
