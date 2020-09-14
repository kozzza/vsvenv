vsvenv () {
    YEL='\033[0;33m'
    NC='\033[0m'
    if [ -d $PWD/env ]; then
        printf "${YEL}==>${NC} Existing directory $PWD/env will be replaced with new python$1 venv\n\n"
        if ! read -q "REPLY?Press Y/y to continue or any other key to abort"; then
            printf "\n${YEL}==>${NC} Aborted\n"
    usage() { printf "${_YEL}==>${_NC} Usage: vsvenv <python-version> [-d \"<directory>\"]\n" 1>&2; return; }

    if ! [[ $1 =~ ^3(.[3-9])?$ ]]; then
        printf "${_YEL}==>${_NC} Invalid python version\n"
        return $(usage)
    fi
    _python_version=$1
            return
        fi
    printf "\n"
    rm -rf $PWD/env
    fi
    if python$1 -m venv env 1>/dev/null; then
        printf "${YEL}==>${NC} Created python$1 venv in $PWD\n"
        file=".vscode/settings.json"
        if [ ! -f $file ]; then
            mkdir $PWD/.vscode
            echo "{\n\t\"python.pythonPath\": \"env/bin/python\"\n}" > $PWD/$file
        else
            arr=()
            while IFS='' read -r line; do
                arr+=("$line")
            done < <(jq 'keys[]' $PWD/$file)
            if [[ -z $(grep '[^[:space:]]' $PWD/$file) ]]; then
                echo "{\n\t\"python.pythonPath\": \"env/bin/python\"\n}" > $PWD/$file
            elif [[ " ${arr[@]} " =~ "python.pythonPath" ]]; then
                mv $PWD/$file temp.json
                jq -r '."python.pythonPath" = "env/bin/python"' temp.json > $PWD/$file && rm temp.json;
            else
                mv $PWD/$file temp.json
                jq '. += {"python.pythonPath": "env/bin/python"}' temp.json > $PWD/$file  && rm temp.json;
            fi
        fi
    else
        printf "${YEL}==>${NC} An error occurred\n"
    fi
}