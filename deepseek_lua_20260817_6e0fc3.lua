-- Longmod Hub - Lite Edition (Tối giản + Mượt mà)  
-- Performance tối ưu, giảm lag, load nhanh  

local player = game:GetService("Players").LocalPlayer  
local playerGui = player:WaitForChild("PlayerGui")  
local tween = game:GetService("TweenService")  
local run = game:GetService("RunService")  

-- Xóa GUI cũ  
local old = playerGui:FindFirstChild("LongmodHub")  
if old then old:Destroy() end  

local gui = Instance.new("ScreenGui")  
gui.Name = "LongmodHub"  
gui.ResetOnSpawn = false  
gui.Parent = playerGui  

-- ===== BẢNG MÀU =====  
local theme = {  
    main = Color3.fromRGB(0, 200, 255),  
    dark = Color3.fromRGB(0, 100, 180),  
    bg = Color3.fromRGB(10, 30, 50),  
    text = Color3.fromRGB(255, 255, 255)  
}  

-- ===== HÀM TWEEN NHANH =====  
local function quickTween(obj, props, time)  
    tween:Create(obj, TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()  
end  

-- ===== MENU CHÍNH (GỌN NHẸ) =====  
local frame = Instance.new("Frame")  
frame.Size = UDim2.new(0, 360, 0, 460)  
frame.Position = UDim2.new(0.5, -180, 0.5, -230)  
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 28)  
frame.BackgroundTransparency = 0.1  
frame.BorderSizePixel = 2  
frame.BorderColor3 = theme.main  
frame.ClipsDescendants = true  
frame.Active = true  
frame.Draggable = true  
frame.Parent = gui  

-- Header gọn  
local header = Instance.new("Frame")  
header.Size = UDim2.new(1, 0, 0, 45)  
header.BackgroundColor3 = theme.dark  
header.BackgroundTransparency = 0.4  
header.BorderSizePixel = 0  
header.Parent = frame  

local title = Instance.new("TextLabel")  
title.Size = UDim2.new(0.6, 0, 1, 0)  
title.Position = UDim2.new(0, 15, 0, 0)  
title.BackgroundTransparency = 1  
title.Text = "⚡ LONGMOD"  
title.TextColor3 = theme.text  
title.TextScaled = true  
title.TextXAlignment = Enum.TextXAlignment.Left  
title.Font = Enum.Font.GothamBold  
title.Parent = header  

-- Nút đóng  
local close = Instance.new("TextButton")  
close.Size = UDim2.new(0, 28, 0, 28)  
close.Position = UDim2.new(1, -38, 0, 8)  
close.BackgroundTransparency = 0.5  
close.BorderSizePixel = 1  
close.BorderColor3 = Color3.fromRGB(255, 80, 80)  
close.Text = "✕"  
close.TextColor3 = Color3.fromRGB(255, 80, 80)  
close.TextScaled = true  
close.Font = Enum.Font.GothamBold  
close.Parent = header  

close.MouseButton1Click:Connect(function() gui:Destroy() end)  

-- Nút thu nhỏ  
local mini = Instance.new("TextButton")  
mini.Size = UDim2.new(0, 28, 0, 28)  
mini.Position = UDim2.new(1, -72, 0, 8)  
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
        quickTween(frame, {Size = UDim2.new(0, 100, 0, 45), Position = UDim2.new(0.85, 0, 0.1, 0)}, 0.3)  
        title.Text = "⚡"  
        close.Visible = false  
        mini.Text = "□"  
        mini.Position = UDim2.new(1, -38, 0, 8)  
    else  
        quickTween(frame, {Size = UDim2.new(0, 360, 0, 460), Position = UDim2.new(0.5, -180, 0.5, -230)}, 0.3)  
        title.Text = "⚡ LONGMOD"  
        close.Visible = true  
        mini.Text = "─"  
        mini.Position = UDim2.new(1, -72, 0, 8)  
    end  
end)  

-- ===== CONTENT =====  
local content = Instance.new("Frame")  
content.Size = UDim2.new(1, -20, 1, -65)  
content.Position = UDim2.new(0, 10, 0, 55)  
content.BackgroundTransparency = 1  
content.Parent = frame  

-- Nút toggle  
local toggle = Instance.new("TextButton")  
toggle.Size = UDim2.new(1, 0, 0, 38)  
toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 55)  
toggle.BackgroundTransparency = 0.2  
toggle.BorderSizePixel = 2  
toggle.BorderColor3 = theme.main  
toggle.Text = "▶ HIỂN THỊ"  
toggle.TextColor3 = theme.text  
toggle.TextScaled = true  
toggle.Font = Enum.Font.GothamBold  
toggle.Parent = content  

