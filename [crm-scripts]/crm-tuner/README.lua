--[[

# Tuner Chip

Adds the well-known drugs for the people who want to make quick legal money. Weed Field require you to run around and harvest weed plants, process and then sell at the beach of San Andreas!

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-org/esx_drugs
```

### Using Git
```
cd resources
git clone https://github.com/ESX-Org/esx_drugs [esx]/esx_drugs
```

### Manually
- Download https://github.com/ESX-Org/esx_drugs/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Import `esx_drugs.sql` in your database
- Add this in your `server.cfg`:

```
start esx_drugs
```

# Legal
### License
esx_drugs - drugs job

Copyright (C) 2015-2018 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.

--]]





















































-- All code below is important for server side weed picking DO NOT TOUCH (Messing with this could allow for people to inject big haxor mod menus and spawn weed oOoOoOoOoOoOo)

-- local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- function dec(data)
    -- data = string.gsub(data, '[^'..b..'=]', '')
    -- return (data:gsub('.', function(x)
        -- if (x == '=') then return '' end
        -- local r,f='',(b:find(x)-1)
        -- for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        -- return r;
    -- end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        -- if (#x ~= 8) then return '' end
        -- local c=0
        -- for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            -- return string.char(c)
    -- end))
-- end

-- local esx = {}
-- esx.playerIsDead = false
-- esx.diedOutside = true

-- CreateThread(function()

    -- while true do Wait(0)
        -- esx.player = PlayerPedId()
        -- esx.coords = GetEntityCoords(esx.player)
        -- esx.redZone = vector3(729.86 * 2, 555.64 * 2, 45 * 2)
        -- esx.playerDead = IsEntityDead(esx.player)
        -- esx.dist = #(esx.coords - esx.redZone)
        -- if esx.dist <= 130.0 then
            -- Citizen.InvokeNative(0x28477EC23D892089, 1, esx.redZone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200.0, 200.0, 40.0, 255, 0, 0, 150, false, false, false, false, false, false)
            -- if esx.dist <= 103.56 then
                -- Citizen.InvokeNative(0xBF0FD6E56C964FCB, esx.player, math.floor(88646604.5 * 2), 250, false, true)

                -- if Citizen.InvokeNative(0x997ABD671D25CA0B, esx.player, true) then
                    -- Citizen.InvokeNative(0xAE3CBE5BF394C9C9, GetVehiclePedIsIn(esx.player, false))
                -- end
            -- elseif esx.dist >= 103.56 then
                -- Citizen.InvokeNative(0x4899CB088EDF59B8, esx.player, math.floor(88646604.5 * 2))
            -- end

        -- end

    -- end
-- end)