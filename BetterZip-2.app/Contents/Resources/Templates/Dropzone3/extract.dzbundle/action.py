# Dropzone Action Info
# Name: %service-name%
# Description: This action sends the dropped items to BetterZip to extract them with the preset %preset-name%. When clicked, BetterZip is activated.
# Handles: Files
# Creator: Robert Rezabek
# URL: https://macitbetter.com/
# Events: Clicked, Dragged
# KeyModifiers: Command, Option, Control, Shift
# SkipConfig: Yes
# RunsSandboxed: No
# Version: 1.0
# MinDropzoneVersion: 3.5

import ScriptingBridge
import time
import urllib
import os

def dragged():
	preset = '%preset-name%'

	dz.begin("%service-name%...")
	dz.determinate(True)

	BetterZip = ScriptingBridge.SBApplication.applicationWithBundleIdentifier_("com.macitbetter.betterzip")
	pid = BetterZip.queuedUnarchive_withPreset_withOptions_showUi_(items, preset, {}, False)

	if pid > 0:
		a = BetterZip.progress_(pid)
		while a < 100 and BetterZip.isRunning():
			a = BetterZip.progress_(pid)
			dz.percent(a)
			time.sleep(1)
		files = BetterZip.output_(pid)
		# dz.add_dropbar([url.path() for url in files])
	else:
		dz.fail("The operation failed.")

	dz.url(False)

def clicked():
  # When a user clicks the action, BetterZip.app is started
  os.system('open -a BetterZip.app')
