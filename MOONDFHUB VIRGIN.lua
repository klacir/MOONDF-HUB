--[[
    ================================================================================
    MOONDF HUB - VERSÃO VIRGEM (SOMENTE CONFIGURAÇÃO)
    ================================================================================
]]

-- ==============================================================================
--  SERVICES
-- ==============================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- =========================
-- SISTEMA DE IDIOMA
-- =========================
local globalEnv = (typeof(getgenv) == "function" and getgenv()) or _G
globalEnv.CurrentLang = globalEnv.CurrentLang or "PT"
local CurrentLang = globalEnv.CurrentLang -- Padrão: Português

local TRANSLATIONS = {
    PT = {
        TITLE_MAIN = "MOONDF HUB",
        TOPIC_CONFIG = "Configuração",
        FOOTER_TEXT = "Right Ctrl ou use o botão para minimizar • Inputs: Immediate (OK) / Select (no OK)",
     
        -- Config
        LANG_LABEL = "Idioma / Language",
        LANG_DESC = "Altera todo o texto do menu",
        THEME_LABEL = "Tema / Theme",
        THEME_DESC = "Altera as cores da interface",
        OPACITY_LABEL = "Opacidade / Opacity",
        OPACITY_DESC = "Altera a transparência da janela",
    },
    EN = {
        TITLE_MAIN = "MOONDF HUB",
        TOPIC_CONFIG = "Settings",
        FOOTER_TEXT = "Right Ctrl or use button to minimize • Inputs: Immediate (OK) / Select (no OK)",
        
        LANG_LABEL = "Language / Idioma",
        LANG_DESC = "Changes all menu text",
        THEME_LABEL = "Theme / Tema",
        THEME_DESC = "Changes UI colors",
        OPACITY_LABEL = "Opacity / Opacidade",
        OPACITY_DESC = "Changes window transparency",
    }
}

local function T(key)
    return TRANSLATIONS[CurrentLang][key] or key
end

-- =========================
-- CONFIGURAÇÃO VISUAL & TEMAS
-- =========================
globalEnv.CurrentThemeName = globalEnv.CurrentThemeName or "Preto / Black"
local CurrentThemeName = globalEnv.CurrentThemeName
globalEnv.CurrentOpacity = globalEnv.CurrentOpacity or 0
local CurrentOpacity = globalEnv.CurrentOpacity
local DEFAULT_WIDTH = 760
local DEFAULT_HEIGHT = 520
local MIN_WIDTH = 420
local MIN_HEIGHT = 260
local RIGHT_AREA_SCALE = 0.33 

-- DEFINIÇÃO DOS TEMAS
local THEME_PRESETS = {
    ["Azul / Blue"] = {
        Background = Color3.fromRGB(15, 18, 25),
        PanelBg    = Color3.fromRGB(30, 35, 45),
        Text       = Color3.fromRGB(240, 245, 255),
        SubText    = Color3.fromRGB(150, 160, 180),
        Off        = Color3.fromRGB(50, 55, 65),
        On         = Color3.fromRGB(0, 160, 255),
        Border     = Color3.fromRGB(60, 100, 140),
        Hover      = Color3.fromRGB(45, 50, 60),
        Danger     = Color3.fromRGB(255, 60, 60),
        Accent     = Color3.fromRGB(0, 160, 255),
        KnobColor  = Color3.fromRGB(245, 245, 245) -- Bolinha Slider Padrão
    },
    ["Vermelho / Red"] = {
        Background = Color3.fromRGB(20, 10, 10),
        PanelBg    = Color3.fromRGB(40, 25, 25),
        Text       = Color3.fromRGB(255, 230, 230),
        SubText    = Color3.fromRGB(180, 140, 140),
        Off        = Color3.fromRGB(60, 40, 40),
        On         = Color3.fromRGB(220, 50, 50),
        Border     = Color3.fromRGB(120, 60, 60),
        Hover      = Color3.fromRGB(55, 30, 30),
        Danger     = Color3.fromRGB(255, 0, 0),
        Accent     = Color3.fromRGB(220, 50, 50),
        KnobColor  = Color3.fromRGB(245, 245, 245)
    },
    ["Amarelo / Yellow"] = {
        Background = Color3.fromRGB(25, 25, 20),
        PanelBg    = Color3.fromRGB(45, 45, 30),
        Text       = Color3.fromRGB(255, 255, 240),
        SubText    = Color3.fromRGB(180, 180, 150),
        Off        = Color3.fromRGB(75, 75, 50),
        On         = Color3.fromRGB(255, 200, 0),
        Border     = Color3.fromRGB(100, 100, 60),
        Hover      = Color3.fromRGB(55, 55, 40),
        Danger     = Color3.fromRGB(220, 60, 60),
        Accent     = Color3.fromRGB(255, 200, 0),
        KnobColor  = Color3.fromRGB(245, 245, 245)
    },
    ["Preto / Black"] = {
        Background = Color3.fromRGB(5, 5, 5),
        PanelBg    = Color3.fromRGB(25, 25, 25),
        Text       = Color3.fromRGB(220, 220, 220),
        SubText    = Color3.fromRGB(120, 120, 120),
        Off        = Color3.fromRGB(40, 40, 40),
        On         = Color3.fromRGB(100, 100, 100),
        Border     = Color3.fromRGB(70, 70, 70),
        Hover      = Color3.fromRGB(35, 35, 35),
        Danger     = Color3.fromRGB(150, 50, 50),
        Accent     = Color3.fromRGB(80, 80, 80), 
        KnobColor  = Color3.fromRGB(245, 245, 245)
    },
    ["Branco / White"] = {
        Background = Color3.fromRGB(255, 255, 255), -- Era PanelBg
        PanelBg    = Color3.fromRGB(235, 235, 240), -- Era Background
        Text       = Color3.fromRGB(30, 30, 35),
        SubText    = Color3.fromRGB(100, 100, 110),
        Off        = Color3.fromRGB(210, 210, 220),
        On         = Color3.fromRGB(40, 40, 40),
        Border     = Color3.fromRGB(180, 180, 190),
        Hover      = Color3.fromRGB(245, 245, 250),
        Danger     = Color3.fromRGB(255, 80, 80),
        Accent     = Color3.fromRGB(255, 255, 255), -- Barra escura para contraste
        KnobColor  = Color3.fromRGB(0, 0, 0)
    },
    ["Cinza / Gray"] = {
        Background = Color3.fromRGB(30, 30, 30),
        PanelBg    = Color3.fromRGB(48, 48, 48),
        Text       = Color3.fromRGB(200, 200, 200),
        SubText    = Color3.fromRGB(140, 140, 140),
        Off        = Color3.fromRGB(65, 65, 65),
        On         = Color3.fromRGB(130, 130, 130),
        Border     = Color3.fromRGB(90, 90, 90),
        Hover      = Color3.fromRGB(55, 55, 55),
        Danger     = Color3.fromRGB(100, 50, 50),
        Accent     = Color3.fromRGB(160, 160, 160),
        KnobColor  = Color3.fromRGB(245, 245, 245)
    }
}

