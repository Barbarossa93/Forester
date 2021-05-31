#!/usr/bin/env python3
import everforest.draw

# Load existing settings made via :set
config.load_autoconfig()

# everforest.draw.konda(c, {"spacing": {"vertical": 5, "horizontal": 8}})
everforest.draw.konda(c)

c.fonts.hints = "7.5pt monospace"
c.fonts.keyhint = "7.5pt monospace"
c.fonts.prompts = "7.5pt monospace"
c.fonts.downloads = "7.5pt monospace"
c.fonts.statusbar = "7.5pt monospace"
c.fonts.contextmenu = "7.5pt monospace"
c.fonts.messages.info = "7.5pt monospace"
c.fonts.debug_console = "7.5pt monospace"
c.fonts.completion.entry = "7.5pt monospace"
c.fonts.completion.category = "7.5pt monospace"
c.url.start_pages = "~/.config/qutebrowser/startpage/index.html"
c.url.default_page = "~/.config/qutebrowser/startpage/index.html"
c.editor.command = ["/usr/bin/termite", "-e", "/usr/bin/emacs -nw {}"]

c.colors.webpage.darkmode.enabled = False

# config.set("colors.webpage.darkmode.enabled", True)
# Toggle darkmode css
config.bind(
    ",t",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/everforest/everforest-dark/everforest-dark-all-sites.css ""',
)

# Qute-pass keubindings
config.bind(
    ",pp",
    "spawn --userscript qute-pass -d qute-pass-fzf.sh",
)

config.bind(
    ",pu",
    "spawn --userscript qute-pass --username-only -d qute-pass-fzf.sh",
)

config.bind(
    ",pP",
    "spawn --userscript qute-pass --password-only -d qute-pass-fzf.sh",
)

# Open download
config.bind(
    ",d",
    "spawn termite --name downloads -e open_download",
)

# Cycle inputs
config.bind(
    "gi",
    "jseval -q -f ~/.config/qutebrowser/cycle-inputs.js",
)
