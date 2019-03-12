##--------------------------------------------------------------------------
##  Begin Logging
##--------------------------------------------------------------------------
$LogPath = "\\fs1\home\LPetersson\Scripts\PS\PSTranscripts\"
$LogFileName = "$(get-date -f yyyy.MM.dd.mm.ss).txt"
$LogFile = $LogPath + $LogFileName
Start-Transcript -path $LogFile -append

#$env:PSModulePath = $ENV:PSModulePath + ";\\UK0WINFAPP05P\Scripts\Modules"