-- Tema Inicial e Variáveis Globais
local THEME = {} 
-- Copia o tema inicial
for k,v in pairs(THEME_PRESETS[CurrentThemeName]) do THEME[k] = v end

-- CORES FIXAS POR TIPO
local TYPE_COLORS = {
    Label          = Color3.fromRGB(255, 255, 255), 
    Single         = Color3.fromRGB(0, 255, 128),   
    Toggle         = Color3.fromRGB(255, 50, 50),   
    Slider         = Color3.fromRGB(0, 170, 255),
    InputImmediate = Color3.fromRGB(170, 0, 255),   
    InputSelect    = Color3.fromRGB(200, 0, 255),   
    ListPersistent = Color3.fromRGB(255, 170, 0),   
    ListAuto       = Color3.fromRGB(255, 170, 0),   
    Container      = Color3.fromRGB(255, 255, 0)    
}

-- =========================
-- VARIÁVEIS DE ESTADO
-- =========================
globalEnv._HubStates = globalEnv._HubStates or {}
globalEnv._HubSelections = globalEnv._HubSelections or {}
globalEnv._ScriptHubStates = globalEnv._ScriptHubStates or {}

-- =========================
-- FUNÇÕES UTILITÁRIAS
-- =========================
local function new(class, props)
    local o = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" then pcall(function() o[k] = v end) end
        end
        if props.Parent then o.Parent = props.Parent end
    end
    return o
end

local function tween(inst, props, t, style, dir)
    local info = TweenInfo.new(t or 0.18, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local tw = TweenService:Create(inst, info, props)
    tw:Play()
    return tw
end

local function makeRound(inst, rad) return new("UICorner", {Parent = inst, CornerRadius = UDim.new(0, rad)}) end
local function makeStroke(inst, col, th) return new("UIStroke", {Parent = inst, Color = col or THEME.Border, Thickness = th or 1}) end
local function clamp(v, a, b) if v < a then return a end if v > b then return b end return v end

-- =========================
-- CRIAÇÃO DA JANELA PRINCIPAL
-- =========================

for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "MoonDF_VirginHub" then
        pcall(function() v:Destroy() end)
    end
end

local screenGui = new("ScreenGui", {Name = "MoonDF_VirginHub", Parent = CoreGui, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})

-- ==============================================================================
--  BOTÃO MINIMIZAR (MODIFICADO - TEXTO DF)
-- ==============================================================================
-- Agora é um TextButton, sem imagem
local miniButton = new("TextButton", { 
    Name = "MiniButton", 
    Parent = screenGui,
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.1, 0, 0.1, 0),
    BackgroundColor3 = THEME.Background,
    BackgroundTransparency = CurrentOpacity,
    Text = "DF", -- TEXTO DF
    TextColor3 = THEME.Accent,
    Font = Enum.Font.FredokaOne, -- FONTE GORDINHA
    TextSize = 24,
    Visible = false,
    AutoButtonColor = true
})
makeRound(miniButton, 12)
-- Sem borda ou com borda conforme tema (deixei borda no mini para visibilidade se fundo for igual)
local miniStroke = makeStroke(miniButton, THEME.Accent, 2) 

