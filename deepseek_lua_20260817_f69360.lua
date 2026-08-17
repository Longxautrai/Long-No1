-- ============================================  
-- LONGMOD ITEMS SHOWCASE - HIỂN THỊ 100% ITEMS  
-- Tất cả items trong acc: Backpack, Stash, Inventory, Tool, v.v...  
-- ============================================  

local player = game:GetService("Players").LocalPlayer  
local playerGui = player:WaitForChild("PlayerGui")  

-- Xóa GUI cũ  
local oldGui = playerGui:FindFirstChild("LongmodHub")  
if oldGui then oldGui:Destroy() end  

local gui = Instance.new("ScreenGui")  
gui.Name = "LongmodHub"  
gui.ResetOnSpawn = false  
gui.Parent = playerGui  

-- ===== FRAME CHÍNH =====  
local main = Instance.new("Frame")  
main.Size = UDim2.new(0, 500, 0, 600)  
main.Position = UDim2.new(0.5, -250, 0.5, -300)  
main.BackgroundColor3 = Color3.fromRGB(8, 8, 25)  
main.BackgroundTransparency = 0.05  
main.BorderSizePixel = 2  
main.BorderColor3 = Color3.fromRGB(0, 200, 255)  
main.Active = true  
main.Draggable = true  
main.Parent = gui  

-- ===== HEADER =====  
local header = Instance.new("Frame")  
header.Size = UDim2.new(1, 0, 0, 50)  
header.BackgroundColor3 = Color3.fromRGB(0, 80, 180)  
header.BackgroundTransparency = 0.2  
header.Parent = main  

local title = Instance.new("TextLabel")  
title.Size = UDim2.new(0.7, 0, 1, 0)  
title.Position = UDim2.new(0, 15, 0, 0)  
title.BackgroundTransparency = 1  
title.Text = "🎒 LONGMOD ITEMS"  
title.TextColor3 = Color3.fromRGB(255, 255, 255)  
title.TextScaled = true  
title.TextXAlignment = Enum.TextXAlignment.Left  
title.Font = Enum.Font.GothamBold  
title.Parent = header  

local itemCount = Instance.new("TextLabel")  
itemCount.Size = UDim2.new(0.3, 0, 1, 0)  
itemCount.Position = UDim2.new(0.7, 0, 0, 0)  
itemCount.BackgroundTransparency = 1  
itemCount.Text = "0 items"  
itemCount.TextColor3 = Color3.fromRGB(0, 255, 200)  
itemCount.TextScaled = true  
itemCount.TextXAlignment = Enum.TextXAlignment.Right  
itemCount.Font = Enum.Font.Gotham  
itemCount.Parent = header  

local close = Instance.new("TextButton")  
close.Size = UDim2.new(0, 30, 0, 30)  
close.Position = UDim2.new(1, -40, 0, 10)  
close.BackgroundTransparency = 0.5  
close.BorderSizePixel = 1  
close.BorderColor3 = Color3.fromRGB(255, 80, 80)  
close.Text = "✕"  
close.TextColor3 = Color3.fromRGB(255, 80, 80)  
close.TextScaled = true  
close.Font = Enum.Font.GothamBold  
close.Parent = header  
close.MouseButton1Click:Connect(function() gui:Destroy() end)  

local mini = Instance.new("TextButton")  
mini.Size = UDim2.new(0, 30, 0, 30)  
mini.Position = UDim2.new(1, -75, 0, 10)  
mini.BackgroundTransparency = 0.5  
mini.BorderSizePixel = 1  
mini.BorderColor3 = Color3.fromRGB(150, 150, 200)  
mini.Text = "─"  
mini.TextColor3 = Color3.fromRGB(200, 200, 255)  
mini.TextScaled = true  
mini.Font = Enum.Font.GothamBold  
mini.Parent = header  

local minimized = false  
mini.MouseButton1Click:Connect(function()  
    minimized = not minimized  
    if minimized then  
        main.Size = UDim2.new(0, 100, 0, 45)  
        main.Position = UDim2.new(0.85, 0, 0.1, 0)  
        title.Text = "🎒"  
        itemCount.Visible = false  
        close.Visible = false  
        mini.Text = "□"  
        mini.Position = UDim2.new(1, -38, 0, 8)  
    else  
        main.Size = UDim2.new(0, 500, 0, 600)  
        main.Position = UDim2.new(0.5, -250, 0.5, -300)  
        title.Text = "🎒 LONGMOD ITEMS"  
        itemCount.Visible = true  
        close.Visible = true  
        mini.Text = "─"  
        mini.Position = UDim2.new(1, -75, 0, 10)  
    end  
end)  

