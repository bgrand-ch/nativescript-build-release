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

echo '
# # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # #
#                                                                  #
#                         NATIVESCRIPT CLI                         #
#                  SIMPLIFY THE TNS BUILD COMMAND                  #
#                                                                  #
#  "We perfectly know DEBUG or RUN, but not necessarily BUILD..."  #
#                                                                  #
# # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # #\n'

}

##
# Show informations.
#
# Outputs:
#     informations
##
show_informations () {

echo '
The utility only uses the "nsconfig.json" file. It is at the root of your application folder, otherwise create it.

More info: https://docs.nativescript.org/core-concepts/project-structure-app#the-nsconfigjson-file

In the "nsconfig.json" file, you must add the "buildRelease" key. The "buildRelease" key can contain the following data:

    android
        keyStorePath
        keyStoreAlias
        copyPath
        options (separated by commas)
            aot
            snapshot
            compileSnapshot
            uglify
            report
            sourceMap
            hiddenSourceMap
            force
            aab (package extension)
            28 (and higher) or api28 or sdk28

    More info: https://docs.nativescript.org/tooling/docs-cli/project/testing/build-android

    ios
        teamId
        provisionUuid
        copyPath
        options (separated by commas)
            aot
            uglify
            report
            sourceMap
            hiddenSourceMap
            force
            app (package extension)
            icloud or iCloud

    More info: https://docs.nativescript.org/tooling/docs-cli/project/testing/build-ios

Latest info on GitHub: https://github.com/elvticc/nativescript-build-release'

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
                echo "\n-###-- ${menu_option} --###-"
                show_informations
                echo "${menu_write_number}"
            ;;

            "Quit") echo "\n-###-- ${menu_option} --###-\n"; break ;;

            *) echo "${menu_write_number}" ;;

        esac
    done

}
