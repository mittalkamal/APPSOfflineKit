#/bin/sh

# This script builds the items to make a release of the APPSOfflineKit
#
#   1) APPSOfflineKit.framework
#   2) run-SoupToModelGenerator.sh
#
#   This items need to be dragged to the release page of github
#   https://github.com/appstronomy/APPSOfflineKit/releases
#

PROJECT_DIR="../"

build_SoupToModelGenerator() {
    echo "Build SoupToModelGenerator"
    xcodebuild -project APPSOfflineKit.xcodeproj -scheme SoupToModelGenerator -configuration Release
}


build_framework() {
    echo "Build Framework"
    carthage build --no-skip-current --platform ios
    carthage archive
}

copy_items_to_release_folder() {
    mkdir -p Release
    cd Release

    cp -v "$PROJECT_DIR/APPSOfflineKit.framework.zip" .
    cp -v "$PROJECT_DIR/SoupToModelGenerator/ModelTemplate.txt" .
    cp -v "$PROJECT_DIR/SoupToModelGenerator/SoupObjectTemplate.txt" .
    cp -v "$PROJECT_DIR/SoupToModelGenerator/SoupDescriptionTemplate.txt" .
    cp -v "$PROJECT_DIR/Scripts/run-SoupToModelGenerator.sh" .
    cp -v "$PROJECT_DIR/DerivedData/Build/Products/Release/SoupToModelGenerator" .

    # Open the Finder window showing the release items
    open .
    # Open Safari to the Release page
    open "https://github.com/appstronomy/APPSOfflineKit/releases"
}


# backup to project folder
cd "$PROJECT_DIR"

build_SoupToModelGenerator
build_framework
copy_items_to_release_folder

