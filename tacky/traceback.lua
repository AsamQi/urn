if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, _, _, env) local f, e = loadstring(x); if not f then error(e, 1) end; return setfenv(f, env) end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _temp = (function()
	return {
		['slice'] = function(xs, start, finish)
			if not finish then finish = xs.n end
			if not finish then finish = #xs end
			return { tag = "list", n = finish - start + 1, table.unpack(xs, start, finish) }
		end,
	}
end)()
for k, v in pairs(_temp) do _libs["lua/basic-0/".. k] = v end
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _25_1, error1, getIdx1, setIdx_21_1, tonumber1, type_23_1, _23_1, char1, find1, format1, gsub1, len1, lower1, match1, sub1, concat1, emptyStruct1, iterPairs1, list1, list_3f_1, key_3f_1, between_3f_1, type1, nth1, pushCdr_21_1, charAt1, _2e2e_1, struct1, succ1, huge1, unmangleIdent1, remapError1, remapMessage1, remapTraceback1, generateMappings1
_3d_1 = function(v1, v2) return (v1 == v2) end
_2f3d_1 = function(v1, v2) return (v1 ~= v2) end
_3c_1 = function(v1, v2) return (v1 < v2) end
_3c3d_1 = function(v1, v2) return (v1 <= v2) end
_3e_1 = function(v1, v2) return (v1 > v2) end
_3e3d_1 = function(v1, v2) return (v1 >= v2) end
_2b_1 = function(v1, v2) return (v1 + v2) end
_2d_1 = function(v1, v2) return (v1 - v2) end
_25_1 = function(v1, v2) return (v1 % v2) end
error1 = error
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
tonumber1 = tonumber
type_23_1 = type
_23_1 = (function(x1)
	return x1["n"]
end)
char1 = string.char
find1 = string.find
format1 = string.format
gsub1 = string.gsub
len1 = string.len
lower1 = string.lower
match1 = string.match
sub1 = string.sub
concat1 = table.concat
emptyStruct1 = function() return {} end
iterPairs1 = function(x, f) for k, v in pairs(x) do f(k, v) end end
list1 = (function(...)
	local xs1 = _pack(...) xs1.tag = "list"
	return xs1
end)
list_3f_1 = (function(x2)
	return (type1(x2) == "list")
end)
key_3f_1 = (function(x3)
	return (type1(x3) == "key")
end)
between_3f_1 = (function(val1, min1, max1)
	local r_201 = (val1 >= min1)
	if r_201 then
		return (val1 <= max1)
	else
		return r_201
	end
end)
type1 = (function(val2)
	local ty1 = type_23_1(val2)
	if (ty1 == "table") then
		local tag1 = val2["tag"]
		if tag1 then
			return tag1
		else
			return "table"
		end
	else
		return ty1
	end
end)
nth1 = (function(xs2, idx1)
	return xs2[idx1]
end)
pushCdr_21_1 = (function(xs3, val3)
	local r_441 = type1(xs3)
	if (r_441 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "xs", "list", r_441), 2)
	else
	end
	local len2 = (_23_1(xs3) + 1)
	xs3["n"] = len2
	xs3[len2] = val3
	return xs3
