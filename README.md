What you do is simply put:

> - .zshrc in $HOME dir
> - config in $HOME/.ssh dir
> - sanity in $HOME and $HOME/.local/bin dirs

--------------this is how I did it and i keep it uptodate-----------

> cd $HOME/Documents/GitHub/
>
> git clone https://github.com/h0t5tuff/zshell-setup.git>

### for .zshrc:

> mv ~/.zshrc ~/.zshrc.backup && rm -i ~/.zshrc
>
> ln -s ~/Documents/GitHub/zshell-setup/.zshrc ~/.zshrc

### for config:

> mv ~/.ssh/config ~/.ssh/config.backup && rm -i ~/.ssh/config
>
> ln -s ~/Documents/GitHub/zshell-setup/.ssh/config ~/.ssh/config

### for sanity:

> ln -s ~/Documents/GitHub/zshell-setup/sanity ~/sanity
>
> ln -s ~/sanity ~/.local/bin/sanity
>
> chmod +x ~/sanity