local root = new("Frame", {
    Name = "Root", Parent = screenGui,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, DEFAULT_WIDTH, 0, DEFAULT_HEIGHT),
    BackgroundColor3 = THEME.Background,
    BackgroundTransparency = CurrentOpacity,
    BorderSizePixel = 0,
    ClipsDescendants = true
})
makeRound(root, 10)
local rootStroke = makeStroke(root, THEME.Border, 2)

-- BARRA DE TÍTULO
local titleBar = new("Frame", {Parent = root, Size = UDim2.new(1, 0, 0, 42), BackgroundTransparency = 1})
local titleLabel = new("TextLabel", {
    Parent = titleBar, Position = UDim2.new(0, 12, 0, 8), Size = UDim2.new(1, -120, 1, -12),
    BackgroundTransparency = 1, Text = T("TITLE_MAIN"), TextColor3 = THEME.Text,
    Font = Enum.Font.GothamSemibold, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left
})

-- BOTÕES DE CONTROLE DA JANELA
local controlsContainer = new("Frame", {
    Parent = titleBar, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.new(0, 70, 0, 30), BackgroundTransparency = 1
})

local minBtn = new("TextButton", {
    Parent = controlsContainer, Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = Color3.fromRGB(50, 50, 55),
    Text = "-", TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold, TextSize = 18, BorderSizePixel = 0
})
makeRound(minBtn, 6)

local closeBtn = new("TextButton", {
    Parent = controlsContainer, Position = UDim2.new(0, 36, 0, 0),
    Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = THEME.Danger,
    Text = "X", 
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0
})
makeRound(closeBtn, 6)

-- PAINÉIS (LAYOUT)
local leftPane = new("Frame", {Parent = root, Position = UDim2.new(0, 10, 0, 56), Size = UDim2.new(0, 220, 1, -76), BackgroundTransparency = 1})
local rightPane = new("Frame", {Parent = root, Position = UDim2.new(0, 240, 0, 56), Size = UDim2.new(1, -250, 1, -76), BackgroundTransparency = 1})

-- MODIFICAÇÃO: Containers aplicam opacidade inicial
local leftBg = new("Frame", {Parent = leftPane, Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = THEME.Background, BorderSizePixel = 0, BackgroundTransparency = CurrentOpacity})
makeRound(leftBg, 8);
local leftStroke = makeStroke(leftBg, THEME.Border, 1)

local topicsList = new("ScrollingFrame", {Parent = leftBg, Position = UDim2.new(0, 8, 0, 8), Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,0)})
local topicsLayout = new("UIListLayout", {Parent = topicsList, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})

local rightBg = new("Frame", {Parent = rightPane, Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = THEME.Background, BorderSizePixel = 0, BackgroundTransparency = CurrentOpacity})
makeRound(rightBg, 8);
local rightStroke = makeStroke(rightBg, THEME.Border, 1)

local scroll = new("ScrollingFrame", {Parent = rightBg, Position = UDim2.new(0, 8, 0, 8), Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 1, ScrollBarThickness = 8, CanvasSize = UDim2.new(0,0,0,0)})
local buttonsLayout = new("UIListLayout", {Parent = scroll, Padding = UDim.new(0, 10)})
buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- RODAPÉ
local footer = new("TextLabel", {
    Parent = root, Position = UDim2.new(0, 12, 1, -28), Size = UDim2.new(1, -24, 0, 22),
    BackgroundTransparency = 1,
    Text = T("FOOTER_TEXT"),
    TextColor3 = THEME.SubText, Font = Enum.Font.Gotham, TextSize = 11
})

-- REDIMENSIONADOR
local resizer = new("Frame", {Parent = root, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 18, 0, 18), BackgroundTransparency = 1})
local resDot = new("Frame", {Parent = resizer, Size = UDim2.new(1, 1, 1, 1), BackgroundColor3 = THEME.Hover, BorderSizePixel = 0});
makeRound(resDot, 6)

-- =========================
-- CONTROLE DE VISIBILIDADE & LÓGICA MINIMIZAR
-- =========================
local hubVisible = true
local connections = {}

local function toggleHub()
    hubVisible = not hubVisible
    root.Visible = hubVisible
    miniButton.Visible = not hubVisible
end

