local KVPName = 'DevTool'
local command = GetResourceKvpString(KVPName)
if not command then
    command = 'ensure '..GetCurrentResourceName()
    SetResourceKvp(KVPName, command)
end

AddTextEntry('DEVTOOLWAT', 'Issue what commands? ; separates')
AddTextEntry('DEVTOOLPROPMT', 'F5: ~a~')

function GetInput()
    DisplayOnscreenKeyboard(
        0,
        'DEVTOOLWAT', -- Window title
        "P2", -- Unknown?
        command, -- Default text
        "",
        "",
        "",
        255 -- Max length
    )
    while true do
        Citizen.Wait(0)
        local status = UpdateOnscreenKeyboard()
        if status == 1 then -- Done!
            return GetOnscreenKeyboardResult()
        elseif status == 2 then
            return nil -- Canceled
        elseif status == 3 then
            return nil -- Not active, wtf happened?
        end
    end
end

function TrimSpaces(input)
    return (input:gsub("^%s*(.-)%s*$", "%1"))
end

function Split(input, separator)
    separator = separator or ';'
    local result = {}
    for piece in string.gmatch(input, "([^"..separator.."]+)") do
        table.insert(result, TrimSpaces(piece))
    end
    return result
end

function DrawText()
    ClearDrawOrigin()
    BeginTextCommandDisplayText('DEVTOOLPROPMT')
    SetTextCentre(true)
    SetTextOutline()
    SetTextColour(255, 255, 255, 128)
    SetTextScale(0.3, 0.3)
    AddTextComponentSubstringPlayerName(tostring(command))
    EndTextCommandDisplayText(0.5, 0.0)
end

---@diagnostic disable-next-line:param-type-mismatch nil means I don't care, you silly analyzer!
AddStateBagChangeHandler('devtool', nil, function(bagName, key, value)
    if key ~= 'devtool' then return end
    if value then
        print("Developer tool enabled")
    else
        print("Developer tool disabled")
    end
end)

Citizen.CreateThread(function()
    while true do

        if LocalPlayer.state.devmode then
            DrawText()
            if IsDisabledControlJustPressed(0, 166) then -- F5
                if IsDisabledControlPressed(0, 21) then -- Shift
                    local newCommand = GetInput()
                    if newCommand and newCommand ~= command then
                        SetResourceKvp(KVPName, newCommand)
                        command = newCommand
                    end
                else
                    local commands = Split(command)
                    for _,thisCommand in ipairs(commands) do
                        if thisCommand == "" then
                            print("Waiting for a moment...")
                        else
                            print(("Issuing command %q"):format(thisCommand))
                            ExecuteCommand(thisCommand)
                        end
                        Citizen.Wait(500)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)
