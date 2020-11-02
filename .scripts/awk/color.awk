@namespace "color"

BEGIN {
    black = "\033[30m"
    red = "\033[31m"
    green = "\033[32m"
    yellow = "\033[33m"
    blue = "\033[34m"
    magenta = "\033[35m"
    cyan = "\033[36m"
    white = "\033[37m"

    bri_red = "\033[01;31m"
    bri_green = "\033[01;32m"
    bri_yellow = "\033[01;33m"
    bri_blue = "\033[01;34m"
    bri_magenta = "\033[01;35m"
    bri_cyan = "\033[01;36m"

    bg_black = "\033[40m"
    bg_red = "\033[41m"
    bg_green = "\033[42m"
    bg_yellow = "\033[43m"
    bg_blue = "\033[44m"
    bg_magenta = "\033[45m"
    bg_cyan = "\033[46m"
    bg_white = "\033[47m"

    bold = "\033[1m"

    none = "\033[0m"
}

function ize(color, string) {
    return color string none
}