-- =========================
-- DRAG SYSTEM (JANELA PRINCIPAL E MINI BUTTON)
-- =========================
do
    -- Lógica de arrastar Janela Principal
    local dragging, dragOffset = false, Vector2.new(0, 0)
    table.insert(connections, titleBar.InputBegan:Connect(function(input)
        if not hubVisible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local mp = input.Position or UserInputService:GetMouseLocation()
            dragOffset = Vector2.new(mp.X - root.AbsolutePosition.X, mp.Y - root.AbsolutePosition.Y)
        end
    end))
    table.insert(connections, UserInputService.InputChanged:Connect(function(input)
        if not dragging or not hubVisible then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local mp = input.Position or UserInputService:GetMouseLocation()
            local newX = mp.X - dragOffset.X + (root.AbsoluteSize.X * 0.5)
            local newY = mp.Y - dragOffset.Y + (root.AbsoluteSize.Y * 0.5)
            root.Position = UDim2.new(0, newX, 0, newY)
        end
    end))
    table.insert(connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end))

    -- Lógica de arrastar/clicar Botão Flutuante (MiniButton)
    local miniDragging, miniStartPos, miniDragStart = false, Vector2.new(0,0), Vector2.new(0,0)
    
    table.insert(connections, miniButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = true
            miniStartPos = Vector2.new(miniButton.AbsolutePosition.X, miniButton.AbsolutePosition.Y)
            local mp = input.Position
            miniDragStart = Vector2.new(mp.X, mp.Y)
        end
    end))
    
    table.insert(connections, UserInputService.InputChanged:Connect(function(input)
        if miniDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - Vector3.new(miniDragStart.X, miniDragStart.Y, 0)
            miniButton.Position = UDim2.new(0, miniStartPos.X + delta.X, 0, miniStartPos.Y + delta.Y)
        end
    end))
    
    table.insert(connections, miniButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = false
            local dist = (Vector2.new(input.Position.X, input.Position.Y) - miniDragStart).Magnitude
            if dist < 5 then
                toggleHub() 
            end
        end
    end))
end

-- Botão Minimizar
table.insert(connections, minBtn.MouseButton1Click:Connect(toggleHub))

-- Botão Fechar
table.insert(connections, closeBtn.MouseButton1Click:Connect(function()
    for _, conn in pairs(connections) do pcall(function() conn:Disconnect() end) end
    screenGui:Destroy()
end))

-- Keybind (Right Control)
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleHub()
    end
end))

-- Resize (Simplificado)
local resizing, startSize, startMouse = false, nil, nil
table.insert(connections, resizer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true; startSize = root.Size; local m = UserInputService:GetMouseLocation(); startMouse = Vector2.new(m.X, m.Y)
    end
end))
table.insert(connections, UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local m = UserInputService:GetMouseLocation()
        local d = Vector2.new(m.X, m.Y) - startMouse
        root.Size = UDim2.new(0, math.max(MIN_WIDTH, startSize.X.Offset + d.X), 0, math.max(MIN_HEIGHT, startSize.Y.Offset + d.Y))
    end
end))
table.insert(connections, UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end end))


-- =========================
-- FACTORY DE ELEMENTOS UI
-- =========================

local function createHamburger(parent)
    local icon = new("Frame", {Parent = parent, Size = UDim2.new(0, 28, 0, 20), BackgroundTransparency = 1})
    local barTop = new("Frame", {Parent = icon, Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0, 0, 0, 2), BackgroundColor3 = THEME.SubText, BorderSizePixel = 0});
    makeRound(barTop, 2)
    local barMid = new("Frame", {Parent = icon, Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0, 0, 0, 8.5), BackgroundColor3 = THEME.SubText, BorderSizePixel = 0});
    makeRound(barMid, 2)
    local barBot = new("Frame", {Parent = icon, Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0, 0, 0, 15), BackgroundColor3 = THEME.SubText, BorderSizePixel = 0});
    makeRound(barBot, 2)
    
    local function setOpen(val)
        if val then
            tween(barTop, {Position = UDim2.new(0, 0, 0, 8.5), Rotation = 45}, 0.18)
            tween(barMid, {BackgroundTransparency = 1}, 0.12)
            tween(barBot, {Position = UDim2.new(0, 0, 0, 8.5), Rotation = -45}, 0.18)
        else
            tween(barTop, {Position = UDim2.new(0, 0, 0, 2), Rotation = 0}, 0.18)
            tween(barMid, {BackgroundTransparency = 0}, 0.12)
            tween(barBot, {Position = UDim2.new(0, 0, 0, 15), Rotation = 0}, 0.18)
        end
    end
    return {Frame = icon, SetOpen = setOpen}
end

local function makeHoverAnimate(bg, rightScale)
    local hb = new("TextButton", {Parent = bg, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 1})
    hb.Size = UDim2.new(1, 0, 1, 0)
    table.insert(connections, hb.MouseEnter:Connect(function() if hubVisible then tween(bg, {BackgroundColor3 = THEME.Hover}, 0.12) end end))
    table.insert(connections, hb.MouseLeave:Connect(function() tween(bg, {BackgroundColor3 = THEME.PanelBg}, 0.12) end))
    return hb
end

local function refreshMainScroll()
    if scroll and scroll.Parent and buttonsLayout then
        scroll.CanvasSize = UDim2.new(0, 0, 0, buttonsLayout.AbsoluteContentSize.Y + 12)
    end
end

