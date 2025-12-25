module.exports = {
    // ... standard settings ...
    uiPort: process.env.PORT || 1880,
    uiHost: "127.0.0.1", // Security: Force Nginx Proxy (SSO/VPN handles auth)
    mqttReconnectTime: 15000,
    serialReconnectTime: 15000,
    debugMaxLength: 1000,

    // Smart Bar Customization
    editorTheme: {
        page: {
            title: "Smart Bar Brain",
            favicon: "/absolute/path/to/favicon.ico",
            css: "/var/www/nodered/custom_style.css"
        },
        header: {
            title: "Smart Bar AI-Brain",
            image: null,
            url: "https://bar.lan"
        },
        menu: {
            "menu-item-help": {
                label: "Smart Bar Docs",
                url: "https://wiki.bar.lan"
            }
        },
        projects: {
            enabled: false
        },
        tours: false,
    },

    // Dashboard 2.0 Theme Config (if applicable in settings.js for newer versions)
    // Otherwise managed via ui_base node.

    functionGlobalContext: {
        os: require('os'),
    },

    logging: {
        console: {
            level: "info",
            metrics: false,
            audit: false
        }
    },

    exportGlobalContextKeys: false,
}
