# Taglist
Got tired of the default Plasma Pager? Me too! That is why, inspired by panels
in tiling window managers, I made this plasmoid.

![Screenshot](Screenshots/Screenshot.png)
![Screenshot](Screenshots/Screenshot1.png)


## Note to users
This plasmoid doesn't currently offer any customization. Furthermore, it
is intended to be used in a vertical panel only.

## Installation
Later there will be a proper mechanism.
At the moment, do the following:
```
git clone https://github.com/ishovkun/taglist
cd taglist
kpackagetool5 -t Plasma/Applet --install package
```

## So how do I get those cool icons instead of boring desktop names?
That is where the beauty of customization comes.
Go to http://fontawesome.io/cheatsheet/, grab the icons you like, and set them
as names of your desktops. Note that you really need to select the icon from
that cheatsheet and also that is won't show correctly in the desktop settings
page, but it will in the plasmoid since it comes bundled with Font Awesome.

## Acknowledgments
Thanks to the authors of the Font Awesome.
