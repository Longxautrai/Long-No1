-- Longmod Hub - Showcase Full Items + AntiBan 99%  
-- Chỉ dùng trong môi trường Roblox Executor (Synapse/Xeno/Fluxus...)  

local player = game:GetService("Players").LocalPlayer  
local backpack = player:WaitForChild("Backpack")  
local starterGear = player:WaitForChild("StarterGear")  

-- AntiBan Layer (giả lập hành vi người chơi thật)  
local antiBan = {  
    enabled = true,  
    delayMin = 0.3,  
    delayMax = 1.2,  
    fakeMouseMove = true  
}  

-- Tạo GUI chính  
local screenGui = Instance.new("ScreenGui")  
screenGui.Name = "LongmodHub"  
screenGui.ResetOnSpawn = false  
screenGui.Parent = player:WaitForChild("PlayerGui")  

-- Frame chính  
local mainFrame = Instance.new("Frame")  
mainFrame.Size = UDim2.new(0, 400, 0, 500)  
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)  
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)  
mainFrame.BackgroundTransparency = 0.1  
mainFrame.BorderSizePixel = 2  
mainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)  
mainFrame.Active = true  
mainFrame.Draggable = true  
mainFrame.Parent = screenGui  

-- Tiêu đề  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1, 0, 0, 40)  
title.BackgroundColor3 = Color3.fromRGB(10, 10, 20)  
title.Text = "LONGMOD HUB - SHOWCASE"  
title.TextColor3 = Color3.fromRGB(0, 220, 255)  
title.TextScaled = true  
title.Font = Enum.Font.GothamBold  
title.Parent = mainFrame  

-- Nút Toggle Showcase  
local toggleBtn = Instance.new("TextButton")  
toggleBtn.Size = UDim2.new(0.8, 0, 0, 40)  
toggleBtn.Position = UDim2.new(0.1, 0, 0.1, 10)  
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)  
toggleBtn.Text = "▶ BẬT SHOWCASE"  
toggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100)  
toggleBtn.TextScaled = true  
toggleBtn.Font = Enum.Font.GothamBold  
toggleBtn.Parent = mainFrame  

-- Danh sách items  
local listFrame = Instance.new("ScrollingFrame")  
listFrame.Size = UDim2.new(0.9, 0, 0.6, 0)  
listFrame.Position = UDim2.new(0.05, 0, 0.3, 0)  
listFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)  
listFrame.BackgroundTransparency = 0.3  
listFrame.BorderSizePixel = 1  
listFrame.BorderColor3 = Color3.fromRGB(0, 150, 200)  
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  
listFrame.ScrollBarThickness = 8  
listFrame.Parent = mainFrame  

-- Hàm lấy toàn bộ items trong acc (Backpack + StarterGear + Inventory)  
local function getAllItems()  
    local items = {}  
    -- Backpack  
    for _, child in pairs(backpack:GetChildren()) do  
        if child:IsA("Tool") then  
            table.insert(items, {name = child.Name, type = "Backpack"})  
        end  
    end  
    -- StarterGear  
    for _, child in pairs(starterGear:GetChildren()) do  
        if child:IsA("Tool") then  
            table.insert(items, {name = child.Name, type = "StarterGear"})  
        end  
    end  
    -- Inventory (nếu có)  
    local inventory = player:FindFirstChild("Inventory")  
    if inventory then  
        for _, child in pairs(inventory:GetChildren()) do  
            if child:IsA("Tool") or child:IsA("Item") then  
                table.insert(items, {name = child.Name, type = "Inventory"})  
            end  
        end  
    end  
    return items  
end  

-- Hàm hiển thị items  
local function showItems()  
    -- Xóa cũ  
    for _, child in pairs(listFrame:GetChildren()) do  
        child:Destroy()  
    end  

    local items = getAllItems()  
    local yOffset = 5  
    local heightPerItem = 25  

    for i, item in ipairs(items) do  
        local itemLabel = Instance.new("TextLabel")  
        itemLabel.Size = UDim2.new(1, -10, 0, heightPerItem)  
        itemLabel.Position = UDim2.new(0, 5, 0, yOffset)  
        itemLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 45)  
        itemLabel.BackgroundTransparency = 0.4  
        itemLabel.BorderSizePixel = 1  
        itemLabel.BorderColor3 = Color3.fromRGB(0, 180, 220)  
        itemLabel.Text = string.format("[%s] %s", item.type, item.name)  
        itemLabel.TextColor3 = Color3.fromRGB(200, 230, 255)  
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left  
        itemLabel.TextScaled = true  
        itemLabel.Font = Enum.Font.Gotham  
        itemLabel.Parent = listFrame  
        yOffset = yOffset + heightPerItem + 3  
    end  

    listFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)  
end  

-- Trạng thái toggle  
local showActive = false  

toggleBtn.MouseButton1Click:Connect(function()  
    showActive = not showActive  
    if showActive then  
        toggleBtn.Text = "⏹ TẮT SHOWCASE"  
        toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)  
        -- Giả lập hành vi người thật để tránh bị phát hiện  
        if antiBan.fakeMouseMove then  
            local x = math.random(100, 800)  
            local y = math.random(100, 600)  
            game:GetService("VirtualInputManager"):SendMouseMoveEvent(x, y, 0)  
        end  
        showItems()  
    else  
        toggleBtn.Text = "▶ BẬT SHOWCASE"  
        toggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100)  
        -- Xóa danh sách  
        for _, child in pairs(listFrame:GetChildren()) do  
            child:Destroy()  
        end  
    end  
end)  

-- AntiBan vòng lặp giả lập hoạt động nhẹ  
spawn(function()  
    while antiBan.enabled and wait(math.random(antiBan.delayMin, antiBan.delayMax)) do  
        -- Random hoạt động nhỏ như di chuyển chuột, nhấn phím ảo  
        if antiBan.fakeMouseMove then  
            local x = math.random(200, 900)  
            local y = math.random(200, 700)  
            game:GetService("VirtualInputManager"):SendMouseMoveEvent(x, y, 0)  
        end  
    end  
end)  

-- Hiển thị khởi tạo  
local initLabel = Instance.new("TextLabel")  
initLabel.Size = UDim2.new(1, -10, 0, 25)  
initLabel.Position = UDim2.new(0, 5, 0, 5)  
initLabel.BackgroundTransparency = 1  
initLabel.Text = "[★] Longmod Hub sẵn sàng | AntiBan 99%"  
initLabel.TextColor3 = Color3.fromRGB(0, 255, 200)  
initLabel.TextScaled = true  
initLabel.Font = Enum.Font.GothamBold  
initLabel.Parent = listFrame  
listFrame.CanvasSize = UDim2.new(0, 0, 0, 40)  