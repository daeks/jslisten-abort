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
    gitPullOrClone "$md_build" "https://github.com/daeks/jslisten-abort"
}

function install_jslisten-abort() {
    mkdir "/opt/bin"
    cp "$md_build/jslisten-abort/jslisten/bin/jslisten" "/opt/bin"
    chmod +x "/opt/bin/jslisten"
    
    mkdir "$md_conf_root/jslisten"
    cp -R "$md_build/jslisten-abort/custom/*" "$md_conf_root/jslisten"
    ln -s "$md_conf_root/jslisten/jslisten.cfg" "/root/.jslisten"
    
    cp "$md_build/jslisten-abort/jslisten/utils/jslisten.service" "/etc/systemd/system"
    systemctl daemon-reload
    systemctl enable jslisten
    systemctl start jslisten.service
}