-- ===== NÚT SẮP XẾP =====  
local sortFrame = Instance.new("Frame")  
sortFrame.Size = UDim2.new(1, -20, 0, 35)  
sortFrame.Position = UDim2.new(0, 10, 0, 55)  
sortFrame.BackgroundTransparency = 1  
sortFrame.Parent = main  

local sortBtns = {  
    {name = "📛 Tên", type = "name"},  
    {name = "📂 Loại", type = "type"}  
}  

local currentSort = "name"  
local sortBtnObjs = {}  

for i, btnData in ipairs(sortBtns) do  
    local btn = Instance.new("TextButton")  
    btn.Size = UDim2.new(0.3, 0, 1, 0)  
    btn.Position = UDim2.new((i-1) * 0.35 + 0.05, 0, 0, 0)  
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)  
    btn.BackgroundTransparency = 0.2  
    btn.BorderSizePixel = 1  
    btn.BorderColor3 = Color3.fromRGB(0, 150, 200)  
    btn.Text = btnData.name  
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)  
    btn.TextScaled = true  
    btn.Font = Enum.Font.Gotham  
    btn.Parent = sortFrame  
    btn.Name = btnData.type  
    sortBtnObjs[btnData.type] = btn  
    
    btn.MouseButton1Click:Connect(function()  
        currentSort = btnData.type  
        for _, b in pairs(sortBtnObjs) do  
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 50)  
            b.BorderColor3 = Color3.fromRGB(0, 150, 200)  
            b.TextColor3 = Color3.fromRGB(200, 200, 220)  
        end  
        btn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)  
        btn.BorderColor3 = Color3.fromRGB(0, 200, 255)  
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)  
        renderItems()  
    end)  
end  

-- Highlight nút đầu tiên  
sortBtnObjs["name"].BackgroundColor3 = Color3.fromRGB(0, 100, 180)  
sortBtnObjs["name"].BorderColor3 = Color3.fromRGB(0, 200, 255)  
sortBtnObjs["name"].TextColor3 = Color3.fromRGB(255, 255, 255)  

-- ===== DANH SÁCH ITEMS =====  
local listFrame = Instance.new("ScrollingFrame")  
listFrame.Size = UDim2.new(0.94, 0, 0.73, 0)  
listFrame.Position = UDim2.new(0.03, 0, 0.18, 0)  
listFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 18)  
listFrame.BackgroundTransparency = 0.3  
listFrame.BorderSizePixel = 1  
listFrame.BorderColor3 = Color3.fromRGB(0, 100, 180)  
listFrame.ScrollBarThickness = 6  
listFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)  
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  
listFrame.Parent = main  

-- ===== THANH TRẠNG THÁI =====  
local statusBar = Instance.new("Frame")  
statusBar.Size = UDim2.new(1, -20, 0, 30)  
statusBar.Position = UDim2.new(0, 10, 0.94, 0)  
statusBar.BackgroundColor3 = Color3.fromRGB(10, 10, 30)  
statusBar.BackgroundTransparency = 0.3  
statusBar.BorderSizePixel = 1  
statusBar.BorderColor3 = Color3.fromRGB(0, 100, 150)  
statusBar.Parent = main  

local statusText = Instance.new("TextLabel")  
statusText.Size = UDim2.new(0.8, 0, 1, 0)  
statusText.Position = UDim2.new(0, 5, 0, 0)  
statusText.BackgroundTransparency = 1  
statusText.Text = "✅ Đang tải..."  
statusText.TextColor3 = Color3.fromRGB(150, 200, 255)  
statusText.TextScaled = true  
statusText.TextXAlignment = Enum.TextXAlignment.Left  
statusText.Font = Enum.Font.Gotham  
statusText.Parent = statusBar  

local refreshBtn = Instance.new("TextButton")  
refreshBtn.Size = UDim2.new(0, 35, 0, 25)  
refreshBtn.Position = UDim2.new(0.9, 0, 0.08, 0)  
refreshBtn.BackgroundColor3 = Color3.fromRGB(30, 70, 120)  
refreshBtn.BackgroundTransparency = 0.3  
refreshBtn.BorderSizePixel = 1  
refreshBtn.BorderColor3 = Color3.fromRGB(0, 180, 255)  
refreshBtn.Text = "⟳"  
refreshBtn.TextColor3 = Color3.fromRGB(0, 200, 255)  
refreshBtn.TextScaled = true  
refreshBtn.Font = Enum.Font.GothamBold  
refreshBtn.Parent = statusBar  

