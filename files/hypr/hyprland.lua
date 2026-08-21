hl.monitor({ output = "DP-1", mode = "2560x1440@60", position = "0x0", scale = 1 })
hl.monitor({ output = "LVDS-1", disabled = true })
hl.monitor({ output = "LVDS-2", disabled = true })

for i = 1, 5 do
    hl.workspace_rule({
        workspace = i,
        monitor = "DP-1",
        default = true,
    })
end

hl.env("XCURSOR_SIZE", 24)
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.config({
    general = {
        border_size = 2,
        gaps_in = 2,
        gaps_out = 4,
        col = {
            inactive_border = "rgba(127, 127, 127, 0.5)",
            active_border = "rgba(255, 255, 255, 1.0)",
        },
        layout = "dwindle",
        allow_tearing = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    cursor = {
        enable_hyprcursor = false,
    },
    dwindle = {
        preserve_split = true,
    },
    decoration = {
        rounding = 4,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            xray = false,
            popups = true,
        },
        shadow = {
            enabled = false,
        },
    },
    group = {
        col = {
            border_inactive = "rgba(127, 127, 127, 0.5)",
            border_active = "rgba(255, 255, 255, 1.0)",
            border_locked_inactive = "rgba(127, 127, 127, 0.5)",
            border_locked_active = "rgba(255, 255, 255, 1.0)",
        },
        groupbar = {
            render_titles = false,
            indicator_height = 2,
            keep_upper_gap = false,
            col = {
                inactive = "rgba(127, 127, 127, 0.5)",
                active = "rgba(255, 255, 255, 1.0)",
                locked_inactive = "rgba(127, 127, 127, 0.5)",
                locked_active = "rgba(255, 255, 255, 1.0)",
            },
        },
    },
    animations = {
        enabled = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 1,
        middle_click_paste = false,
        disable_autoreload = true,
    },
    input = {
        kb_layout = "custom, us",
        kb_variant = "colemak_wide",
        kb_options = "caps:escape, grp:sclk_toggle",
        resolve_binds_by_sym = true,
        numlock_by_default = true,
        follow_mouse = 1,
        sensitivity = -0.2,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.25,
            drag_lock = false,
        },
    },
})

hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "monitorAdded", enabled = false })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "default", style = "slidevert" })

hl.bind("SUPER + X", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exec_cmd([[op=$(printf "poweroff\nreboot\nlock\nexit" | tofi --prompt-text "session: ") && case $op in exit) hyprctl dispatch "hl.dsp.exit()";; lock) loginctl lock-session;; *) systemctl $op;; esac]]))
hl.bind("SUPER + Q", hl.dsp.exec_cmd("foot"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + F", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + Tab", hl.dsp.exec_cmd("tofi-drun"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("foot -T btm btm"))

hl.bind("SUPER + W", hl.dsp.window.float())
hl.bind("SUPER + D", hl.dsp.layout("togglesplit"))

hl.bind("SUPER + V", hl.dsp.exec_cmd([[cliphist list | expand -t 6 | tofi --prompt-text "clip: " | awk '{printf $1;}' | cliphist decode | wl-copy]]))

hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("pidof hyprshot || hyprshot -m region -o ~/Pictures/Screenshots"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("pidof hyprpicker || (hyprpicker 2>/dev/null| tr [:upper:] [:lower:]| wl-copy -n)"))

local VOLUME_NOTIF = [[dunstify -t 1000 -r 22517 -- "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -e 's/\.//' -e 's/ \(0\|00\)/ /')%"]]
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+;" .. VOLUME_NOTIF), { repeating = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+;" .. VOLUME_NOTIF), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-;" .. VOLUME_NOTIF), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;" .. VOLUME_NOTIF), { repeating = true })

local BRIGHTNESS_NOTIF = [[dunstify -t 1000 -r 22518 -- "Brightness: $(brightnessctl | grep -o '[0-9]*%')"]]
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[brightnessctl set $(expr "$(brightnessctl | grep -oP '[0-9]+(?=%)')" + 5)%;]] .. BRIGHTNESS_NOTIF), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[brightnessctl set $(expr "$(brightnessctl | grep -oP '[0-9]+(?=%)')" - 5)%;]] .. BRIGHTNESS_NOTIF), { repeating = true })

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + N", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + I", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ group_aware = true, direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ group_aware = true, direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ group_aware = true, direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ group_aware = true, direction = "right" }))
hl.bind("SUPER + SHIFT + N", hl.dsp.window.move({ group_aware = true, direction = "down" }))
hl.bind("SUPER + SHIFT + E", hl.dsp.window.move({ group_aware = true, direction = "up" }))
hl.bind("SUPER + SHIFT + I", hl.dsp.window.move({ group_aware = true, direction = "right" }))

hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ relative = true, x = -32, y = 0 }), { repeating = true })
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ relative = true, x = 0, y = 32 }), { repeating = true })
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ relative = true, x = 0, y = -32 }), { repeating = true })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ relative = true, x = 32, y = 0 }), { repeating = true })
hl.bind("SUPER + CTRL + N", hl.dsp.window.resize({ relative = true, x = 0, y = 32 }), { repeating = true })
hl.bind("SUPER + CTRL + E", hl.dsp.window.resize({ relative = true, x = 0, y = -32 }), { repeating = true })
hl.bind("SUPER + CTRL + I", hl.dsp.window.resize({ relative = true, x = 32, y = 0 }), { repeating = true })

for i = 1, 10 do
    local j = i % 10
    hl.bind("SUPER + " .. j, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. j, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprctl clients| grep -P \\s+class: vesktop$ || vesktop --disable-gpu"))
hl.bind("SUPER + C", hl.dsp.workspace.toggle_special("chat"))
hl.bind("SUPER + SHIFT + C", hl.dsp.window.move({ workspace = "special:chat" }))
hl.bind("SUPER + Grave", hl.dsp.window.fullscreen())

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + T", hl.dsp.group.toggle())
hl.bind("SUPER + R", hl.dsp.group.prev())
hl.bind("SUPER + S", hl.dsp.group.next())

hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "selection" },
    no_anim = true,
})

hl.window_rule({
    name = "automaximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "discord",
    match = { class = "(vesktop)" },
    workspace = "special:chat",
})

hl.window_rule({
    name = "xnoblur",
    match = { xwayland = 1 },
    no_blur = true,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("brightnessctl set 50%")
    hl.exec_cmd("swaybg -m fill -i /home/slither/Pictures/NASA_APOD_20210314.png")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("kbuildsycoca6")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("dunst")
    hl.exec_cmd("waybar")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
end)