-- Danh sách  
local list = Instance.new("ScrollingFrame")  
list.Size = UDim2.new(1, 0, 1, -48)  
list.Position = UDim2.new(0, 0, 0, 45)  
list.BackgroundColor3 = Color3.fromRGB(8, 8, 20)  
list.BackgroundTransparency = 0.3  
list.BorderSizePixel = 1  
list.BorderColor3 = theme.dark  
list.ScrollBarThickness = 5  
list.ScrollBarImageColor3 = theme.main  
list.CanvasSize = UDim2.new(0, 0, 0, 0)  
list.Parent = content  

-- ===== HÀM LẤY ITEMS (NHANH) =====  
local function getItems()  
    local items = {}  
    local checked = {}  
    
    local check = function(container)  
        if container then  
            for _, c in pairs(container:GetChildren()) do  
                if c:IsA("Tool") and not checked[c.Name] then  
                    table.insert(items, {name = c.Name, color = Color3.fromRGB(100, 200, 255)})  
                    checked[c.Name] = true  
                end  
            end  
        end  
    end  
    
    check(player:FindFirstChild("Backpack"))  
    check(player:FindFirstChild("StarterGear"))  
    if player.Character then check(player.Character) end  
    return items  
end  

-- ===== HIỂN THỊ (CÓ HIỆU ỨNG MƯỢT) =====  
local function showItems()  
    for _, c in pairs(list:GetChildren()) do c:Destroy() end  
    
    local items = getItems()  
    local y = 4  
    local h = 26  
    
    if #items == 0 then  
        local empty = Instance.new("TextLabel")  
        empty.Size = UDim2.new(1, -10, 0, 40)  
        empty.Position = UDim2.new(0, 5, 0, 15)  
        empty.BackgroundTransparency = 1  
        empty.Text = "✨ KHÔNG CÓ ITEM"  
        empty.TextColor3 = Color3.fromRGB(150, 150, 200)  
        empty.TextScaled = true  
        empty.Font = Enum.Font.Gotham  
        empty.Parent = list  
        list.CanvasSize = UDim2.new(0, 0, 0, 70)  
    else  
        table.sort(items, function(a,b) return a.name < b.name end)  
        
        for i, item in ipairs(items) do  
            local row = Instance.new("Frame")  
            row.Size = UDim2.new(1, -10, 0, h)  
            row.Position = UDim2.new(0, 5, 0, y)  
            row.BackgroundColor3 = Color3.fromRGB(20, 20, 45)  
            row.BackgroundTransparency = 0.15  
            row.BorderSizePixel = 1  
            row.BorderColor3 = item.color  
            row.Parent = list  
            
            local lbl = Instance.new("TextLabel")  
            lbl.Size = UDim2.new(1, -10, 1, 0)  
            lbl.Position = UDim2.new(0, 5, 0, 0)  
            lbl.BackgroundTransparency = 1  
            lbl.Text = string.format("#%02d %s", i, item.name)  
            lbl.TextColor3 = Color3.fromRGB(220, 235, 255)  
            lbl.TextXAlignment = Enum.TextXAlignment.Left  
            lbl.TextScaled = true  
            lbl.Font = Enum.Font.Gotham  
            lbl.Parent = row  
            
            y = y + h + 3  
        end  
        list.CanvasSize = UDim2.new(0, 0, 0, y + 10)  
    end  
end  

-- ===== TOGGLE =====  
local active = false  

toggle.MouseButton1Click:Connect(function()  
    active = not active  
    if active then  
        toggle.Text = "⏹ ẨN"  
        toggle.BorderColor3 = Color3.fromRGB(255, 100, 100)  
        toggle.BackgroundColor3 = Color3.fromRGB(40, 15, 15)  
        showItems()  
    else  
        toggle.Text = "▶ HIỂN THỊ"  
        toggle.BorderColor3 = theme.main  
        toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 55)  
        for _, c in pairs(list:GetChildren()) do c:Destroy() end  
    end  
end)  

-- Tự động bật  
active = true  
toggle.Text = "⏹ ẨN"  
toggle.BorderColor3 = Color3.fromRGB(255, 100, 100)  
toggle.BackgroundColor3 = Color3.fromRGB(40, 15, 15)  
showItems()  

