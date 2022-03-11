crc() {
    if [ -z "$1" ]; then
        echo "Usage: crc <Component>"
        return 1
    fi
    file=`echo ${1} | awk '{ print toupper(substr($0, 1, 1)) substr($0, 2) }'`
    folder=`echo ${1} | awk '{ print tolower(substr($0, 1, 1)) substr($0, 2) }'`
    if [[ -d ${1} || -d ${folder} || -d ${file} ]]; then
        echo "Already Exists!"
        return 1
    fi
    mkdir $folder
    echo "import React from \"react\";
import \"./${file}.css\";
const ${file} = () => {
    return (
        <div>
            ${file}
        </div>
    )
}
export default ${file};" > ${folder}/${file}.js
    touch ${folder}/${file}.css
    echo "export { default as $1 } from \"./${folder}/${file}\"" >> index.js
    if [[ -d ${folder} ]]; then
        echo "React functional component ${file} successfully created!"
    fi
}

create() {
    if [ -z $1 ]; then
        echo "Usage: create <Component1> <Component2> ..."
        return 1
    fi
    args=( "$@" )
    for (( i=1;i<=$#;i++ ))
        do
            if [[ "$SHELL" =~ "bash" ]]; then
                crc ${!i}
            elif [[ "$SHELL" =~ "zsh" ]]; then
                crc ${args[i]}
            else
                echo "${SHELL} is not supported!"
            fi
    done

}