#!/bin/bash
cd /Users/liang/Dropbox/Workspace/HaskellSwift
#if xcodebuild -project HaskellSwift.xcodeproj -scheme HaskellSwift-OSX build ; then
  #xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize -logicTestBucketSize 32
  #./paralleltests.sh
#fi
if swift-build ; then
  ./.build/debug/HaskellSwift
fi
