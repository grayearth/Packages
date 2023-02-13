#!/bin/bash

# Get the latest version of cloudflared
LATEST_VERSION=$(curl -s https://api.github.com/repos/cloudflare/cloudflared/releases/latest | jq -r .tag_name)

# Remove the "v" prefix from the version string
LATEST_VERSION=${LATEST_VERSION#v}

# Replace the PKG_VERSION variable in the Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=${LATEST_VERSION}/g" ./openwrt-cloudflared/Makefile

# Get the current value of the PKG_RELEASE variable in the Makefile
CURRENT_RELEASE=$(grep "PKG_RELEASE:=" ./openwrt-cloudflared/Makefile | cut -d "=" -f 2)

# Increment the PKG_RELEASE variable
NEW_RELEASE=$((CURRENT_RELEASE + 1))

# Replace the PKG_RELEASE variable in the Makefile
sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=${NEW_RELEASE}/g" ./openwrt-cloudflared/Makefile
