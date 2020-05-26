# Custom Manjaro Bootsplash Maker
A  script to easily make a custom bootsplash for Manjaro.
Template based on <a href="https://github.com/Blacksuan19/Bootsplash-Themes" target="_blank">this</a>.

# Usage
### Please do note that this project is in a early stage. Check the code and run it only if you understand what it does!
Clone this repo and cd into it, then run the bs_maker.sh script. NOTE: As of now you have to provide the script with your own logo (must be a PNG), you can eventually find one (a big white dot) in .template. You can also use your own spinner (must be a GIF) and specify the name of the theme.
```
./bs_maker.sh -l /path/to/logo.png -s /path/to/spinner.gif (optional) -n name (optional)

Example:

./bs_maker.sh -l /home/holoitsme/Downloads/horse.png -s /home/holoitsme/Stuff/trot.gif -n horse
```
The script, in the example above, will create a directory named "manjaro-bootsplash-horse" and put those two files in it, along with the other stuff needed for you to make a functional package. If you don't provide a spinner the default one inside .template will be used. If you don't specify a name for the theme the name of the .png file will be used.

After having succesfully run the script you have to cd in the generated directory and follow the instructions inside the README file to install and set your own bootsplash.
