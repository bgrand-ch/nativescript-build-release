#! /usr/bin/env bash
#
# Menu informations.
##


##
# Show header.
#
# Outputs:
#     header
##
show_header () {

    echo "\n# # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # #"
    echo "#                                                                  #"
    echo "#                         NATIVESCRIPT CLI                         #"
    echo "#                  SIMPLIFY THE TNS BUILD COMMAND                  #"
    echo "#                                                                  #"
    echo "#  \"We perfectly know DEBUG or RUN, but not necessarily BUILD...\"  #"
    echo "#                                                                  #"
    echo "# # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # #\n"

}

##
# Show informations.
#
# Outputs:
#     informations
##
show_informations () {

    echo "This utility only uses the 'nsconfig.json' file."
    echo "It is at the root of your NativeScript project, otherwise create it.\n"

    echo "-> See on https://docs.nativescript.org/core-concepts/project-structure-app#the-nsconfigjson-file\n"

    echo "In the 'nsconfig.json' file, you must add the 'buildRelease' key."
    echo "The 'buildRelease' key can contain the following data:\n"

    echo "    android"
    echo "        keyStorePath"
    echo "        keyStoreAlias"
    echo "        copyPath"
    echo "        options (separated by commas)"
    echo "            aot"
    echo "            snapshot"
    echo "            compileSnapshot"
    echo "            uglify"
    echo "            report"
    echo "            sourceMap"
    echo "            hiddenSourceMap"
    echo "            force"
    echo "            aab (package extension)"
    echo "            28 (and higher) or api28 or sdk28\n"

    echo "    -> See on https://docs.nativescript.org/tooling/docs-cli/project/testing/build-android\n"

    echo "    ios"
    echo "        teamId"
    echo "        provisionUuid"
    echo "        copyPath"
    echo "        options (separated by commas)"
    echo "            aot"
    echo "            uglify"
    echo "            report"
    echo "            sourceMap"
    echo "            hiddenSourceMap"
    echo "            force"
    echo "            app (package extension)"
    echo "            icloud or iCloud\n"

    echo "    -> See on https://docs.nativescript.org/tooling/docs-cli/project/testing/build-ios"

}

##
# Show menu.
#
# Outputs:
#     menu
##
show_menu () {

    local -r menu_options=("Build for android" "Build for ios" "Build for both" "More informations" "Quit")
    local -r menu_write_number="\n-###-- Write one of the menu numbers to continue --###-"

    select menu_option in "${menu_options[@]}"; do
        case "${menu_option}" in
            
            "Build for android")
                echo "\n-###-- ${menu_option} --###-\n"
                build_android_release
                break
            ;;

            "Build for ios")
                echo "\n-###-- ${menu_option} --###-"
                build_ios_release
                break
            ;;

            "Build for both")
                echo "\n-###-- ${menu_option} --###-\n"
                build_android_release
                build_ios_release
                break
            ;;

            "More informations")
                echo "\n-###-- ${menu_option} --###-\n"
                show_informations
                echo "${menu_write_number}"
            ;;

            "Quit") echo "\n-###-- ${menu_option} --###-\n"; break ;;

            *) echo "${menu_write_number}" ;;

        esac
    done

}
