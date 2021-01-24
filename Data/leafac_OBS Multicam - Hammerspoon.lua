local reaperObsMulticam = hs.hotkey.modal.new({"⌘", "⇧"}, "2")

function reaperObsMulticam:entered()
    hs.http.get(
        "http://localhost:8080/_/_RSa8097198b5ba34eafff45805c1727ed4e42baeb6")
    reaperObsMulticam.menubar = hs.menubar.new():setTitle("Recording")
end

reaperObsMulticam:bind({"⌥", "⌃"}, "M", function()
    hs.http.get("http://localhost:8080/_/40157")
    local title = reaperObsMulticam.menubar:title()
    reaperObsMulticam.menubar:setTitle("Marker")
    hs.timer.doAfter(0.5,
                     function() reaperObsMulticam.menubar:setTitle(title) end)
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "1", function()
    hs.http.get(
        "http://localhost:8080/_/_RS0ef00f2c7fa13a89a670ae0ceebab188f76bdb39")
    reaperObsMulticam.menubar:setTitle("Camera 1")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "2", function()
    hs.http.get(
        "http://localhost:8080/_/_RS03c9eeea5a76cf51ebdf036cfc01c627d8814dbf")
    reaperObsMulticam.menubar:setTitle("Camera 2")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "3", function()
    hs.http.get(
        "http://localhost:8080/_/_RS309d84519b55ca7bf4054c61375ddc0c9af0c7d2")
    reaperObsMulticam.menubar:setTitle("Camera 3")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "4", function()
    hs.http.get(
        "http://localhost:8080/_/_RSd61147b2cb175b462459e920c43c47922bcbeaf5")
    reaperObsMulticam.menubar:setTitle("Camera 4")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "5", function()
    hs.http.get(
        "http://localhost:8080/_/_RSf7a6434cba550ccea54620a8eb54f8fe8b15fb4a")
    reaperObsMulticam.menubar:setTitle("Camera 5")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "6", function()
    hs.http.get(
        "http://localhost:8080/_/_RSd181fc45c40415430229c90e2098b0201080e7cf")
    reaperObsMulticam.menubar:setTitle("Camera 6")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "7", function()
    hs.http.get(
        "http://localhost:8080/_/_RS5c7bd5fd6591d41d07934f325d89a954ce896c15")
    reaperObsMulticam.menubar:setTitle("Camera 7")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "8", function()
    hs.http.get(
        "http://localhost:8080/_/_RS4dd6dba7ceb01a5ca98db81f84cb543bd3ef1fe9")
    reaperObsMulticam.menubar:setTitle("Camera 8")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "9", function()
    hs.http.get(
        "http://localhost:8080/_/_RSbbcb3f707773d86dacdbe2a23b5dbd6e58e78794")
    reaperObsMulticam.menubar:setTitle("Camera 9")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "0", function()
    hs.http.get(
        "http://localhost:8080/_/_RS83cb04c1a64bc2becdb617e9995a58728b2bd3a7")
    reaperObsMulticam.menubar:setTitle("Camera 10")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "Q", function()
    hs.http.get(
        "http://localhost:8080/_/_RS70f0424d175c375cff0726eae5cc0788f4c52dbf")
    reaperObsMulticam.menubar:setTitle("Camera 11")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "W", function()
    hs.http.get(
        "http://localhost:8080/_/_RSbb947ec2c5867decf3ad6893c4afb09990c4dc57")
    reaperObsMulticam.menubar:setTitle("Camera 12")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "E", function()
    hs.http.get(
        "http://localhost:8080/_/_RS3af7a0db7641863fc23faabf0964d399d95384bc")
    reaperObsMulticam.menubar:setTitle("Camera 13")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "R", function()
    hs.http.get(
        "http://localhost:8080/_/_RS25544e4cfca7af5865d2d929f7254036f88d7d8d")
    reaperObsMulticam.menubar:setTitle("Camera 14")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "T", function()
    hs.http.get(
        "http://localhost:8080/_/_RS4d2a25441ed9ab295f4656d9e6606769e72dcff4")
    reaperObsMulticam.menubar:setTitle("Camera 15")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "Y", function()
    hs.http.get(
        "http://localhost:8080/_/_RS13ad69a754e1b2ce4c8b487407ed467c0dc6485e")
    reaperObsMulticam.menubar:setTitle("Camera 16")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "U", function()
    hs.http.get(
        "http://localhost:8080/_/_RSd7657dd83ff59c64a76028afd498ddf8a4973d8c")
    reaperObsMulticam.menubar:setTitle("Camera 17")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "I", function()
    hs.http.get(
        "http://localhost:8080/_/_RSae2b190f73dc105c0c206c81d79fa5f76e326d3f")
    reaperObsMulticam.menubar:setTitle("Camera 18")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "O", function()
    hs.http.get(
        "http://localhost:8080/_/_RS495cefc2082749b6a946f7e61fec5bb53c43c712")
    reaperObsMulticam.menubar:setTitle("Camera 19")
end)

reaperObsMulticam:bind({"⌥", "⌃"}, "P", function()
    hs.http.get(
        "http://localhost:8080/_/_RSd88747e2c0774748ec25c30afc3e392eecb68c9d")
    reaperObsMulticam.menubar:setTitle("Camera 20")
end)

reaperObsMulticam:bind({"⌘", "⇧"}, "2",
                       function() reaperObsMulticam:exit() end)

function reaperObsMulticam:exited()
    hs.http.get(
        "http://localhost:8080/_/_RS40031326265963e3606b3fd8fc73993a6243a2da")
    reaperObsMulticam.menubar:delete()
    reaperObsMulticam.menubar = nil
end