-- ===== HÀM LẤY TOÀN BỘ ITEMS =====  
local function getAllItems()  
    local allItems = {}  
    local checked = {}  
    
    -- Hàm kiểm tra và thêm item  
    local function addItem(name, type, container)  
        if not checked[name] then  
            table.insert(allItems, {  
                name = name,  
                type = type,  
                container = container  
            })  
            checked[name] = true  
        end  
    end  
    
    -- 1. BACKPACK  
    local bp = player:FindFirstChild("Backpack")  
    if bp then  
        for _, child in pairs(bp:GetChildren()) do  
            if child:IsA("Tool") then  
                addItem(child.Name, "Backpack", "Backpack")  
            end  
        end  
    end  
    
    -- 2. STARTER GEAR  
    local sg = player:FindFirstChild("StarterGear")  
    if sg then  
        for _, child in pairs(sg:GetChildren()) do  
            if child:IsA("Tool") then  
                addItem(child.Name, "Starter", "StarterGear")  
            end  
        end  
    end  
    
    -- 3. CHARACTER (đang cầm)  
    local char = player.Character  
    if char then  
        for _, child in pairs(char:GetChildren()) do  
            if child:IsA("Tool") then  
                addItem(child.Name, "Equipped", "Character")  
            end  
        end  
    end  
    
    -- 4. INVENTORY (Blox Fruits thường dùng)  
    local inv = player:FindFirstChild("Inventory")  
    if inv then  
        for _, child in pairs(inv:GetChildren()) do  
            if child:IsA("Tool") then  
                addItem(child.Name, "Inventory", "Inventory")  
            end  
        end  
    end  
    
    -- 5. STASH - Tìm trong tất cả các Folder của player  
    for _, child in pairs(player:GetChildren()) do  
        if child:IsA("Folder") then  
            local name = child.Name:lower()  
            if name:find("stash") or name:find("storage") or name:find("bank") or name:find("chest") then  
                for _, sub in pairs(child:GetChildren()) do  
                    if sub:IsA("Tool") then  
                        addItem(sub.Name, "Stash", child.Name)  
                    end  
                end  
            end  
        end  
    end  
    
    -- 6. DATA - Lưu trữ dạng StringValue/IntValue  
    local data = player:FindFirstChild("Data")  
    if data then  
        for _, child in pairs(data:GetChildren()) do  
            if child:IsA("StringValue") or child:IsA("IntValue") or child:IsA("NumberValue") then  
                local val = tostring(child.Value)  
                if #val > 15 then val = string.sub(val, 1, 12) .. "..." end  
                addItem(child.Name .. " = " .. val, "Data", "Data")  
            end  
        end  
    end  
    
    -- 7. Tìm trong ReplicatedStorage (game items)  
    local repStorage = game:GetService("ReplicatedStorage")  
    local itemModules = repStorage:FindFirstChild("Items") or repStorage:FindFirstChild("ItemData")  
    if itemModules then  
        for _, child in pairs(itemModules:GetChildren()) do  
            if child:IsA("ModuleScript") or child:IsA("Folder") then  
                addItem(child.Name, "GameItems", "ReplicatedStorage")  
            end  
        end  
    end  
    
    return allItems  
end  

