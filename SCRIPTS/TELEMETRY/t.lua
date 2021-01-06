--
-- Created by IntelliJ IDEA.
-- User: matve
-- Date: 26.12.2020
-- Time: 13:25
-- To change this template use File | Settings | File Templates.
--1
local lastVal = {}

local function getTelemetryId(name)
    field = getFieldInfo(name)
    if getFieldInfo(name) then return field.id end
    return -1
end

local IDs = {}
    IDs.a4 =        getTelemetryId("A4")
    IDs.vfas =      getTelemetryId("VFAS")
    IDs.curr =      getTelemetryId("Curr")
    IDs.fuel =      getTelemetryId("Fuel")
    IDs.rssi =      getTelemetryId("RSSI")

local data = {}
    data.curr =     0
    data.fuel =     0
    data.vfas =     0
    data.a4 =       0
    data.rssi = getValue(IDs.rssi)


local function getAllData()
    data.curr = getValue(IDs.curr) * 100
    data.a4 = getValue(IDs.a4) * 100
    data.vfas = getValue(IDs.vfas) * 10
    data.fuel = getValue(IDs.fuel)
    if data.fuel > 100 then data.fuel = 100 end
end

local function setAll(num)
    data.curr =     num.curr
    data.fuel =     num.fuel
    data.vfas =     num.vfas
    data.a4 =       num.a4
end

local function init()
    getAllData()
    lastVal.a4 = data.a4
    lastVal.curr = data.curr
    lastVal.vfas = 0
    lastVal.fuel = 0
end

local time = 0
local function backgr()

    data.a4 = getValue(IDs.a4) * 100

    if data.a4 < 355 and data.a4 > 0 then

        if time == 0 then
            playFile("Alert.wav")
            time = time + 1
        elseif time < 120 then
            time = time + 1
        elseif time == 120 then
            time = 0
        end
    else
        time = 0
    end
end


local function run(event)
    data.rssi = getValue(IDs.rssi)
    lcd.clear()
    lcd.drawText(1,1,"Main telemetry",INVERS)
    local X = 5
    local Y = 10




    lcd.drawRectangle(X,Y,120,50,1)
    if data.rssi == 0 then
        setAll(lastVal)
        lcd.drawText(35,55,"No Telemetry",BLINK)

    else
        getAllData()
        lastVal.a4 = data.a4
        lastVal.curr = data.curr
        lastVal.vfas = 0
        lastVal.fuel = 0
    end

    lcd.drawText(X+5,Y+5,"lipo:",0)
    lcd.drawNumber(lcd.getLastRightPos()+2,Y+5,data.vfas,PREC1)
    lcd.drawText(lcd.getLastRightPos(),Y+5,"v",0)

    lcd.drawText(X+5,Y+15,"cell:",0)
    lcd.drawNumber(lcd.getLastRightPos()+2,Y+15,data.a4,PREC2)
    lcd.drawText(lcd.getLastRightPos(),Y+15,"v",0)

    lcd.drawText(X+5,Y+25,"rssi:",0)
    lcd.drawNumber(lcd.getLastRightPos()+2,Y+25,data.rssi,0)
    lcd.drawText(lcd.getLastRightPos(),Y+25,"Db",0)

    lcd.drawText(X+5,Y+35,"current:",0)
    lcd.drawNumber(lcd.getLastRightPos()+2,Y+35,data.curr,PREC2)
    lcd.drawText(lcd.getLastRightPos(),Y+35,"A",0)


    lcd.refresh()
end
return { background= backgr, run=run, init=init }