-- FUNÇÃO RECURSIVA PRINCIPAL PARA CRIAR BOTÕES
local function createEntry(params, parentFrame, depth, onChildrenChanged)
    depth = depth or 0
    local baseH = 60
    local barColor = params.Color or TYPE_COLORS[params.Type] or THEME.Accent

    local wrapper = new("Frame", {Parent = parentFrame, Name = "Entry", Size = UDim2.new(1, -12, 0, baseH), BackgroundTransparency = 1, ClipsDescendants = true})
    local entryObj = {Frame = wrapper}

    local bg = new("Frame", {
        Parent = wrapper, 
        Name = "ElementBackground", 
        Size = UDim2.new(1, 0, 0, baseH), 
        BackgroundColor3 = THEME.PanelBg, 
        BorderSizePixel = 0,
        BackgroundTransparency = CurrentOpacity
    })
    makeRound(bg, 8);
    local accent = new("Frame", {Parent = bg, Position = UDim2.new(0, 8 + depth * 12, 0.5, -18), Size = UDim2.new(0, 6, 0, 36), BackgroundColor3 = barColor})
    makeRound(accent, 6)

    local nameLabel = new("TextLabel", {
        Parent = bg, Position = UDim2.new(0, 28 + depth * 12, 0, 8), Size = UDim2.new(0.6, -28, 0, 20),
        BackgroundTransparency = 1, Text = params.Name or "Unnamed", TextColor3 = THEME.Text,
        Font = Enum.Font.GothamSemibold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })
    local descLabel = new("TextLabel", {
        Parent = bg, Position = UDim2.new(0, 28 + depth * 12, 0, 30), Size = UDim2.new(1, -164, 0, 18),
        BackgroundTransparency = 1, Text = params.Description or "", TextColor3 = THEME.SubText,
        Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local rightArea = new("Frame", {
        Parent = bg, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.new(RIGHT_AREA_SCALE, -12, 0, 44), BackgroundTransparency = 1, ZIndex = 5
    })

    local childrenContainer = new("Frame", {Parent = wrapper, Position = UDim2.new(0, 0, 0, baseH), Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, ClipsDescendants = true})
    local childrenHolder = new("Frame", {Parent = childrenContainer, Position = UDim2.new(0, 8, 0, 8), Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 1})
    local childrenLayout = new("UIListLayout", {Parent = childrenHolder, Padding = UDim.new(0, 8), VerticalAlignment = Enum.VerticalAlignment.Top})
    
    local hoverBox = makeHoverAnimate(bg, RIGHT_AREA_SCALE)

    local expanded = false
    local childRefs = {}

    local function expandTo(height)
        tween(wrapper, {Size = UDim2.new(1, -12, 0, baseH + height)}, 0.18)
        tween(childrenContainer, {Size = UDim2.new(1, 0, 0, height)}, 0.18)
        task.defer(function() 
            if onChildrenChanged then onChildrenChanged() end 
            refreshMainScroll() 
        end)
    end

    local function collapse()
        expandTo(0)
        expanded = false
    end

    table.insert(connections, childrenLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if expanded then
            local newTarget = childrenLayout.AbsoluteContentSize.Y + 12
            expandTo(newTarget)
        end
    end))

    local function buildChildren(list)
        for _, c in pairs(childRefs) do if c and c.Frame then c.Frame:Destroy() end end
        childRefs = {}
        for _, childParam in ipairs(list or {}) do
            local child = createEntry(childParam, childrenHolder, depth + 1, function()
                if expanded then
                    local newTarget = childrenLayout.AbsoluteContentSize.Y + 12
                    expandTo(newTarget)
                end
            end)
            table.insert(childRefs, child)
        end
        task.wait() 
        local target = childrenLayout.AbsoluteContentSize.Y + 12
        expandTo(target)
        expanded = true
    end

    -- LOGICA POR TIPO
    if params.Type == "Label" then
        -- Visual apenas

    elseif params.Type == "Toggle" then
        local state = false
        if params.StateKey then state = globalEnv._HubStates[params.StateKey] or false end
        local knob = new("Frame", {Parent = rightArea, Size = UDim2.new(0, 46, 0, 26), Position = UDim2.new(1, -46, 0.5, -13), BackgroundColor3 = THEME.Off});
        makeRound(knob, 14)
        local subKnob = new("Frame", {Parent = knob, Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 4, 0, 4), BackgroundColor3 = Color3.new(1, 1, 1)});
        makeRound(subKnob, 999)
        local function applyVisual(s)
            if s then
                tween(knob, {BackgroundColor3 = THEME.On}, 0.15)
                tween(subKnob, {Position = UDim2.new(1, -22, 0, 4)}, 0.15)
                
                if CurrentThemeName == "Preto / Black" then
                     tween(bg, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.15)
                end
            else
                tween(knob, {BackgroundColor3 = THEME.Off}, 0.15)
                tween(subKnob, {Position = UDim2.new(0, 4, 0, 4)}, 0.15)
                
                tween(bg, {BackgroundColor3 = THEME.PanelBg}, 0.15)
            end
        end
        local function applyState(s)
            state = s
            if params.StateKey then globalEnv._HubStates[params.StateKey] = state end
            applyVisual(state)
            if state then
                if params.OnEnable then pcall(params.OnEnable) end
            else
                if params.OnDisable then pcall(params.OnDisable) end
            end
        end
        applyVisual(state)
        table.insert(connections, hoverBox.MouseButton1Click:Connect(function() if hubVisible then applyState(not state) end end))

    elseif params.Type == "Single" then
        table.insert(connections, hoverBox.MouseButton1Click:Connect(function()
            if hubVisible then
                tween(bg, {BackgroundColor3 = THEME.Hover}, 0.06);
                task.wait(0.06); tween(bg, {BackgroundColor3 = THEME.PanelBg}, 0.12)
                if params.Callback then pcall(params.Callback) end
            end
        end))

    elseif params.Type == "InputImmediate" then
        local txtBox = new("TextBox", {Parent = rightArea, Size = UDim2.new(1, -76, 0, 28), Position = UDim2.new(0, 0, 0.5, -14), BackgroundColor3 = THEME.Background, Text = "", PlaceholderText = params.Placeholder or "...", TextColor3 = THEME.Text, Font = Enum.Font.Gotham, TextSize = 14, ClearTextOnFocus = false, ZIndex = 6});
        makeRound(txtBox, 6)
        
        -- Botão OK Centralizado
        local okBtn = new("TextButton", {
            Parent = rightArea, 
            AnchorPoint = Vector2.new(1, 0.5), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            Size = UDim2.new(0, 68, 0, 28), 
            BackgroundColor3 = THEME.Accent, -- [MODIFICADO] No tema preto, Accent agora é cinza
            Text = "OK", 
            TextColor3 = Color3.new(1, 1, 1), 
            Font = Enum.Font.GothamBold, 
            TextSize = 14, 
            ZIndex = 6
        })
        makeRound(okBtn, 6)
        
        table.insert(connections, okBtn.MouseButton1Click:Connect(function() if hubVisible and params.Callback then params.Callback(txtBox.Text) end end))
        table.insert(connections, txtBox.FocusLost:Connect(function(enter) if enter and hubVisible and params.Callback then params.Callback(txtBox.Text) end end))

    elseif params.Type == "InputSelect" then
        local txtBox = new("TextBox", {Parent = rightArea, Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 0.5, -14), BackgroundColor3 = THEME.Background, Text = params.Default or "", PlaceholderText = params.Placeholder or "...", TextColor3 = THEME.Text, Font = Enum.Font.Gotham, TextSize = 14, ClearTextOnFocus = true, ZIndex = 6});
        makeRound(txtBox, 6)
        table.insert(connections, txtBox.FocusLost:Connect(function() if params.StateKey then globalEnv._HubSelections[params.StateKey] = txtBox.Text end end))

    elseif params.Type == "ListAuto" or params.Type == "Container" then
        local ham = createHamburger(rightArea)
        ham.Frame.Position = UDim2.new(1, -28, 0, 8)
        table.insert(connections, hoverBox.MouseButton1Click:Connect(function()
            if not hubVisible then return end
            if not expanded then
                buildChildren(params.Options or params.Children or {})
                ham.SetOpen(true)
            else
                collapse()
                ham.SetOpen(false)
            end
        end))

    elseif params.Type == "ListPersistent" then
        local ham = createHamburger(rightArea)
        ham.Frame.Position = UDim2.new(1, -28, 0, 8)
        local selectedValLabel = new("TextLabel", {Parent = bg, BackgroundTransparency = 1, TextColor3 = THEME.Text, Font = Enum.Font.GothamSemibold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, Text = "", ZIndex = 2})
        
        local function updateSelectedLabelPos()
            local bounds = nameLabel.TextBounds
            selectedValLabel.Position = UDim2.new(0, 28 + depth * 12 + bounds.X + 4, 0, 8)
            selectedValLabel.Size = UDim2.new(0, 200, 0, 20)
        end
        updateSelectedLabelPos()
        nameLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSelectedLabelPos)

        if params.StateKey then
            local storedVal = globalEnv._HubSelections[params.StateKey]
            if storedVal then
                selectedValLabel.Text = ": " .. storedVal
                updateSelectedLabelPos()
            end
        end

        table.insert(connections, hoverBox.MouseButton1Click:Connect(function()
            if not hubVisible then return end
            if not expanded then
                local opts = {}
                for _, opt in ipairs(params.Options or {}) do
                    local customColor = nil
                    if THEME_PRESETS[opt] then customColor = THEME_PRESETS[opt].Accent end
                    
                    table.insert(opts, {
                        Type = "Single", Name = opt, Description = "", Color = customColor,
                        Callback = function()
                            selectedValLabel.Text = ": " .. opt
                            updateSelectedLabelPos()
                            if params.StateKey then globalEnv._HubSelections[params.StateKey] = opt end
                            if params.Callback then params.Callback(opt) end
                            collapse()
                            ham.SetOpen(false)
                        end
                    })
                end
                buildChildren(opts)
                ham.SetOpen(true)
            else
                collapse()
                ham.SetOpen(false)
            end
        end))

    elseif params.Type == "Slider" or params.Type == "Intensity" then
        local minV = tonumber(params.Min) or 0
        local maxV = tonumber(params.Max) or 100
        if maxV < minV then maxV = minV end
        local step = params.Step and tonumber(params.Step) or nil
        local key = params.StateKey or params.Name or ("Slider_"..tostring(math.random(100000,999999)))
        
        local cur = globalEnv._ScriptHubStates[key] ~= nil and globalEnv._ScriptHubStates[key] or (params.Default ~= nil and tonumber(params.Default) or minV)
        cur = clamp(math.floor(cur + 0.5), minV, maxV)
        local track = new("Frame", {Parent = rightArea, Size = UDim2.new(1, -28, 0, 8), Position = UDim2.new(0, 8, 0.5, -4), BackgroundColor3 = THEME.Off, BorderSizePixel = 0})
        makeRound(track, 6)
        local fill = new("Frame", {Parent = track, Size = UDim2.new(0,0,1,0), Position = UDim2.new(0,0,0,0), BackgroundColor3 = THEME.Accent, BorderSizePixel = 0})
        makeRound(fill, 6)
        local knob = new("Frame", {Parent = rightArea, Size = UDim2.new(0,16,0,16), Position = UDim2.new(0,8,0.5,-8), BackgroundColor3 = (THEME.KnobColor or Color3.fromRGB(245,245,245)), BorderSizePixel = 0})
        makeRound(knob, 999)
        knob.Active = true; knob.ClipsDescendants = true
        local valLabel = new("TextLabel", {Parent = rightArea, AnchorPoint = Vector2.new(1,0.5), Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.new(0, 52, 0, 18), BackgroundTransparency = 1, Text = tostring(cur), TextColor3 = THEME.SubText, Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right})
        track.Active = true
        fill.Active = true
        local function updateVisuals(instant)
            local pct = 0
            if maxV > minV then pct = (cur - minV) / (maxV - minV) end
            local trackW = math.max(0, track.AbsoluteSize.X)
            local maxTrackW = math.max(60, trackW)
            local fillW = math.floor(maxTrackW * pct + 0.5)
            local knobX = math.floor(8 + fillW - (knob.AbsoluteSize.X / 2) + 0.5)
            
            if instant then
                fill.Size = UDim2.new(0, fillW, 1, 0)
                knob.Position = UDim2.new(0, knobX, 0.5, -8)
            else
                tween(fill, {Size = UDim2.new(0, fillW, 1, 0)}, 0.12)
                tween(knob, {Position = UDim2.new(0, knobX, 0.5, -8)}, 0.12)
            end
            valLabel.Text = tostring(cur)
        end
        local function fireChange()
            globalEnv._ScriptHubStates[key] = cur
            if params.OnChange then
                pcall(function() params.OnChange(cur) end)
            end
        end
        local function xToValue(absX)
            local tx = track.AbsolutePosition.X
            local tw = track.AbsoluteSize.X
            if tw <= 0 then return cur end
            local rel = (absX - tx) / math.max(1, tw)
            rel = clamp(rel, 0, 1)
            local raw = minV + (rel * (maxV - minV))
            if step and step > 0 then
                raw = math.floor((raw / step) + 0.5) * step
            end
            return clamp(math.floor(raw + 0.5), minV, maxV)
        end
        table.insert(connections, track:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() updateVisuals(true) end))
        task.defer(function() updateVisuals(true) end)
        local dragging = false
        local dragConnChanged, dragConnEnded
        table.insert(connections, knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragConnChanged = UserInputService.InputChanged:Connect(function(inp)
                    if not dragging then return end
                    if inp.UserInputType == Enum.UserInputType.MouseMovement then
                        local v = xToValue(inp.Position.X)
                        if v ~= cur then
                            cur = v
                            updateVisuals(false)
                            fireChange()
                        end
                    end
                end)
                dragConnEnded = UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        if dragConnChanged then dragConnChanged:Disconnect(); dragConnChanged = nil end
                        if dragConnEnded then dragConnEnded:Disconnect(); dragConnEnded = nil end
                    end
                end)
                table.insert(connections, dragConnChanged); table.insert(connections, dragConnEnded)
            end
        end))
        table.insert(connections, track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos = (input.Position and input.Position.X) or UserInputService:GetMouseLocation().X
                local v = xToValue(pos)
                if v ~= cur then
                    cur = v
                    updateVisuals(false)
                    fireChange()
                end
            end
        end))
        table.insert(connections, fill.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos = (input.Position and input.Position.X) or UserInputService:GetMouseLocation().X
                local v = xToValue(pos)
                if v ~= cur then
                    cur = v
                    updateVisuals(false)
                    fireChange()
                end
            end
        end))
        valLabel.Active = true
        entryObj.Get = function() return cur end
        entryObj.Set = function(v)
            cur = clamp(math.floor(tonumber(v) or minV + 0.5), minV, maxV)
            updateVisuals(false)
            fireChange()
        end
    end

    return entryObj
