fx_version "cerulean"

game "gta5"
author "laot"
lua54 "yes"

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
    "server/version.lua"
}

exports {
    "GetObject",
}