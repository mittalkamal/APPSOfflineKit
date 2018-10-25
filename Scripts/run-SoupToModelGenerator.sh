#!/bin/sh

#  run-SoupToModelGenerator.sh
#  APPSOfflineKit
#
#  Created by Ken Grigsby on 1/12/16.
#  Copyright © 2016 Appstronomy. All rights reserved.
#
# Builds swift models for all json model descriptions in the given models directory
#

if [ $# -ne 2 ] ; then
echo "usage $0 <json models directory> <output directory>"
exit 1
fi

MODELS_DIR="$1"
OUTPUT_DIR="$2"

SOUP_TO_MODEL_GENERATOR_DIR="$PROJECT_DIR/bin"
DATA_TEMPLATE="$SOUP_TO_MODEL_GENERATOR_DIR/SoupObjectTemplate.txt"
DATA_SPEC_TEMPLATE="$SOUP_TO_MODEL_GENERATOR_DIR/SoupDescriptionTemplate.txt"
MODEL_TEMPLATE="$SOUP_TO_MODEL_GENERATOR_DIR/ModelTemplate.txt"

TOOL_NAME="SoupToModelGenerator"
TOOL="/usr/local/bin/$TOOL_NAME"

# Build the SoupToModelGenerator tool in /usr/local/bin if not already there.
if [ ! -f "$TOOL" ] ; then
    PROJECT="$PROJECT_DIR/Carthage/Checkouts/APPSOfflineKit/APPSOfflineKit.xcodeproj"
    /usr/bin/env -i xcodebuild build install -project "$PROJECT" -target "$TOOL_NAME" DSTROOT=/
fi

# Look for files named "*.SoupDefinition.json" and pass each one to SoupToModelGenerator to
# generate outputs files in OUTPUT_DIR
find "$MODELS_DIR" -name "*.SoupDefinition.json" -print0 | xargs -0 -I % "$TOOL" --json % --output-dir "$OUTPUT_DIR" --spec-template "$DATA_SPEC_TEMPLATE" --data-template "$DATA_TEMPLATE" --model-template "$MODEL_TEMPLATE"
