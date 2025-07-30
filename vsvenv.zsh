vsvenv () {
    _YEL='\033[0;33m'
    _GRE='\033[0;32m'
    _NC='\033[0m'
    _venv_directory=.venv

    usage() { printf "${_YEL}==>${_NC} Usage: vsvenv <python-version> [-d \"<directory>\"]\n" 1>&2; return; }

    if ! [[ $1 =~ ^3(.[0-9]{1,2})?$ ]]; then
        printf "${_YEL}==>${_NC} Invalid python version\n"
        return $(usage)
    fi
    _python_version=$1

    shift
    while getopts ":d:" o; do
        case "${o}" in
            d)
                _venv_directory=${OPTARG}
                printf "${_YEL}==>${_NC} Selected directory for new python$_python_version venv: $PWD/${_GRE}$_venv_directory${_NC}\n\n"
                if ! read -q "REPLY?Press Y/y to continue or any other key to abort: "; then
                    printf "\n${_YEL}==>${_NC} Aborted\n"
                    return
                fi
                printf "\n"
                ;;
            *)
                usage
                ;;
        esac
    done

    if [ -d $PWD/$_venv_directory ]; then
        printf "${_YEL}==>${_NC} Existing directory $PWD/${_GRE}$_venv_directory${_NC} will be replaced with new python$_python_version venv\n\n"
        if ! read -q "REPLY?Press Y/y to continue or any other key to abort: "; then
            printf "\n${_YEL}==>${_NC} Aborted\n"
            return
        fi
    printf "\n"
    rm -rf $PWD/$_venv_directory
    fi

    if python$_python_version -m venv $_venv_directory 1>/dev/null; then
        printf "${_YEL}==>${_NC} Created python$_python_version venv in $PWD/${_GRE}$_venv_directory${_NC}\n"
        _vsc_settings_file=".vscode/settings.json"

        if [ ! -f $_vsc_settings_file ]; then
            mkdir $PWD/.vscode
            echo "{\n\t\"python.pythonPath\": \"$_venv_directory/bin/python\"\n}" > $PWD/$_vsc_settings_file
        else
            arr=()
            while IFS='' read -r line; do
                arr+=("$line")
            done < <(jq 'keys[]' $PWD/$_vsc_settings_file)
            if [[ -z $(grep '[^[:space:]]' $PWD/$_vsc_settings_file) ]]; then
                echo "{\n\t\"python.pythonPath\": \"$_venv_directory/bin/python\"\n}" > $PWD/$_vsc_settings_file
            elif [[ " ${arr[@]} " =~ "python.pythonPath" ]]; then
                mv $PWD/$_vsc_settings_file temp.json
                jq -r ".\"python.pythonPath\" = \"$_venv_directory/bin/python\"" temp.json > $PWD/$_vsc_settings_file && rm temp.json;
            else
                mv $PWD/$_vsc_settings_file temp.json
                jq ". += {\"python.pythonPath\": \"$_venv_directory/bin/python\"}" temp.json > $PWD/$_vsc_settings_file && rm temp.json;
            fi
        fi
    else
        printf "${_YEL}==>${_NC} An error occurred (check if your python$_python_version installation is correct)\n"
    fi
}

actvenv () {
    if [ $# -eq 0 ]; then
        _venv_directory=venv
    else
        _venv_directory=$1
    fi
    source $_venv_directory/bin/activate
}
