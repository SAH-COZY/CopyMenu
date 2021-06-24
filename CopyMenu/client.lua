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
                  print("{x = "..x..", y = "..y..", z = "..z.."}")
                end
              })

              RageUI.Button("Vector3", nil, {}, true, {
                onSelected = function()
                  print("vector3("..x..", "..y..", "..z..")")
                end
              })

              RageUI.Button("Heading", nil, {}, true, {
                onSelected = function()
                  print(heading)
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