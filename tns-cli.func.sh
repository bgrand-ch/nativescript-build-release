#! /usr/bin/env bash
#
# Generate the NativeScript build command for Android and iOS, with options.
##


local -r dir_separator="$(get_directory_separator)"
local -r nsconfig_path="${PWD}${dir_separator}nsconfig.json"
local -r json_file_content="$(get_file_content "${nsconfig_path}")"
local -r main_key_content="$(get_key_value "${json_file_content}" "buildRelease" "{" "} }")"
local -r delimiters='"'

##
# Retrieve the package extension according to the option or the operating system.
#
# Arguments:
#     operating system
#     options
# Outputs:
#     package extension
##
get_package_extension () {

    local -r operating_system="${1}"
    local -r options="${2}"
    local extension=''

    case "${options}" in

        *aab*) extension='aab' ;;

        *app*) extension='app' ;;

        *)
            if [[ "${operating_system}" == 'android' ]]; then

                extension='apk'

            else

                extension='ipa'

            fi
        ;;

    esac

    printf "${extension}"

}

##
# Retrieve, rename or refuse the option.
#
# Arguments:
#     option
# Outputs:
#     nativescript option
##
get_ns_option () {

    local -r option="${1}"
    local ns_option=''

    case "${option}" in

        release | key-store-[a-z]* | copy-to | for-device | \
        team-id | provision | apk | app | ipa) ns_option='' ;;

        aot | snapshot | compileSnapshot | \
        uglify | report | sourceMap | hiddenSourceMap) ns_option="env.${option}" ;;

        [0-9]* | api[0-9]* | sdk[0-9]*) ns_option="compileSdk $(printf "${option}" | sed 's/[^0-9]*//g')" ;;

        i[cC]loud) ns_option='i-cloud-container-environment' ;;

        *) ns_option="${option}" ;;

    esac

    printf "${ns_option}"

}

##
# Retrieve all options and format them for the CLI.
#
# Arguments:
#     options
# Outputs:
#     formatted options
##
get_formatted_options () {

    local -r options=($(split_content "${1}" ","))
    local ns_option=''
    local formatted_options=''

    for option in "${options[@]}"; do

        ns_option="$(get_ns_option "${option}")"

        if [[ -n "${ns_option}" ]]; then

            formatted_options+=" --${ns_option}"

        fi

    done

    printf "%s" "${formatted_options}"

}

##
# Retrieve the formatted parameter for the CLI.
#
# Arguments:
#     name
#     value
# Outputs:
#     formatted parameter
##
get_formatted_parameter () {

    local -r name="${1}"
    local -r value="${2}"

    printf "%s" "--${name} \"${value}\""

}

##
# Retrieve the file name with extension.
#
# Globals:
#     PWD
# Arguments:
#     operating system
#     options
# Outputs:
#     file name with extension
##
get_file_name () {

    local -r operating_system="${1}"
    local -r options="${2}"
    local -r current_folder_name="${PWD##*/}"
    local -r file_name="$(printf "${current_folder_name}" | tr [:upper:] [:lower:] | tr [:space:] '_')"
    local -r extension="$(get_package_extension "${operating_system}" "${options}")"
    
    printf "${file_name}.${extension}"

}

##
# Assemble the TNS command and build the Android release.
#
# Globals:
#     dir_separator
#     main_key_content
#     delimiters
# Outputs:
#     tns build android
##
build_android_release () {

    local -r key_name='android'
    local -r tns='tns build android --release'
    local -r key_content="$(get_key_value "${main_key_content}" "${key_name}" "{" "}")"
    local -r options="$(get_key_value "${key_content}" "options" "${delimiters}" "${delimiters}")"
    local -r formatted_options="$(get_formatted_options "${options}")"
    local -r file_name="$(get_file_name "${key_name}" "${options}")"
    local copy_path="$(get_key_value "${key_content}" "copyPath" "${delimiters}" "${delimiters}")"
    local store_path="$(get_key_value "${key_content}" "keyStorePath" "${delimiters}" "${delimiters}")"
    local store_alias="$(get_key_value "${key_content}" "keyStoreAlias" "${delimiters}" "${delimiters}")"
    local store_password=''
    local alias_password=''

    read -s -p "Enter the ${key_name} store password: " store_password; echo ''
    read -s -p "Enter the ${key_name} store alias password: " alias_password; echo ''

    copy_path="$(get_formatted_parameter "copy-to" "${copy_path}${dir_separator}${file_name}")"
    store_path="$(get_formatted_parameter "key-store-path" "${store_path}")"
    store_alias="$(get_formatted_parameter "key-store-alias" "${store_alias}")"
    store_password="$(get_formatted_parameter "key-store-password" "${store_password}")"
    alias_password="$(get_formatted_parameter "key-store-alias-password" "${alias_password}")"

    echo "\n-###-- Building ${key_name} release... --###-\n"
    eval "${tns} ${copy_path} ${store_path} ${store_alias} ${store_password} ${alias_password} ${formatted_options}"
    echo "\n-###-- Finished for ${key_name} release! --###-\n"

}

##
# Assemble the TNS command and build the iOS release.
#
# Globals:
#     dir_separator
#     main_key_content
#     delimiters
# Outputs:
#     tns build ios
##
build_ios_release () {

    local -r key_name='ios'
    local -r tns='tns build ios --release --for-device'
    local -r key_content="$(get_key_value "${main_key_content}" "${key_name}" "{" "}")"
    local -r options="$(get_key_value "${key_content}" "options" "${delimiters}" "${delimiters}")"
    local -r formatted_options="$(get_formatted_options "${options}")"
    local -r file_name="$(get_file_name "${key_name}" "${options}")"
    local copy_path="$(get_key_value "${key_content}" "copyPath" "${delimiters}" "${delimiters}")"
    local team_id="$(get_key_value "${key_content}" "teamId" "${delimiters}" "${delimiters}")"
    local provision_uuid="$(get_key_value "${key_content}" "provisionUuid" "${delimiters}" "${delimiters}")"

    copy_path="$(get_formatted_parameter "copy-to" "${copy_path}${dir_separator}${file_name}")"
    team_id="$(get_formatted_parameter "team-id" "${team_id}")"
    provision_uuid="$(get_formatted_parameter "provision" "${provision_uuid}")"

    echo "\n-###-- Building ${key_name} release... --###-\n"
    eval "${tns} ${copy_path} ${team_id} ${provision_uuid} ${formatted_options}"
    echo "\n-###-- Finished for ${key_name} release! --###-\n"

}