end

-- =========================
-- GERENCIADOR DE TÓPICOS
-- =========================
local togglesCreated = {}
local initTopics -- Declaração antecipada

local function addTopic(name, items)
    local btn = new("TextButton", {
        Parent = topicsList, 
        Size = UDim2.new(1, 0, 0, 42), 
        BackgroundColor3 = THEME.PanelBg, 
        BorderSizePixel = 0, 
        Text = name, 
        TextColor3 = THEME.Text, 
        Font = Enum.Font.Gotham, 
        TextSize = 14,
        BackgroundTransparency = CurrentOpacity
    })
    makeRound(btn, 8)
    
    table.insert(connections, btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = THEME.Hover}, 0.12) end))
    table.insert(connections, btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = THEME.PanelBg}, 0.12) end))
    
    table.insert(connections, btn.MouseButton1Click:Connect(function()
        if not hubVisible then return end
        for _, c in pairs(scroll:GetChildren()) do if c:IsA("Frame") and c.Name == "Entry" then c:Destroy() end end
        
        togglesCreated[name] = togglesCreated[name] or {}
        for _, it in ipairs(items) do
            createEntry(it, scroll, 0)
        end
        refreshMainScroll()
    end))
end

-- =========================
-- LAYOUT RESPONSIVO
-- =========================
local function updateLayout()
    local totalW = root.AbsoluteSize.X
    local leftWidth = math.clamp(math.floor(totalW * 0.26), 140, 320)
    leftWidth = math.min(leftWidth, math.max(120, totalW - 220))
    
    leftPane.Size = UDim2.new(0, leftWidth, 1, -80)
    local rightX = leftWidth + 20
    rightPane.Position = UDim2.new(0, rightX, 0, 56)
    rightPane.Size = UDim2.new(0, totalW - rightX - 10, 1, -80)
    
    refreshMainScroll()
