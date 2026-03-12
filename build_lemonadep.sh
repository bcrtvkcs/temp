#!/bin/bash

ROOMSERVICE="$HOME/crDroid/.repo/local_manifests/roomservice.xml"

EXPECTED='<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project path="device/oneplus/lemonadep" remote="crdroid" name="crdroidandroid/android_device_oneplus_lemonadep" revision="16.0" />
  <project path="device/oneplus/sm8350-common" remote="crdroid" name="crdroidandroid/android_device_oneplus_sm8350-common" revision="16.0" />
  <project path="vendor/oneplus/lemonadep" remote="crdroid-gitlab" name="crdroidandroid/proprietary_vendor_oneplus-lemonadep" revision="16.0" />
  <project path="kernel/oneplus/sm8350" remote="github" name="bcrtvkcs/aesir_kernel_oneplus_sm8350" revision="16.0" />
  <project path="hardware/oplus" remote="crdroid" name="crdroidandroid/android_hardware_oplus" revision="16.0" />
  <project path="vendor/oneplus/sm8350-common" remote="crdroid-gitlab" name="crdroidandroid/proprietary_vendor_oneplus_sm8350-common" revision="16.0" />
</manifest>'

CURRENT=$(cat "$ROOMSERVICE" 2>/dev/null)

if [ "$CURRENT" != "$EXPECTED" ]; then
    echo "roomservice.xml changed, updating and running repo sync..."
    mkdir -p "$(dirname "$ROOMSERVICE")"
    printf '%s' "$EXPECTED" > "$ROOMSERVICE"
    (cd "$HOME/crDroid" && repo sync -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j$(nproc --all))
else
    echo "roomservice.xml unchanged, skipping repo sync."
fi

(cd "$HOME/crDroid" && . build/envsetup.sh && brunch lemonadep && zcat "$HOME/crDroid/out/verbose.log.gz" > "$HOME/buildoutput_lemonadep.log" && grep -Ei "fatal|error|unexpected|fail" "$HOME/buildoutput_lemonadep.log" > "$HOME/builderrors_lemonadep.txt")
