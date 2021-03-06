# -*- coding: utf-8 -*-
#
#------------------------------------------------------------
# http://www.youtube.com/user/FulguroGo/
#------------------------------------------------------------
# License: GPL (http://www.gnu.org/licenses/gpl-3.0.html)
# Based on code from youtube addon
#------------------------------------------------------------

import os # Possiblement inutilisé
import sys
import plugintools
import xbmc # Possiblement inutilisé
import xbmcaddon

from addon.common.addon import Addon

addonID = 'plugin.video.fulgurogo'
addon = Addon(addonID, sys.argv)
local = xbmcaddon.Addon(id=addonID)
icon = local.getAddonInfo('icon')

YOUTUBE_CHANNEL_ID = "FulguroGo"

# Entry point
def run():
    plugintools.log("fulgurogo.run")

    # Get params
    params = plugintools.get_params()

    if params.get("action") is None:
        main_list(params)
    else:
        pass

    plugintools.close_item_list()

# Main menu
def main_list(params):
    plugintools.log("fulgurogo.main_list "+repr(params))

    plugintools.add_item(
        #action="",
        title="Fulguro Go",
        url="plugin://plugin.video.youtube/user/"+YOUTUBE_CHANNEL_ID+"/",
        thumbnail=icon,
        folder=True)

run()