end
table.insert(connections, root:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout))
table.insert(connections, topicsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    topicsList.CanvasSize = UDim2.new(0, 0, 0, topicsLayout.AbsoluteContentSize.Y + 12)
end))
table.insert(connections, buttonsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshMainScroll))

task.defer(updateLayout)

-- =========================
-- ATUALIZAÇÃO VISUAL DE TEMA ESTÁTICO
-- =========================
local function refreshStaticUI()
    -- Atualiza Frames Base
    root.BackgroundColor3 = THEME.Background
    leftBg.BackgroundColor3 = THEME.Background 
    rightBg.BackgroundColor3 = THEME.Background
    miniButton.BackgroundColor3 = THEME.Background
    miniButton.BackgroundTransparency = CurrentOpacity
    
    -- MODIFICAÇÃO: Atualiza cores do Botão DF
    miniButton.TextColor3 = THEME.Accent
    miniStroke.Color = THEME.Accent
    
    -- Atualiza Textos
    titleLabel.TextColor3 = THEME.Text
    footer.TextColor3 = THEME.SubText
    
    -- Atualiza Bordas (Strokes)
    rootStroke.Color = THEME.Border
    leftStroke.Color = THEME.Border
    rightStroke.Color = THEME.Border
end

-- =========================
-- INICIALIZAÇÃO
-- =========================

