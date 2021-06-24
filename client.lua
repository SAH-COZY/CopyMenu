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
            RageUI.IsVisible(copymenu,function() 

              RageUI.Button("{x=, y=, z=}", nil, {}, true, {
                onSelected = function()
                  local Coords = GetEntityCoords(PlayerPedId())
                  local x, y, z = table.unpack(Coords)
                  print("{x = "..x..", y = "..y..", z = "..z.."}")
                end
              })

              RageUI.Button("Vector3", nil, {}, true, {
                onSelected = function()
                  local Coords = GetEntityCoords(PlayerPedId())
                  local x, y, z = table.unpack(Coords)
                  print("vector3("..x..", "..y..", "..z..")")
                end
              })

              RageUI.Button("Heading", nil, {}, true, {
                onSelected = function()
                  local Heading = GetEntityHeading(PlayerPedId())
                  print(Heading)
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