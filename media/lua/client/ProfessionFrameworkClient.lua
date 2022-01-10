--[[- All client-side calls to Events.*.Add() are defined within this file.

See `ProfessionFramework.onGameStart` and `ProfessionFramework.onNewGame`

@script ProfessionFrameworkClient
@author Fenris_Wolf
@release 1.2
@copyright 2018

]]

Events.OnGameStart.Add(ProfessionFramework.onGameStart)
Events.OnNewGame.Add(ProfessionFramework.onNewGame)
