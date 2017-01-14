local useragent = {}

useragent.browser_patterns = {
    Edge      = {"Mobile.+Edge", "Edge"},
    Vivaldi   = {"Vivaldi"},
    Chrome    = {"CrMo", "CriOS", "Chrome%d+" },
    Dolfin    = {"Dolfin"},
    Opera     = {"Opera.+Mini", "Opera.+Mobi", "Opera.+OPR"},
    Skyfire   = {"Skyfire"},
    IE        = {"IEMobile", "MSIEMobile", "MSIE"},
    Firefox   = {"Mozilla.+Firefox"},
    Safari    = {"Version.+Safari"}
}

useragent.os_patterns = {
    Windows     =   {"(Windows)"}, 
    Android     =   {"(Android)"}, 
    Linux       =   {"(Linux)"}, 
    BlackBerry  =   {"(BlackBerry)"}, 
    iOS         =   {"(iPhone.+MacOS)", "(iPad.+MacOS)"},
    macOS   	=   {"(Macintosh)", "(MacOS)"}
}

useragent.mobile_patterns =  {"(Mobile)", "(iPhone)", "(iPod)", "(iPad)", "(Android)", "(BlackBerry)", "(IEMobile)", "(Kindle)", "(NetFront)", "(Silk-Accelerated)", "(Fennec)", "(Minimo)", "(Opera Mobil)", "(Opera Mini)", "(Blazer)", "(Dolfin)", "(Dolphin)", "(Skyfire)", "(Zune)" 	
}

function useragent.new(self, ua)
	if not ua or type(ua) ~= "string" then
		return 
	end

	useragent.ua_ = ua

    local is_mobile = false
    local browser, ua_os

    ua = ua:gsub('%W','')
    ua = ua:lower()

    for i, p in ipairs(self.mobile_patterns) do
            p = p:lower()
            local ok, m = pcall(function() return tostring(ua):match(p) end)
            if ok and m ~= nil then
                is_mobile = true
            end
    end

    local break_outer = false
    for k, p in pairs(self.os_patterns) do
    	if break_outer then
    		break
    	end

        if type(p) == "table" then
            for _, v_ in ipairs(p) do
                v_ = v_:lower()
                local ok, m = pcall(function() return tostring(ua):match(v_) end)
                if ok and m ~= nil then
                    ua_os = k
                    break_outer = true
                    break
                end
            end
        end
    end

    local break_outer = false
    for k, p in pairs(self.browser_patterns) do
    	if break_outer then
    		break
    	end

        if type(p) == "table" then
            for _, v_ in ipairs(p) do
                v_ = v_:lower()
                local ok, m = pcall(function() return tostring(ua):match(v_) end)
                if ok and m ~= nil then
                        browser = k
                        break_outer = true
                        break
                end
            end
        end
    end

    return {
    	["browser"] 	= 	browser, 
    	["os"] 			= 	ua_os, 
    	["is_mobile"] 	= 	is_mobile
    }
end

return useragent
