fx_version "bodacious"

game "gta5"
author "laot"

ui_page "nui/index.html"
files {
    "nui/index.html",
    "nui/script.js",
    "nui/style.css",
}

client_scripts {
    "config.lua",
    "locale.lua",
    "locales/tr.lua",
    "locales/en.lua",
    "client/main.lua"
}

server_scripts {
    "config.lua",
    "locale.lua",
    "locales/tr.lua",
    "locales/en.lua",
    "server/main.lua",
}

exports {
    "GetObject",
}