function initTopics()
    -- Limpa lista lateral
    for _, v in pairs(topicsList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    -- Limpa conteúdo principal
    for _, c in pairs(scroll:GetChildren()) do 
        if c:IsA("Frame") and c.Name == "Entry" then c:Destroy() end 
    end
    
    -- Atualiza textos globais e cores
    refreshStaticUI()
    titleLabel.Text = T("TITLE_MAIN")
    footer.Text = T("FOOTER_TEXT")

    -- =========================
    -- TÓPICO: CONFIGURAÇÃO
    -- =========================
    addTopic(T("TOPIC_CONFIG"), {
        -- Seletor de Idioma
        {
            Type = "ListPersistent",
            Name = T("LANG_LABEL"),
            Description = T("LANG_DESC"),
            StateKey = "LanguageSelection",
            Options = {"Português", "English"},
            Callback = function(val)
                local oldLang = CurrentLang
                CurrentLang = (val == "English") and "EN" or "PT"
                globalEnv.CurrentLang = CurrentLang
                if oldLang ~= CurrentLang then
                    initTopics()
                end
            end
        },
        -- Seletor de Temas
        {
            Type = "ListPersistent",
            Name = T("THEME_LABEL") .. " [" .. CurrentThemeName .. "]",
            Description = T("THEME_DESC"),
            StateKey = "ThemeSelection",
            Options = {"Azul / Blue", "Vermelho / Red", "Amarelo / Yellow", "Preto / Black", "Branco / White", "Cinza / Gray"},
            Callback = function(val)
                if THEME_PRESETS[val] then
                    CurrentThemeName = val
                    globalEnv.CurrentThemeName = val
                    for k,v in pairs(THEME_PRESETS[val]) do
                        THEME[k] = v
                    end
                    initTopics()
                end
            end
        },
        -- Slider de Opacidade
        {
            Type = "Slider",
            StateKey = "OpacityValue",
            Name = T("OPACITY_LABEL"),
            Description = T("OPACITY_DESC"),
            Min = 0, Max = 100, Default = (1 - CurrentOpacity) * 100, 
            OnChange = function(val)
                local transp = 1 - (val / 100)
                CurrentOpacity = transp
                globalEnv.CurrentOpacity = transp
                
                -- Aplica no background principal
                root.BackgroundTransparency = transp
                leftBg.BackgroundTransparency = transp
                rightBg.BackgroundTransparency = transp
                miniButton.BackgroundTransparency = transp
                
                for _, desc in pairs(screenGui:GetDescendants()) do
                    if desc:IsA("Frame") and desc.Name == "ElementBackground" or desc:IsA("TextButton") and desc.Parent == topicsList then
                        desc.BackgroundTransparency = transp
                    end
                end
            end
        }
    })
end

-- Inicialização
initTopics()
