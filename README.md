# Custom Manjaro Bootsplash Maker
A  script to easily make a custom bootsplash for Manjaro.
Template based on <a href="https://github.com/Blacksuan19/Bootsplash-Themes" target="_blank">this</a>.

# Usage
### Please do note that this project is in a early stage. Check the code and run it only if you understand what it does!
Clone this repo and cd into it, then run the bs_maker.sh script. NOTE: As of now you have to provide the script with your own logo (must be a PNG), you can eventually find one (a big white dot) in .template. You can also use your own spinner (must be a GIF) and specify the name of the theme.

<a href="https://github.com/holoitsme/manjaro-bootsplash-maker/blob/master/.template/bootsplash-packer.rst" target="_blank">`bootsplash-packer`</a> also supports custom spinner positioning. You can specify a custom position with the `-p` flag followed by:
- `tl` - top left corner
- `t` - top
- `tr` - top right corner
- `r` - right
- `br` - bottom right corner
- `b` - bottom
- `bl` - bottom left corner
- `l` - left
(Note, these may change in the future if I find a more clever way to define this arguments)
```
./bs_maker.sh -l /path/to/logo.png -s /path/to/spinner.gif (optional) -n name (optional) -p position (optional)

Example:

./bs_maker.sh -l /home/holoitsme/Downloads/horse.png -s /home/holoitsme/Stuff/trot.gif -n horse -p br
```
The script, in the example above, will create a directory named "manjaro-bootsplash-horse" and put those two files in it, along with the other stuff needed for you to make a functional package. Also, `--pic_position` at line 48 of `bootsplash-manjaro-horse.sh` will be changed in order to position the spinner on the bottom right corner of the screen. 

If you don't provide a spinner the default one inside .template will be used. If you don't specify a name for the theme the name of the .png file will be used. If you don't specify a position the default one will be used (bottom).

After having succesfully run the script you have to cd in the generated directory and follow the instructions inside the README file to install and set your own bootsplash.
