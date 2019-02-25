#!/usr/bin/env bash
hours=(
""
"🕐"
"🕑"
"🕒"
"🕓"
"🕔"
"🕕"
"🕖"
"🕗"
"🕘"
"🕙"
"🕚"
"🕛"
)
hr=$(date +%-I)
date +"📅%d %b ${hours[$hr]}%T"
