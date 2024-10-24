RegisterCommand('devtool', function(source, args, raw)

    if source == nil or source == 0 then
        print('The devtool can not be activated from the server console.')
        return
    end

    local devMode = not Player(source).state.devmode
    Player(source).state.devmode = devMode
    if devMode then
        print(GetPlayerName(source)..' enables Dev Mode')
    else
        print(GetPlayerName(source)..' disables Dev Mode')
    end
end, true)
