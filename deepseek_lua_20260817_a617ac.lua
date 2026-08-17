-- Longmod Hub - Mini Mode (Thu nhỏ giao diện)  
-- Giữ nguyên chức năng, giảm kích thước 40%  

local player = game:GetService("Players").LocalPlayer  
local playerGui = player:WaitForChild("PlayerGui")  

-- Xóa GUI cũ nếu có  
local oldGui = playerGui:FindFirstChild("LongmodHub")  
if oldGui then oldGui:Destroy() end  

local screenGui = Instance.new("ScreenGui")  
screenGui.Name = "LongmodHub"  
screenGui.ResetOnSpawn = false  
screenGui.Parent = playerGui  

-- ==== FRAME CHÍNH - THU NHỎ ====  
local mainFrame = Instance.new("Frame")  
mainFrame.Size = UDim2.new(0, 320, 0, 400)  -- Từ 480x580 xuống 320x400  
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)  
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)  
mainFrame.BackgroundTransparency = 0.15  
mainFrame.BorderSizePixel = 2  
mainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)  
mainFrame.Active = true  
mainFrame.Draggable = true  
mainFrame.Parent = screenGui  

-- ==== TIÊU ĐỀ - THU NHỎ ====  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1, 0, 0, 32)  -- Từ 45 xuống 32  
title.BackgroundColor3 = Color3.fromRGB(10, 10, 25)  
title.Text = "LONGMOD HUB"  
title.TextColor3 = Color3.fromRGB(0, 220, 255)  
title.TextScaled = true  
title.Font = Enum.Font.GothamBold  
title.Parent = mainFrame  

-- ==== NÚT TOGGLE - THU NHỎ ====  
local toggleBtn = Instance.new("TextButton")  
toggleBtn.Size = UDim2.new(0.8, 0, 0, 32)  -- Từ 42 xuống 32  
toggleBtn.Position = UDim2.new(0.1, 0, 0.1, 5)  
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)  
toggleBtn.Text = "▶ BẬT"  
toggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100)  
toggleBtn.TextScaled = true  
toggleBtn.Font = Enum.Font.GothamBold  
toggleBtn.Parent = mainFrame  

-- ==== KHUNG DANH SÁCH - THU NHỎ ====  
local listFrame = Instance.new("ScrollingFrame")  
listFrame.Size = UDim2.new(0.92, 0, 0.6, 0)  -- Từ 0.65 xuống 0.6  
listFrame.Position = UDim2.new(0.04, 0, 0.24, 0)  
listFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 18)  
listFrame.BackgroundTransparency = 0.4  
listFrame.BorderSizePixel = 1  
listFrame.BorderColor3 = Color3.fromRGB(0, 150, 210)  
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  
listFrame.ScrollBarThickness = 5  
listFrame.Parent = mainFrame  

-- ==== NÚT THU NHỎ THÊM (TỐI ƯU) ====  
local miniBtn = Instance.new("TextButton")  
miniBtn.Size = UDim2.new(0, 24, 0, 24)  
miniBtn.Position = UDim2.new(0.9, 0, 0.01, 2)  
miniBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)  
miniBtn.BorderSizePixel = 1  
miniBtn.BorderColor3 = Color3.fromRGB(150, 150, 200)  
miniBtn.Text = "─"  
miniBtn.TextColor3 = Color3.fromRGB(200, 200, 255)  
miniBtn.TextScaled = true  
miniBtn.Font = Enum.Font.GothamBold  
miniBtn.Parent = mainFrame  

local isMinimized = false  

miniBtn.MouseButton1Click:Connect(function()  
    isMinimized = not isMinimized  
    if isMinimized then  
        mainFrame.Size = UDim2.new(0, 100, 0, 40)  
        mainFrame.Position = UDim2.new(0.85, 0, 0.1, 0)  
        title.Text = "📌"  
        title.TextScaled = true  
        toggleBtn.Visible = false  
        listFrame.Visible = false  
        miniBtn.Text = "□"  
        miniBtn.Position = UDim2.new(0.7, 0, 0.1, 2)  
    else  
        mainFrame.Size = UDim2.new(0, 320, 0, 400)  
        mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)  
        title.Text = "LONGMOD HUB"  
        toggleBtn.Visible = true  
        listFrame.Visible = true  
        miniBtn.Text = "─"  
        miniBtn.Position = UDim2.new(0.9, 0, 0.01, 2)  
    end  
