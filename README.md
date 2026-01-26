What you do is simply put:

> - .zshrc in $HOME dir
> - config in $HOME/.ssh dir
> - sanity in $HOME and $HOME/.local/bin dirs

--------------this is how I did it and i keep it uptodate-----------

### for .zshrc:

> cd ~/Documents/GitHub/
>
> git clone https://github.com/h0t5tuff/zshell-setup.git>
>
> cd
>
> mv ~/.zshrc ~/.zshrc.backup && rm -i ~/.zshrc
>
> ln -s ~/Documents/GitHub/zshell-setup/.zshrc ~/.zshrc
>
> then,
>
> source ~/.zshrc

### for config:

>

### for sanity:

> same shit,
>
> then,
> ?
> chmod +x ~/sanity
>
> ln -s ~/sanity ~/.local/bin/sanity
