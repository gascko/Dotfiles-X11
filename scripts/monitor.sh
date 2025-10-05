actions="left\nright\nabove\nbelow\noff\non"
display=$(xrandr | grep " primary " | awk '{print$1 }')

monitor=$(xrandr | grep " connected " | grep -v $display | awk '{ print$1 }' | dmenu -p "Monitor")
action=$(echo -e $actions | dmenu -p "Action")

if [[ $action = "left" ]]; then
    xrandr --output $monitor --auto --left-of $display
elif [[ $action = "right" ]]; then
    xrandr --output $monitor --auto --right-of $display
elif [[ $action = "above" ]]; then
    xrandr --output $monitor --auto --above $display
elif [[ $action = "below" ]]; then
    xrandr --output $monitor --auto --below $display
elif [[ $action = "off" ]]; then
    xrandr --output $monitor --off
elif [[ $action = "on" ]]; then
    xrandr --output $monitor
fi