-- ===== THÊM CHỨC NĂNG SHOWCASE FLOATING =====  
local showcaseBtn = Instance.new("TextButton")  
showcaseBtn.Size = UDim2.new(0.5, 0, 0, 30)  
showcaseBtn.Position = UDim2.new(0.5, 5, 0, 0)  
showcaseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 70)  
showcaseBtn.BackgroundTransparency = 0.2  
showcaseBtn.BorderSizePixel = 1  
showcaseBtn.BorderColor3 = Color3.fromRGB(150, 100, 255)  
showcaseBtn.Text = "📷 CỬA SỔ"  
showcaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)  
showcaseBtn.TextScaled = true  
showcaseBtn.Font = Enum.Font.Gotham  
showcaseBtn.Parent = content  
showcaseBtn.Visible = false  

-- Tạo cửa sổ showcase đơn giản  
local function openShowcase()  
    local sg = Instance.new("ScreenGui")  
    sg.Name = "ShowcaseWin"  
    sg.ResetOnSpawn = false  
    sg.Parent = playerGui  
    
    local win = Instance.new("Frame")  
    win.Size = UDim2.new(0, 600, 0, 400)  
    win.Position = UDim2.new(0.2, 0, 0.2, 0)  
    win.BackgroundColor3 = Color3.fromRGB(15, 15, 30)  
    win.BackgroundTransparency = 0.1  
    win.BorderSizePixel = 2  
    win.BorderColor3 = Color3.fromRGB(150, 100, 255)  
    win.Active = true  
    win.Draggable = true  
    win.Parent = sg  
    
    local hdr = Instance.new("TextLabel")  
    hdr.Size = UDim2.new(1, 0, 0, 35)  
    hdr.BackgroundColor3 = Color3.fromRGB(30, 20, 50)  
    hdr.Text = "📷 SHOWCASE ITEMS"  
    hdr.TextColor3 = Color3.fromRGB(255, 255, 255)  
    hdr.TextScaled = true  
    hdr.Font = Enum.Font.GothamBold  
    hdr.Parent = win  
    
    local sc = Instance.new("ScrollingFrame")  
    sc.Size = UDim2.new(1, -20, 1, -55)  
    sc.Position = UDim2.new(0, 10, 0, 45)  
    sc.BackgroundColor3 = Color3.fromRGB(8, 8, 20)  
    sc.BackgroundTransparency = 0.3  
    sc.BorderSizePixel = 1  
    sc.BorderColor3 = Color3.fromRGB(100, 80, 150)  
    sc.ScrollBarThickness = 6  
    sc.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)  
    sc.CanvasSize = UDim2.new(0, 0, 0, 0)  
    sc.Parent = win  
    
    local cls = Instance.new("TextButton")  
    cls.Size = UDim2.new(0, 30, 0, 30)  
    cls.Position = UDim2.new(1, -38, 0, 2)  
    cls.BackgroundTransparency = 0.5  
    cls.BorderSizePixel = 1  
    cls.BorderColor3 = Color3.fromRGB(255, 80, 80)  
    cls.Text = "✕"  
    cls.TextColor3 = Color3.fromRGB(255, 80, 80)  
    cls.TextScaled = true  
    cls.Font = Enum.Font.GothamBold  
    cls.Parent = win  
    cls.MouseButton1Click:Connect(function() sg:Destroy() end)  
    
    local items = getItems()  
    local y = 5  
    local h = 28  
    
    for i, item in ipairs(items) do  
        local row = Instance.new("Frame")  
        row.Size = UDim2.new(1, -10, 0, h)  
        row.Position = UDim2.new(0, 5, 0, y)  
        row.BackgroundColor3 = Color3.fromRGB(20, 20, 45)  
        row.BackgroundTransparency = 0.15  
        row.BorderSizePixel = 1  
        row.BorderColor3 = Color3.fromRGB(100, 200, 255)  
        row.Parent = sc  
        
        local lbl = Instance.new("TextLabel")  
        lbl.Size = UDim2.new(1, -10, 1, 0)  
        lbl.Position = UDim2.new(0, 5, 0, 0)  
        lbl.BackgroundTransparency = 1  
        lbl.Text = string.format("🖼️ %s", item.name)  
        lbl.TextColor3 = Color3.fromRGB(220, 235, 255)  
        lbl.TextXAlignment = Enum.TextXAlignment.Left  
        lbl.TextScaled = true  
        lbl.Font = Enum.Font.Gotham  
        lbl.Parent = row  
        
        y = y + h + 3  
    end  
    sc.CanvasSize = UDim2.new(0, 0, 0, y + 10)  
end  

showcaseBtn.MouseButton1Click:Connect(openShowcase)  

-- Kích hoạt nút showcase khi toggle  
toggle.MouseButton1Click:Connect(function()  
    showcaseBtn.Visible = active  
end)  
if active then showcaseBtn.Visible = true end  

print("⚡ Longmod Hub Lite - Đã sẵn sàng!")  