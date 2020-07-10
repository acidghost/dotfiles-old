function exec (cmd)
    local handle = io.popen(cmd)
    local result = handle:read('*a')
    return result
end

function icon (char)
    return '${font Hack Nerd Font Mono:style=Regular:size=10}' .. char .. '$font'
end

local screenSize = tonumber(exec("xrandr --query | awk '/primary/{print $4}' | cut -dx -f1"))
local nproc = tonumber(exec('nproc'))

conky.config = {
    background = true,
    out_to_x = true,
    -- font = 'Noto Mono:size=12',
    font = 'Hack Nerd Font Mono:style=Regular:size=10',
    update_interval = 1,
    alignment = 'bottom_middle',
    gap_x = 0,
    gap_y = 0,
    minimum_height = 16,
    maximum_width = screenSize,
    minimum_width = screenSize,
    draw_borders = false,
    draw_graph_borders = false,
    draw_outlines = false,
    draw_shades = true,
    own_window_class = 'Conky',
    -- own_window_hints = 'undecorated,above,skip_pager,sticky',
    own_window_transparent = false,
    own_window_type = 'panel',
    own_window = true,
    double_buffer = true,
    xinerama_head = 0,
    use_spacer = 'none',
    use_xft = true
}

local cpus = '${color pink}' .. icon('') .. ' ${cpu} ${cpugraph cpu0 10,60 -l} ${color green3}'
for i = 1, nproc do
    cpus = cpus .. '${cpu cpu' .. i .. '} '
end

conky.text = [[
${color cyan}]] .. icon('') .. [[ \
${exec amixer get Master | egrep -o "[0-9]+%" | head -1 | egrep -o "[0-9]*"}${offset 16}\
${color yellow}]] .. icon('') .. [[ ${battery_short BAT1}${offset 16}\
${color white}]] .. icon('ﯦ') .. [[ ${exec lux -G | sed 's/%//'}${offset 16}\
]] .. cpus ..[[${offset 16}\
${color aa00aa}]] .. icon('') .. [[ ${memperc} ${memgraph 10,60 -t}${offset 16}\
${color 009393}]] .. icon('ﯲ') .. [[ ${downspeed enp7s0} ${downspeedgraph enp7s0 10,60 yellow ffffff}${offset 16}\
]] .. icon('ﯴ') .. [[ ${upspeed enp7s0} ${upspeedgraph enp7s0 10,60 yellow white}\
${alignr}${color ffff00}${time %T}   ${color 00ffff}${time %a %d-%b-%y}\
]]

