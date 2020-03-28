#! /usr/bin/env bash
#
# Utilities.
##


##
# Retrieve the directory separator according to the operating system.
# https://en.wikipedia.org/wiki/Path_(computing)
#
# Globals:
#     OSTYPE
# Outputs:
#     directory separator
##
get_directory_separator () {

    if [[ "${OSTYPE}" == 'msys' ]]; then

        printf '\'

    else

        printf '/'

    fi

}

##
# Remove all white spaces except spaces.
# https://www.shortcutfoo.com/app/dojos/regex/cheatsheet
#
# Arguments:
#     content
# Outputs:
#     content without white spaces
##
remove_white_space () {

    local -r content="${1}"

    printf "%s" "${content}" | tr -d '\b\f\n\r\t\v' | tr -s ' '

}

##
# Split the content into several items.
#
# Arguments:
#     content
#     delimiter
# Outputs:
#     items
##
split_content () {

    local -r content="${1}"
    local -r delimiter="${2}"

    printf "%s" "${content}" | tr "${delimiter}" '\n'

}
