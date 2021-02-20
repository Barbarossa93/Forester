# Defined in - @ line 1
function pacclean --wraps='sudo pacman -Rns (pacman -Qttdq)' --description 'alias pacclean sudo pacman -Rns (pacman -Qttdq)'
  sudo pacman -Rns (pacman -Qttdq) $argv;
end
