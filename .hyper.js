// See https://hyper.is#cfg for all currently supported options.
module.exports = {
  config: {
    updateChannel: 'stable',
    modifierKeys: {
      altIsMeta: true
    },

    fontSize: 14,
    fontFamily: 'Consolas, "Myrica M", "Lucida Console", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',

    cursorColor: 'rgba(248,28,229,0.8)',
    cursorAccentColor: '#000',
    cursorShape: 'BLOCK',
    cursorBlink: false,

    foregroundColor: '#fff',
    backgroundColor: '#000',
    selectionColor: 'rgba(248,28,229,0.3)',
    borderColor: '#1DC121',

    css: '',
    termCSS: '',

    showHamburgerMenu: '',
    showWindowControls: '',

    padding: '8px 4px',

    colors: {
      black: '#000000',
      red: '#C51E14',
      green: '#1DC121',
      yellow: '#C7C329',
      blue: '#0A2FC4',
      magenta: '#C839C5',
      cyan: '#20C5C6',
      white: '#C7C7C7',
      lightBlack: '#686868',
      lightRed: '#FD6F6B',
      lightGreen: '#67F86F',
      lightYellow: '#FFFA72',
      lightBlue: '#6A76FB',
      lightMagenta: '#FD7CFC',
      lightCyan: '#68FDFE',
      lightWhite: '#FFFFFF',
    },

    shell: 'C:\\Windows\\System32\\bash.exe',
    shellArgs: ['-c', 'zsh'],
    env: {},

    bell: false,
    copyOnSelect: false,
    defaultSSHApp: true,
  },

  plugins: [
    'hyper-material-theme',
    'hyper-search',
  ],

  localPlugins: [],

  keymaps: {
    "editor:movePreviousWord": "",
    "editor:moveNextWord": "",

    "tab:new": "ctrl+t",
    "tab:next":  "ctrl+right",
    "tab:prev": "ctrl+left",
    "pane:next": [
      "alt+right",
      "alt+up"
    ],
    "pane:prev": [
      "alt+left",
      "alt+down",
    ],
    "pane:splitVertical": "ctrl+d",
    "pane:splitHorizontal": "ctrl+e",
  },
};
