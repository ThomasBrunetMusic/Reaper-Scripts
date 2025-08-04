--[[

ReaScript Name: Show Instrument on Parent Track
Author: Redbeard (based on a script by Archie)
Version: 1.0
Description: This script opens the instrument on the parent track of the active MIDI editor.
Instructions: Run the script while in the midi editor, with a child track active.

--]]

-------------------------------------------------------
-- This function does nothing and is used to prevent undo history from being created when the script runs
local function no_undo() reaper.defer(function() end) end
-------------------------------------------------------

-- Get the active MIDI editor
local editor = reaper.MIDIEditor_GetActive()
if not editor then no_undo() return end

-- Get the active take in the MIDI editor
local take = reaper.MIDIEditor_GetTake(editor)
if not take then no_undo() return end

-- Get the media item associated with the take
local item = reaper.GetMediaItemTake_Item(take)
if not item then no_undo() return end

-- Get the track associated with the media item
local track = reaper.GetMediaItemTrack(item)
if not track then no_undo() return end

-- Find its parent track 
local parent_track = reaper.GetParentTrack(track)

-- Get the index of the instrument plugin on the parent track
local instrument = reaper.TrackFX_GetInstrument(parent_track)
if instrument < 0 then no_undo() return end

-- Begin an undo block
reaper.Undo_BeginBlock()

-- Show the instrument on the parent track
reaper.TrackFX_SetOpen(parent_track, instrument, true)

-- End the undo block and name it "Show Instrument of parent track"
reaper.Undo_EndBlock("Show Instrument of parent track", -1)

