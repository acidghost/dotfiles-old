conky.config = {
    background = true,
    out_to_console = true,
    out_to_x = true,
    -- Update interval in seconds
    update_interval = 1,
    double_buffer = true,
    own_window = true,
    own_window_type = 'override',
    own_window_transparent = true
}

conky.text = [[
^fg(\#FFFFFF)${time %d/%m/%Y} ^fg(\#ebac54)${time %T} \
^fg(\#FFFFFF)CPU: ${cpu}% ^fg(\#FFFFFF)Mem: ${memperc}% \
${if_existing /proc/net/route enp7s0} ^fg(\#00aa4a)D: ${downspeed enp7s0} ^fg(\#ff3333)U: ${upspeed enp7s0} ${endif} \
^fg(\#00ffff)Vol: ${exec amixer get Master | egrep -o "[0-9]+%" | head -1 | egrep -o "[0-9]*"}% \
^fg(\#ddd)CPU: ${cpugraph 0 10,120 555555 AAAAAA -l}
]]