-- ===== HÀM RENDER ITEMS =====  
local function renderItems()  
    -- Xóa danh sách cũ  
    for _, child in pairs(listFrame:GetChildren()) do  
        child:Destroy()  
    end  
    
    local allItems = getAllItems()  
    
    -- Sắp xếp  
    if currentSort == "name" then  
        table.sort(allItems, function(a, b) return a.name < b.name end)  
    elseif currentSort == "type" then  
        table.sort(allItems, function(a, b)  
            if a.type == b.type then return a.name < b.name end  
            return a.type < b.type  
        end)  
    end  
    
    -- Màu sắc theo loại  
    local typeColors = {  
        Backpack = Color3.fromRGB(100, 200, 255),  
        Starter = Color3.fromRGB(255, 200, 100),  
        Equipped = Color3.fromRGB(100, 255, 150),  
        Inventory = Color3.fromRGB(200, 100, 255),  
        Stash = Color3.fromRGB(255, 150, 100),  
        Data = Color3.fromRGB(150, 220, 220),  
        GameItems = Color3.fromRGB(255, 100, 200)  
    }  
    
    local typeIcons = {  
        Backpack = "🎒",  
        Starter = "⭐",  
        Equipped = "⚔️",  
        Inventory = "📦",  
        Stash = "📁",  
        Data = "📊",  
        GameItems = "🎮"  
    }  
    
    local y = 5  
    local h = 28  
    
    if #allItems == 0 then  
        local empty = Instance.new("TextLabel")  
        empty.Size = UDim2.new(1, -10, 0, 50)  
        empty.Position = UDim2.new(0, 5, 0, 20)  
        empty.BackgroundTransparency = 1  
        empty.Text = "📭 KHÔNG TÌM THẤY ITEMS NÀO\nHãy vào game để có item!"  
        empty.TextColor3 = Color3.fromRGB(150, 150, 200)  
        empty.TextScaled = true  
        empty.Font = Enum.Font.Gotham  
        empty.Parent = listFrame  
        listFrame.CanvasSize = UDim2.new(0, 0, 0, 100)  
        statusText.Text = "📭 Tổng: 0 items"  
        itemCount.Text = "0 items"  
    else  
        local groups = {}  
        if currentSort == "type" then  
            -- Nhóm theo loại  
            for _, item in ipairs(allItems) do  
                if not groups[item.type] then  
                    groups[item.type] = {}  
                end  
                table.insert(groups[item.type], item)  
            end  
            
            for type, items in pairs(groups) do  
                -- Header loại  
                local headerRow = Instance.new("Frame")  
                headerRow.Size = UDim2.new(1, -10, 0, 22)  
                headerRow.Position = UDim2.new(0, 5, 0, y)  
                headerRow.BackgroundColor3 = Color3.fromRGB(0, 60, 120)  
                headerRow.BackgroundTransparency = 0.3  
                headerRow.BorderSizePixel = 1  
                headerRow.BorderColor3 = Color3.fromRGB(0, 150, 255)  
                headerRow.Parent = listFrame  
                
                local headerLbl = Instance.new("TextLabel")  
                headerLbl.Size = UDim2.new(1, -10, 1, 0)  
                headerLbl.Position = UDim2.new(0, 5, 0, 0)  
                headerLbl.BackgroundTransparency = 1  
                headerLbl.Text = string.format("📂 %s (%d)", type, #items)  
                headerLbl.TextColor3 = Color3.fromRGB(0, 200, 255)  
                headerLbl.TextScaled = true  
                headerLbl.TextXAlignment = Enum.TextXAlignment.Left  
                headerLbl.Font = Enum.Font.GothamBold  
                headerLbl.Parent = headerRow  
                
                y = y + 25  
                
                for i, item in ipairs(items) do  
                    local row = Instance.new("Frame")  
                    row.Size = UDim2.new(1, -10, 0, h)  
                    row.Position = UDim2.new(0, 5, 0, y)  
                    row.BackgroundColor3 = Color3.fromRGB(20, 20, 45)  
                    row.BackgroundTransparency = 0.15  
                    row.BorderSizePixel = 1  
                    row.BorderColor3 = typeColors[item.type] or Color3.fromRGB(100, 200, 255)  
                    row.Parent = listFrame  
                    
                    local iconLbl = Instance.new("TextLabel")  
                    iconLbl.Size = UDim2.new(0, 30, 1, 0)  
                    iconLbl.Position = UDim2.new(0, 3, 0, 0)  
                    iconLbl.BackgroundTransparency = 1  
                    iconLbl.Text = typeIcons[item.type] or "🔹"  
                    iconLbl.TextColor3 = Color3.fromRGB(255, 255, 255)  
                    iconLbl.TextScaled = true  
                    iconLbl.Font = Enum.Font.Gotham  
                    iconLbl.Parent = row  
                    
                    local nameLbl = Instance.new("TextLabel")  
                    nameLbl.Size = UDim2.new(0.75, 0, 1, 0)  
                    nameLbl.Position = UDim2.new(0, 35, 0, 0)  
                    nameLbl.BackgroundTransparency = 1  
                    nameLbl.Text = item.name  
                    nameLbl.TextColor3 = Color3.fromRGB(220, 235, 255)  
                    nameLbl.TextXAlignment = Enum.TextXAlignment.Left  
                    nameLbl.TextScaled = true  
                    nameLbl.Font = Enum.Font.Gotham  
                    nameLbl.Parent = row  
                    
                    local typeLbl = Instance.new("TextLabel")  
                    typeLbl.Size = UDim2.new(0, 80, 0, 16)  
                    typeLbl.Position = UDim2.new(0.8, 0, 0.5, -8)  
                    typeLbl.BackgroundTransparency = 1  
                    typeLbl.Text = item.type  
                    typeLbl.TextColor3 = typeColors[item.type] or Color3.fromRGB(150, 150, 200)  
                    typeLbl.TextScaled = true  
                    typeLbl.Font = Enum.Font.Gotham  
                    typeLbl.Parent = row  
                    
                    y = y + h + 3  
                end  
            end  
        else  
            -- Hiển thị bình thường  
            for i, item in ipairs(allItems) do  
                local row = Instance.new("Frame")  
                row.Size = UDim2.new(1, -10, 0, h)  
                row.Position = UDim2.new(0, 5, 0, y)  
                row.BackgroundColor3 = Color3.fromRGB(20, 20, 45)  
                row.BackgroundTransparency = 0.15  
                row.BorderSizePixel = 1  
                row.BorderColor3 = typeColors[item.type] or Color3.fromRGB(100, 200, 255)  
                row.Parent = listFrame  
                
                local numLbl = Instance.new("TextLabel")  
                numLbl.Size = UDim2.new(0, 35, 1, 0)  
                numLbl.Position = UDim2.new(0, 2, 0, 0)  
                numLbl.BackgroundTransparency = 1  
                numLbl.Text = string.format("%02d.", i)  
                numLbl.TextColor3 = Color3.fromRGB(100, 100, 150)  
                numLbl.TextScaled = true  
                numLbl.Font = Enum.Font.Gotham  
                numLbl.Parent = row  
                
                local iconLbl = Instance.new("TextLabel")  
                iconLbl.Size = UDim2.new(0, 30, 1, 0)  
                iconLbl.Position = UDim2.new(0, 35, 0, 0)  
                iconLbl.BackgroundTransparency = 1  
                iconLbl.Text = typeIcons[item.type] or "🔹"  
                iconLbl.TextColor3 = Color3.fromRGB(255, 255, 255)  
                iconLbl.TextScaled = true  
                iconLbl.Font = Enum.Font.Gotham  
                iconLbl.Parent = row  
                
                local nameLbl = Instance.new("TextLabel")  
                nameLbl.Size = UDim2.new(0.65, 0, 1, 0)  
                nameLbl.Position = UDim2.new(0, 70, 0, 0)  
                nameLbl.BackgroundTransparency = 1  
                nameLbl.Text = item.name  
                nameLbl.TextColor3 = Color3.fromRGB(220, 235, 255)  
                nameLbl.TextXAlignment = Enum.TextXAlignment.Left  
                nameLbl.TextScaled = true  
                nameLbl.Font = Enum.Font.Gotham  
                nameLbl.Parent = row  
                
                local typeLbl = Instance.new("TextLabel")  
                typeLbl.Size = UDim2.new(0, 80, 0, 16)  
                typeLbl.Position = UDim2.new(0.8, 0, 0.5, -8)  
                typeLbl.BackgroundTransparency = 1  
                typeLbl.Text = item.type  
                typeLbl.TextColor3 = typeColors[item.type] or Color3.fromRGB(150, 150, 200)  
                typeLbl.TextScaled = true  
                typeLbl.Font = Enum.Font.Gotham  
                typeLbl.Parent = row  
                
                y = y + h + 3  
            end  
        end  
        
        listFrame.CanvasSize = UDim2.new(0, 0, 0, y + 20)  
        statusText.Text = string.format("✅ Tổng: %d items | Loại: %s", #allItems, currentSort)  
        itemCount.Text = string.format("%d items", #allItems)  
    end  
end  

-- ===== REFRESH =====  
refreshBtn.MouseButton1Click:Connect(function()  
    statusText.Text = "🔄 Đang refresh..."  
    renderItems()  
    refreshBtn.Text = "✓"  
    wait(0.3)  
    refreshBtn.Text = "⟳"  
end)  

-- ===== TỰ ĐỘNG CHẠY =====  
renderItems()  

print("✅ Longmod Items Showcase đã tải thành công!")  
print("📌 Hiển thị 100% items trong acc")  