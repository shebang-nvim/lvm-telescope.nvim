local utils = {}

utils.only_1st_elem = function(t)
	local r = {}
	for index, value in ipairs(t) do
		if value[1] then
			r[index] = value[1]
		end
	end
	return r
end

return utils
