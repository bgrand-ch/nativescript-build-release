#! /usr/bin/env bash
#
# Retrieve the content of a JSON file and the value of a specific key.
##


##
# Check if the path to the file is a JSON file.
#
# Arguments:
#     json file path
# Outputs:
#     boolean
##
is_json_file () {

    local -r json_file_path="${1}"

    if [[ -f "${json_file_path}" ]] && [[ "${json_file_path}" == *'.json' ]]; then

        printf 'true'

    else

        printf 'false'

    fi

}

##
# Check if the key name is in the content.
#
# Arguments:
#     content
#     key name
# Outputs:
#     boolean
##
has_key_name () {

    local -r content="${1}"
    local -r key_name="${2}"

    if [[ "${content}" == *"${key_name}"* ]]; then

        printf 'true'

    else

        printf 'false'

    fi

}

##
# Retrieve the content of the JSON file.
#
# Arguments:
#     json file path
# Outputs:
#     json file content or empty string
##
get_file_content () {

    local -r json_file_path="${1}"
    local -r is_json_file="$(is_json_file "${json_file_path}")"

    if "${is_json_file}"; then

        remove_white_space "$(<"${json_file_path}")"

    else

        printf '' 

    fi

}

##
# Retrieve the value of the key.
#
# Arguments:
#     file content
#     key name
#     first delimiter
#     last delimiter
# Outputs:
#     key value or empty string
##
get_key_value () {

    local -r file_content="${1}"
    local -r key_name="${2}"
    local -r first_delimiter="${3}"
    local -r last_delimiter="${4}"
    local -r has_key_name="$(has_key_name "${file_content}" "${key_name}")"

    if [[ -n "${file_content}" ]] && "${has_key_name}"; then

        printf "%s" "${file_content}" | sed "s/^.*\"${key_name}\": ${first_delimiter}//; s/${last_delimiter}.*$//"

    else

        printf ''

    fi

}
