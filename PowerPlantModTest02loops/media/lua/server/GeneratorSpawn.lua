local function spawnGenerator(gs, x, y, z)
    local generatorItem = InventoryItemFactory.CreateItem("Base.Generator")  -- Create generator item
    local square = getSquare(x, y, z)  -- Intended position
    local generator = IsoGenerator.new(generatorItem, square:getCell(), square)  -- Spawn Generator
    generator:setCondition(100)
    generator:setFuel(100)
    generator:setConnected(true)
    generator:setActivated(true)
    generator:setSurroundingElectricity()
    generator:transmitCompleteItemToClients()
end

local function spawnGeneratorsAtIntervals(startX, startY, startZ, numGenerators, interval)
    for i = 1, numGenerators do
        local x = startX + (i - 1) * interval
        local y = startY
        local z = startZ
        spawnGenerator(nil, x, y, z)  -- Pass nil as the first argument for gs, as it is not used in spawnGenerator
    end
end

local function checkForSpawns(gs)
    local startX, startY, startZ = 10590, 9737, 0
    local numGenerators = 5
    local interval = 20

    if gs:getX() == startX and gs:getY() == startY and gs:getZ() == startZ then
        spawnGeneratorsAtIntervals(startX, startY, startZ, numGenerators, interval)
        Events.LoadGridsquare.Remove(checkForSpawns)
    end
end

Events.LoadGridsquare.Add(checkForSpawns)
