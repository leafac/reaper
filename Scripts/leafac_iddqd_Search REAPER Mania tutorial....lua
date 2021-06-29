local continue, search = reaper.GetUserInputs("Search REAPER Mania tutorial", 1,
                                              "Search:,extrawidth=100", "")

if not continue or search == "" then return end

if reaper.CF_ShellExecute == nil then
    reaper.MB("Go install SWS!",
              "“Crawl out of the dark ages!”\n—Aaron Cendan", 0)
    return
end

reaper.CF_ShellExecute("https://www.youtube.com/c/REAPERMania/search?query=" ..
                           string.gsub(search, "[^%w]", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
