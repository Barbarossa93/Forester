# Defined in /tmp/fish.TIlUro/_tide_item_taskwarrior.fish @ line 2
function _tide_item_taskwarrior
    if type -q task
        set -l count (task status:pending count)
        if [ $count -gt 0 ]
            set_color magenta
            echo '' $count
        else
            set_color normal
            echo ""
        end
    end
end
