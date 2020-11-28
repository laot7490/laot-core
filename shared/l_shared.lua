LAOTShared = {}

LAOTShared.GetVersion = function()
	return C.Version
end

LAOTShared.GetConfigData = function(data)
	if C[data] then
		return C[data]
	else
		return "[".. data .."] isminde bir config verisi bulunamadı."
	end
end