end)  

-- ==== HÀM LẤY ITEMS (GIỮ NGUYÊN) ====  
local function getAllItems()  
    local items = {}  
    local checked = {}  

    local bp = player:FindFirstChild("Backpack")  
    if bp then  
        for _, child in pairs(bp:GetChildren()) do  
            if child:IsA("Tool") and not checked[child.Name] then  
                table.insert(items, {name = child.Name, type = "BP", color = Color3.fromRGB(100, 200, 255)})  
                checked[child.Name] = true  
            end  
        end  
    end  

    local sg = player:FindFirstChild("StarterGear")  
    if sg then  
        for _, child in pairs(sg:GetChildren()) do  
            if child:IsA("Tool") and not checked[child.Name] then  
                table.insert(items, {name = child.Name, type = "SG", color = Color3.fromRGB(255, 200, 100)})  
                checked[child.Name] = true  
            end  
        end  
    end  

    local char = player.Character  
    if char then  
        for _, child in pairs(char:GetChildren()) do  
            if child:IsA("Tool") and not checked[child.Name] then  
                table.insert(items, {name = child.Name, type = "EQ", color = Color3.fromRGB(100, 255, 150)})  
                checked[child.Name] = true  
            end  
        end  
    end  

    local inv = player:FindFirstChild("Inventory")  
    if inv then  
        for _, child in pairs(inv:GetChildren()) do  
            if (child:IsA("Tool") or child:IsA("Folder") or child:IsA("Model")) and not checked[child.Name] then  
                table.insert(items, {name = child.Name, type = "INV", color = Color3.fromRGB(200, 100, 255)})  
                checked[child.Name] = true  
            end  
        end  
    end  

    return items  
end  

-- ==== HÀM HIỂN THỊ (THU NHỎ TEXT) ====  
local function showItems()  
    for _, child in pairs(listFrame:GetChildren()) do  
        child:Destroy()  
    end  

    local items = getAllItems()  
    local yOff = 3  
    local h = 20  -- Từ 26 xuống 20  

    if #items == 0 then  
        local empty = Instance.new("TextLabel")  
        empty.Size = UDim2.new(1, -10, 0, 30)  
        empty.Position = UDim2.new(0, 5, 0, 5)  
        empty.BackgroundTransparency = 1  
        empty.Text = "⚠️ KHÔNG CÓ ITEM"  
        empty.TextColor3 = Color3.fromRGB(255, 100, 100)  
        empty.TextScaled = true  
        empty.Font = Enum.Font.GothamBold  
        empty.Parent = listFrame  
        listFrame.CanvasSize = UDim2.new(0, 0, 0, 40)  
    else  
        for i, item in ipairs(items) do  
            local lbl = Instance.new("TextLabel")  
            lbl.Size = UDim2.new(1, -10, 0, h)  
            lbl.Position = UDim2.new(0, 5, 0, yOff)  
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 40)  
            lbl.BackgroundTransparency = 0.3  
            lbl.BorderSizePixel = 1  
            lbl.BorderColor3 = item.color  
            lbl.Text = string.format("[%s] %s", item.type, item.name)  
            lbl.TextColor3 = Color3.fromRGB(220, 235, 255)  
            lbl.TextXAlignment = Enum.TextXAlignment.Left  
            lbl.TextScaled = true  
            lbl.Font = Enum.Font.Gotham  
            lbl.Parent = listFrame  
            yOff = yOff + h + 2  
        end  
        listFrame.CanvasSize = UDim2.new(0, 0, 0, yOff + 10)  
    end  
end  

-- ==== TOGGLE SHOWCASE ====  
local showActive = false  

toggleBtn.MouseButton1Click:Connect(function()  
    showActive = not showActive  
    if showActive then  
        toggleBtn.Text = "⏹ TẮT"  
        toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)  
        showItems()  
    else  
        toggleBtn.Text = "▶ BẬT"  
        toggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100)  
        for _, child in pairs(listFrame:GetChildren()) do  
            child:Destroy()  
        end  
    end  
end)  

-- Tự động bật sẵn  
showActive = true  
toggleBtn.Text = "⏹ TẮT"  
toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)  
showItems()  

print("[Longmod] Mini Mode đã kích hoạt!")  