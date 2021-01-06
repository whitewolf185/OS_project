--
-- Created by IntelliJ IDEA.
-- User: matve
-- Date: 24.12.2020
-- Time: 18:01
-- To change this template use File | Settings | File Templates.
--

local function run_func(event)

--    lcd.lock()
    lcd.clear()
    lcd.drawScreenTitle("getVersion",1,1)
    lcd.drawText(10,20,getVersion(),MIDSIZE)

    if event == EVT_EXIT_BREAK then   -- Test for Exit Key
        return 1  -- Exit

    else
        return 0
    end
end

return { run=run_func }