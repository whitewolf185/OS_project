-- this is comment in LUA

-- inputs definition, here we use variable named inp.
--
local inp = {
    -- first input: user defined input that will be
    -- displayed as "Aileron" in setup screen
    { "Aileron", SOURCE },
    { "Elevator", SOURCE },
    -- third input: user defined constant value
    { "Ail. ratio", VALUE, -100, 100, 0 },
    { "Ele. ratio", VALUE, -100, 100, 0 }
}

-- outputs definition
local out = { "Elv1", "Elv2" }

-- periodic run function
-- order of parameters follows inp definition,
-- first parameter is "Aileron", second is "Elevator", etc...
local function run_func(input1, input2, ratio1, ratio2)
    -- remember to use local modifier for variables,
    -- if omitted variable value1 would be GLOBAL!

    -- input1 has current value of input that is selected
    -- under "Aileron" in script setup screen
    local value1 = (input1 * ratio1) / 100
    local value2 = (input2 * ratio2) / 100
    -- again, REMEMBER local
    local elevon1 = value1 + value2
    local elevon2 = value1 - value2

    -- now return outputs
    -- elevon1 returned for "Elv1", elevon2 for "Elv2"
    return elevon1, elevon2
end

-- declaration of interface (we do not use init in this example)
-- this is where we link our local variables and funcitons to the OpenTX
-- run_func() is defined as run function
-- inp table is defined as input
-- out table is defined as output
return { run=run_func, input=inp, output=out}