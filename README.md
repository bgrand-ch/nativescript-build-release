# NativeScript Build Release

A NativeScript utility to simplify the *tns build --release* command to quickly create an Android or iOS package. Currently available on MacOS and Linux.

> We perfectly know DEBUG or RUN, but not necessarily BUILD...

## Getting Started

### Prerequisites

* MacOS or Linux operating system.
* Git installed and configured. (see [Git website](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
* NativeScript installed and configured. (see [CLI setup](https://docs.nativescript.org/start/quick-setup))
* A functional project to use the utility. (see [app templates](https://docs.nativescript.org/app-templates/app-templates))

### Installation

In Terminal, run the following command to download the files from this directory.

```shell
git clone https://github.com/elvticc/nativescript-build-release
```

### Alias

In Terminal profile file (.bash_profile, .zprofile, etc.), add the following alias.

```shell
alias ns_build="sh ~/_PATH_TO_UTILITY_/nativescript-build-release/main.sh"
```

## Usage

### NSConfig file

The utility only uses the **nsconfig.json** file. It is at the root of your NativeScript project, otherwise create it. ([more info](https://docs.nativescript.org/core-concepts/project-structure-app#the-nsconfigjson-file))

In the nsconfig.json file, you must add the **buildRelease** key. The buildRelease key can contain the following data:

* android ([more info](https://docs.nativescript.org/tooling/docs-cli/project/testing/build-android))
  * keyStorePath
  * keyStoreAlias
  * copyPath
  * options (*separated by commas*)
    * aot
    * snapshot
    * compileSnapshot
    * uglify
    * report
    * sourceMap
    * hiddenSourceMap
    * force
    * aab (*package extension*)
    * 28 (*and higher*) or api28 or sdk28

* ios ([more info](https://docs.nativescript.org/tooling/docs-cli/project/testing/build-ios))
  * teamId
  * provisionUuid
  * copyPath
  * options (*separated by commas*)
    * aot
    * uglify
    * report
    * sourceMap
    * hiddenSourceMap
    * force
    * app (*package extension*)
    * icloud or iCloud

#### nsconfig.json example

```json
{
    "buildRelease": {
        "android": {
            "keyStorePath": "/Volumes/Projects/My NS App/android.keystore",
            "keyStoreAlias": "my_ns_app",
            "copyPath": "/Volumes/Projects/My NS App/App/_build/android",
            "options": "uglify, aab"
        },
        "ios": {
            "provisionUuid": "0a0a00aa-0aaa-0a00-aa00-00000a0a00a0",
            "copyPath": "/Volumes/Projects/My NS App/App/_build/ios",
            "options": "uglify"
        }
    }
}
```

### Start the utility

In Terminal, navigate to your application root folder and run `ns_build` alias to start the utility.

## License

Distributed under the MIT License. See [LICENSE](https://github.com/elvticc/nativescript-build-release/blob/master/LICENSE) for more information.

## Contact

Benjamin Grand [@elvticc](https://twitter.com/elvticc)
