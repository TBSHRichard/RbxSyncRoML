(function() {
  const nodelua = require('node-lua');

  const NUMBER_OF_TRANSPILE_ARGS = 2;
  const NUMBER_OF_TRANSPILE_RETURN_VALUES = 1;

  module.exports = class {
    constructor() {
      this.syntax = '';
      this.name = '';
      this.defaultSource = '';
      this.parserName = '';
      this.compilerName = '';
      this.transpilerName = '';
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
            file: 'romllib.lua',
            name: 'romllib',
            version: '0.1.0',
            destination: 'ReplicatedStorage.com.blacksheepherd'
          }
        ]
      };
    }

    transpile(file, fileSource, addCommand, guid) {
      try {
        var lua = new nodelua.LuaState();

        var cwd = __dirname.replace(/\\/g, '/');
        lua.DoString(`package.cpath = package.cpath .. ';${cwd}/lpeg/?.dll'`);

        lua.DoFile(`${cwd}/ROBLOX-Markup-Language/build/${this.transpilerName}.lua`);
        var transpiler = lua.GetTop();

        lua.GetField(transpiler, 'Transpile');
        lua.Push(this.extractModuleName(file));
        lua.Push(fileSource);

        lua.Call(NUMBER_OF_TRANSPILE_ARGS, NUMBER_OF_TRANSPILE_RETURN_VALUES);

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
