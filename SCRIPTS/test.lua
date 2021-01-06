local function run_func(e)
    --
    -- NOTE: analog values (e.g. sticks and sliders) typically range from -1024 to +1024
    --       divide by 10.24 to scale into -100% thru +100%
    --       or add 1024 and divide by 20.48 to scale into 0% thru 100%
    --
    local rsValue = getValue('s2')
    lcd.clear()
    lcd.drawScreenTitle("test",1,1)
    lcd.drawText(1, 11, rsValue, 0)
    playFile("alert.wav")

    if e == EVT_EXIT_BREAK then   -- Test for Exit Key
        return 1  -- Exit

    else
        return 0
    end

end

return{run=run_func}

