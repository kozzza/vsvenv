# vsvenv
  
Visual Studio Code virtual environment manager for Python.

vsvenv is a zsh library that contains functions to easen virtual environment setup and usage in VSCode using the built-in python venv package.

## Examples
<img src=https://github.com/kozzza/vsvenv/blob/master/project-examples/vsvenv-example-1.png width="700">
<img src=https://github.com/kozzza/vsvenv/blob/master/project-examples/vsvenv-example-2.png width="700">

## Installation

For now you can go to [vsvenv.zsh][vsvenv.zsh link] and copy the code written there. Then direct to your terminal and make sure you're using [z-shell][freecodecamp link].

Once at the home directory type in: ``nano ~/.zshrc`` and a text-editor should pop up. Paste the copied code at the bottom of the file. Then write out the file with ``ctrl+o`` ``enter`` ``ctrl+x``. Your ``.zshrc`` will now be updated with all the functionality needed to run vsvenv.

## Usage

#### Virtual Environment Setup
To create a new venv, cd into your desired project directory and type in: ``vsvenv <python-version>``<br><br>
If the directory ``./env`` already exists, you will be prompted to replace it with the venv.<br>
After the venv is created a ``settings.json`` file will be created under ``./.vscode`` if it does not already exist. The entry: ``"python.pythonPath": "env/bin/python"`` will be added to the json to link your new venv to the python interpreter in VSCode.<br><br>
You should now be ready to run your python project directly in VSCode using the venv.

[vsvenv.zsh link]: ../vsvenv/blob/master/vsvenv.zsh
[freecodecamp link]: https://www.freecodecamp.org/news/how-to-configure-your-macos-terminal-with-zsh-like-a-pro-c0ab3f3c1156/
