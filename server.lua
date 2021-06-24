RegisterNetEvent("CopyMenu:copyToClipboard")
AddEventHandler("CopyMenu:copyToClipboard", function(str)
    io.popen('clip','w'):write(str):close()
end)