end)
charAt1 = (function(xs4, x4)
	return sub1(xs4, x4, x4)
end)
_2e2e_1 = (function(...)
	local args1 = _pack(...) args1.tag = "list"
	return concat1(args1)
end)
struct1 = (function(...)
	local keys1 = _pack(...) keys1.tag = "list"
	if ((_23_1(keys1) % 1) == 1) then
		error1("Expected an even number of arguments to struct", 2)
	else
	end
	local contents1 = (function(key1)
		return key1["contents"]
	end)
	local out1 = {}
	local r_721 = _23_1(keys1)
	local r_701 = nil
	r_701 = (function(r_711)
		if (r_711 <= r_721) then
			local key2 = keys1[r_711]
			local val4 = keys1[(1 + r_711)]
			out1[(function()
				if key_3f_1(key2) then
					return contents1(key2)
				else
					return key2
				end
			end)()
			] = val4
			return r_701((r_711 + 2))
		else
		end
	end)
	r_701(1)
	return out1
end)
succ1 = (function(x5)
	return (x5 + 1)
end)
huge1 = math.huge
unmangleIdent1 = (function(ident1)
	local esc1 = match1(ident1, "^(.-)%d+$")
	if (esc1 == nil) then
		return ident1
	elseif (sub1(esc1, 1, 2) == "_e") then
		return sub1(ident1, 3)
	else
		local buffer1 = {tag = "list", n = 0}
		local pos1 = 0
		local len3 = len1(esc1)
		local r_1591 = nil
		r_1591 = (function()
			if (pos1 <= len3) then
				local char2 = charAt1(esc1, pos1)
				if (char2 == "_") then
					local r_1601 = list1(find1(esc1, "^_[%da-z]+_", pos1))
					local temp1
					local r_1621 = list_3f_1(r_1601)
					if r_1621 then
						local r_1631 = (_23_1(r_1601) == 2)
						if r_1631 then
							temp1 = true
						else
							temp1 = r_1631
						end
					else
						temp1 = r_1621
					end
					if temp1 then
						local start1 = nth1(r_1601, 1)
						local _eend1 = nth1(r_1601, 2)
						pos1 = (pos1 + 1)
						local r_1661 = nil
						r_1661 = (function()
							if (pos1 < _eend1) then
								pushCdr_21_1(buffer1, char1(tonumber1(sub1(esc1, pos1, succ1(pos1)), 16)))
								pos1 = (pos1 + 2)
								return r_1661()
							else
							end
						end)
						r_1661()
					else
						pushCdr_21_1(buffer1, "_")
					end
				elseif between_3f_1(char2, "A", "Z") then
					pushCdr_21_1(buffer1, "-")
					pushCdr_21_1(buffer1, lower1(char2))
				else
					pushCdr_21_1(buffer1, char2)
				end
				pos1 = (pos1 + 1)
				return r_1591()
			else
			end
		end)
		r_1591()
		return concat1(buffer1)
	end
end)
remapError1 = (function(msg1)
	local res1
	local r_1451
	local r_1441
	local r_1431
	r_1431 = gsub1(msg1, "local '([^']+)'", (function(x6)
		return _2e2e_1("local '", unmangleIdent1(x6), "'")
	end))
	r_1441 = gsub1(r_1431, "global '([^']+)'", (function(x7)
		return _2e2e_1("global '", unmangleIdent1(x7), "'")
	end))
	r_1451 = gsub1(r_1441, "upvalue '([^']+)'", (function(x8)
		return _2e2e_1("upvalue '", unmangleIdent1(x8), "'")
	end))
	res1 = gsub1(r_1451, "function '([^']+)'", (function(x9)
		return _2e2e_1("function '", unmangleIdent1(x9), "'")
	end))
	return res1
end)
remapMessage1 = (function(mappings1, msg2)
	local r_1461 = list1(match1(msg2, "^(.-):(%d+)(.*)$"))
	local temp2
	local r_1481 = list_3f_1(r_1461)
	if r_1481 then
		local r_1491 = (_23_1(r_1461) == 3)
		if r_1491 then
			temp2 = true
		else
			temp2 = r_1491
		end
	else
		temp2 = r_1481
	end
	if temp2 then
		local file1 = nth1(r_1461, 1)
		local line1 = nth1(r_1461, 2)
		local extra1 = nth1(r_1461, 3)
		local mapping1 = mappings1[file1]
		if mapping1 then
			local range1 = mapping1[tonumber1(line1)]
			if range1 then
				return _2e2e_1(range1, " (", file1, ":", line1, ")", remapError1(extra1))
			else
				return msg2
			end
		else
			return msg2
		end
	else
		return msg2
	end
end)
remapTraceback1 = (function(mappings2, msg3)
	local r_1581
	local r_1571
	local r_1561
	local r_1551
	local r_1541
	local r_1531
	r_1531 = gsub1(msg3, "^([^\n:]-:%d+:[^\n]*)", (function(r_1651)
		return remapMessage1(mappings2, r_1651)
	end))
	r_1541 = gsub1(r_1531, "\9([^\n:]-:%d+:)", (function(msg4)
		return _2e2e_1("\9", remapMessage1(mappings2, msg4))
	end))
	r_1551 = gsub1(r_1541, "<([^\n:]-:%d+)>\n", (function(msg5)
		return _2e2e_1("<", remapMessage1(mappings2, msg5), ">\n")
	end))
	r_1561 = gsub1(r_1551, "in local '([^']+)'\n", (function(x10)
		return _2e2e_1("in local '", unmangleIdent1(x10), "'\n")
	end))
	r_1571 = gsub1(r_1561, "in global '([^']+)'\n", (function(x11)
		return _2e2e_1("in global '", unmangleIdent1(x11), "'\n")
	end))
	r_1581 = gsub1(r_1571, "in upvalue '([^']+)'\n", (function(x12)
		return _2e2e_1("in upvalue '", unmangleIdent1(x12), "'\n")
	end))
	return gsub1(r_1581, "in function '([^']+)'\n", (function(x13)
		return _2e2e_1("in function '", unmangleIdent1(x13), "'\n")
	end))
end)
generateMappings1 = (function(lines1)
	local outLines1 = {}
	iterPairs1(lines1, (function(line2, ranges1)
		local rangeLists1 = {}
		iterPairs1(ranges1, (function(pos2)
			local file2 = pos2["name"]
			local rangeList1 = rangeLists1["file"]
			if rangeList1 then
			else
				rangeList1 = struct1("n", 0, "min", huge1, "max", (0 - huge1))
				rangeLists1[file2] = rangeList1
			end
			local r_1691 = pos2["finish"]["line"]
			local r_1671 = nil
			r_1671 = (function(r_1681)
				if (r_1681 <= r_1691) then
					if rangeList1[r_1681] then
					else
						rangeList1["n"] = succ1(rangeList1["n"])
						rangeList1[r_1681] = true
						if (r_1681 < rangeList1["min"]) then
							rangeList1["min"] = r_1681
						else
						end
						if (r_1681 > rangeList1["max"]) then
							rangeList1["max"] = r_1681
						else
						end
					end
					return r_1671((r_1681 + 1))
				else
				end
			end)
			return r_1671(pos2["start"]["line"])
		end))
		local bestName1 = nil
		local bestLines1 = nil
		local bestCount1 = 0
		iterPairs1(rangeLists1, (function(name1, lines2)
			if (lines2["n"] > bestCount1) then
				bestName1 = name1
				bestLines1 = lines2
				bestCount1 = lines2["n"]
				return nil
			else
			end
		end))
		outLines1[line2] = (function()
			if (bestLines1["min"] == bestLines1["max"]) then
				return format1("%s:%d", bestName1, bestLines1["min"])
			else
				return format1("%s:%d-%d", bestName1, bestLines1["min"], bestLines1["max"])
			end
		end)()
		return nil
	end))
	return outLines1
end)
return struct1("remapMessage", remapMessage1, "remapTraceback", remapTraceback1, "generate", generateMappings1)