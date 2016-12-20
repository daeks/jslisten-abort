#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="jslisten-abort"
rp_module_desc="Terminal based abort functionallity for all emulators by controller trigger"
rp_module_section="exp"

function depends_jslisten-abort() {

}

function sources_jslisten-abort() {
    gitPullOrClone "$md_build/jslisten" "https://github.com/workinghard/jslisten"
    gitPullOrClone "$md_build/daeks" "https://github.com/daeks/jslisten-abort"
}

function build_jslisten-abort() {

}

function install_jslisten-abort() {
    sudo mkdir /opt/bin
    sudo cp "$md_build/jslisten/bin/jslisten" "/opt/bin"
    sudo chmod +x "/opt/bin/jslisten"
    
    mkdir "$md_conf_root/jslisten"
    cp "$md_build/daeks/jslisten.cfg" "$md_conf_root/jslisten"
    cp "$md_build/daeks/runcommand.sh" "$md_conf_root/jslisten"
    sudo ln -s "$md_conf_root/jslisten/jslisten.cfg" "/root/.jslisten"
    
    sudo cp "$md_build/jslisten/utils/jslisten.service" "/etc/systemd/system"
    sudo systemctl daemon-reload
    sudo systemctl enable jslisten
    sudo systemctl start jslisten.service
}

function configure_jslisten-abort() {
    rm -R "$md_build/jslisten"
    rm -R "$md_build/daeks" 
}

