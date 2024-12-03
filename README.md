Hello fellow nvim user :D (probably just myself on another computer...)

I noticed shortly after trying to use this configuration that you need to run a few commands to get things working properly!

So here's a quick list:

For Linux:
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

For Windows:
powershell
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

For Mac:
Get a better operating system

Then you need to head over to lua/frosts/packer.lua in nvim and run these:

    :so
    :PackerSync
    :q

If you're using my NixOS configuration file, you should be completely void of errors now. Otherwise, make sure you have a C compiler installed along with a C++ compiler and everything should run smoothly.

Enjoy!

