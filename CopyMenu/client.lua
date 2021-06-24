local open = false 
local copymenu = RageUI.CreateMenu('CopyMenu', 'CopyMenu')
copymenu.Closed = function()
  open = false
end

function OpenMenuCopy()
     if open then 
         open = false
         RageUI.Visible(copymenu, false)
         return
     else
         open = true 
         RageUI.Visible(copymenu, true)
         CreateThread(function()
         while open do 
          local coords = GetEntityCoords(PlayerPedId())
          local x, y, z = table.unpack(coords)
          local heading = GetEntityHeading(PlayerPedId())
            RageUI.IsVisible(copymenu,function() 

              RageUI.Button("{x=, y=, z=}", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("CopyMenu:copyToClipboard", string.format("{x = %s, y = %s, z = %s}", tostring(x), tostring(y), tostring(z)))
                end
              })

              RageUI.Button("{x=, y=, z=, h=}", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("CopyMenu:copyToClipboard", string.format("{x = %s, y = %s, z = %s, h = %s}", tostring(x), tostring(y), tostring(z), tostring(heading)))
                end
              })

              RageUI.Button("Vector3", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("CopyMenu:copyToClipboard", string.format("vector3(%s, %s, %s)", tostring(x), tostring(y), tostring(z)))
                end
              })

              RageUI.Button("Heading", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("CopyMenu:copyToClipboard", heading)
                end
              })

            end)
          Wait(1)
         end
      end)
   end
end      

Keys.Register('F1','F1', 'CopyMenu', function()
  RageUI.CloseAll()
  OpenMenuCopy()
end)
