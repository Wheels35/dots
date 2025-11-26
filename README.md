#######
Dotfiles
#######


deploying stowed files in folders
This will traverse into each folder for each application and use that as the 'top' level directory instead of directly from the dotfiles repo. This allows us to organize each application into a proper folder structure.
stow -R */
