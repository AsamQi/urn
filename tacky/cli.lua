#!/usr/bin/env lua
if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then error(e, 2) end if env then setfenv(f, env) end return f end end
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
local _temp = (function()
	-- A horrible hacky script to ensure that package.path is correct
	local directory = arg[0]:gsub("\\", "/"):gsub("urn/cli%.lisp", ""):gsub("urn/cli$", ""):gsub("tacky/cli%.lua$", "")
	if directory ~= "" and directory:sub(-1, -1) ~= "/" then
		directory = directory .. "/"
	end
	package.path = package.path .. package.config:sub(3, 3) .. directory .. "?.lua"
	return {}
end)()
for k, v in pairs(_temp) do _libs["urn/cli-16/".. k] = v end
local _ENV = setmetatable({}, {__index=ENV or (getfenv and getfenv()) or _G}) if setfenv then setfenv(0, _ENV) end
_3d_1 = function(v1, v2) return (v1 == v2) end
_2f3d_1 = function(v1, v2) return (v1 ~= v2) end
_3c_1 = function(v1, v2) return (v1 < v2) end
_3c3d_1 = function(v1, v2) return (v1 <= v2) end
_3e_1 = function(v1, v2) return (v1 > v2) end
_3e3d_1 = function(v1, v2) return (v1 >= v2) end
_2b_1 = function(v1, v2) return (v1 + v2) end
_2d_1 = function(v1, v2) return (v1 - v2) end
_2a_1 = function(v1, v2) return (v1 * v2) end
_2f_1 = function(v1, v2) return (v1 / v2) end
_25_1 = function(v1, v2) return (v1 % v2) end
_2e2e_1 = function(v1, v2) return (v1 .. v2) end
_5f_G1 = _G
arg_23_1 = arg
len_23_1 = function(v1) return #(v1) end
slice1 = _libs["lua/basic-0/slice"]
error1 = error
getmetatable1 = getmetatable
load1 = load
pcall1 = pcall
print1 = print
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
require1 = require
setmetatable1 = setmetatable
tonumber1 = tonumber
tostring1 = tostring
type_23_1 = type
xpcall1 = xpcall
byte1 = string.byte
char1 = string.char
find1 = string.find
format1 = string.format
gsub1 = string.gsub
len1 = string.len
lower1 = string.lower
match1 = string.match
rep1 = string.rep
sub1 = string.sub
upper1 = string.upper
concat1 = table.concat
remove1 = table.remove
sort1 = table.sort
unpack1 = table.unpack
iterPairs1 = function(x, f) for k, v in pairs(x) do f(k, v) end end
list1 = (function(...)
	local xs1 = _pack(...) xs1.tag = "list"
	return xs1
end)
cons1 = (function(x1, xs2)
	return (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_result[1 + _offset] = x1
		_temp = xs2
		for _c = 1, _temp.n do _result[1 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 1
		return _result
	end)()
end)
_2d_or1 = (function(a1, b1)
	return (a1 or b1)
end)
pretty1 = (function(value1)
	local ty1 = type_23_1(value1)
	if (ty1 == "table") then
		local tag1 = value1["tag"]
		if (tag1 == "list") then
			local out1 = ({tag = "list", n = 0})
			local r_51 = value1["n"]
			local r_31 = nil
			r_31 = (function(r_41)
				if (r_41 <= r_51) then
					out1[r_41] = pretty1(value1[r_41])
					return r_31((r_41 + 1))
				else
				end
			end)
			r_31(1)
			return ("(" .. (concat1(out1, " ") .. ")"))
		elseif ((type_23_1(getmetatable1(value1)) == "table") and (type_23_1(getmetatable1(value1)["--pretty-print"]) == "function")) then
			return getmetatable1(value1)["--pretty-print"](value1)
		elseif (tag1 == "list") then
			return value1["contents"]
		elseif (tag1 == "symbol") then
			return value1["contents"]
		elseif (tag1 == "key") then
			return (":" .. value1["value"])
		elseif (tag1 == "string") then
			return format1("%q", value1["value"])
		elseif (tag1 == "number") then
			return tostring1(value1["value"])
		else
			local out2 = ({tag = "list", n = 0})
			iterPairs1(value1, (function(k1, v1)
				out2 = cons1((pretty1(k1) .. (" " .. pretty1(v1))), out2)
				return nil
			end))
			return ("{" .. (concat1(out2, " ") .. "}"))
		end
	elseif (ty1 == "string") then
		return format1("%q", value1)
	else
		return tostring1(value1)
	end
end)
if (nil == arg_23_1) then
	arg1 = ({tag = "list", n = 0})
else
	arg_23_1["tag"] = "list"
	if arg_23_1["n"] then
	else
		arg_23_1["n"] = #(arg_23_1)
	end
	arg1 = arg_23_1
end
constVal1 = (function(val1)
	if (type_23_1(val1) == "table") then
		local tag2 = val1["tag"]
		if (tag2 == "number") then
			return val1["value"]
		elseif (tag2 == "string") then
			return val1["value"]
		else
			return val1
		end
	else
		return val1
	end
end)
empty_3f_1 = (function(x2)
	local xt1 = type1(x2)
	if (xt1 == "list") then
		return (x2["n"] == 0)
	elseif (xt1 == "string") then
		return (#(x2) == 0)
	else
		return false
	end
end)
string_3f_1 = (function(x3)
	return ((type_23_1(x3) == "string") or ((type_23_1(x3) == "table") and (x3["tag"] == "string")))
end)
number_3f_1 = (function(x4)
	return ((type_23_1(x4) == "number") or ((type_23_1(x4) == "table") and (x4["tag"] == "number")))
end)
atom_3f_1 = (function(x5)
	return ((type_23_1(x5) ~= "table") or ((type_23_1(x5) == "table") and ((x5["tag"] == "symbol") or (x5["tag"] == "key"))))
end)
between_3f_1 = (function(val2, min1, max1)
	return ((val2 >= min1) and (val2 <= max1))
end)
type1 = (function(val3)
	local ty2 = type_23_1(val3)
	if (ty2 == "table") then
		return (val3["tag"] or "table")
	else
		return ty2
	end
end)
eq_3f_1 = (function(x6, y1)
	if (x6 == y1) then
		return true
	else
		local typeX1 = type1(x6)
		local typeY1 = type1(y1)
		if ((typeX1 == "list") and ((typeY1 == "list") and (x6["n"] == y1["n"]))) then
			local equal1 = true
			local r_291 = x6["n"]
			local r_271 = nil
			r_271 = (function(r_281)
				if (r_281 <= r_291) then
					if not eq_3f_1(x6[r_281], (y1[r_281])) then
						equal1 = false
					end
					return r_271((r_281 + 1))
				else
				end
			end)
			r_271(1)
			return equal1
		elseif (("symbol" == typeX1) and ("symbol" == typeY1)) then
			return (x6["contents"] == y1["contents"])
		elseif (("key" == typeX1) and ("key" == typeY1)) then
			return (x6["value"] == y1["value"])
		elseif (("symbol" == typeX1) and ("string" == typeY1)) then
			return (x6["contents"] == y1)
		elseif (("string" == typeX1) and ("symbol" == typeY1)) then
			return (x6 == y1["contents"])
		elseif (("key" == typeX1) and ("string" == typeY1)) then
			return (x6["value"] == y1)
		elseif (("string" == typeX1) and ("key" == typeY1)) then
			return (x6 == y1["value"])
		else
			return false
		end
	end
end)
abs1 = math.abs
huge1 = math.huge
max2 = math.max
min2 = math.min
modf1 = math.modf
car1 = (function(x7)
	local r_571 = type1(x7)
	if (r_571 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", r_571), 2)
	end
	return x7[1]
end)
cdr1 = (function(x8)
	local r_581 = type1(x8)
	if (r_581 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", r_581), 2)
	end
	if empty_3f_1(x8) then
		return ({tag = "list", n = 0})
	else
		return slice1(x8, 2)
	end
end)
foldr1 = (function(f1, z1, xs3)
	local r_591 = type1(f1)
	if (r_591 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "f", "function", r_591), 2)
	end
	local r_601 = type1(xs3)
	if (r_601 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_601), 2)
	end
	local accum1 = z1
	local r_631 = xs3["n"]
	local r_611 = nil
	r_611 = (function(r_621)
		if (r_621 <= r_631) then
			accum1 = f1(accum1, xs3[r_621])
			return r_611((r_621 + 1))
		else
		end
	end)
	r_611(1)
	return accum1
end)
map1 = (function(fn1, ...)
	local xss1 = _pack(...) xss1.tag = "list"
	local lenghts1
	local out3 = ({tag = "list", n = 0})
	local r_671 = xss1["n"]
	local r_651 = nil
	r_651 = (function(r_661)
		if (r_661 <= r_671) then
			pushCdr_21_1(out3, xss1[r_661]["n"])
			return r_651((r_661 + 1))
		else
		end
	end)
	r_651(1)
	lenghts1 = out3
	local out4 = ({tag = "list", n = 0})
	local r_391 = min2(unpack1(lenghts1, 1, lenghts1["n"]))
	local r_371 = nil
	r_371 = (function(r_381)
		if (r_381 <= r_391) then
			pushCdr_21_1(out4, (function(xs4)
				return fn1(unpack1(xs4, 1, xs4["n"]))
			end)(nths1(xss1, r_381)))
			return r_371((r_381 + 1))
		else
		end
	end)
	r_371(1)
	return out4
end)
any1 = (function(p1, xs5)
	local r_751 = type1(p1)
	if (r_751 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "p", "function", r_751), 2)
	end
	local r_761 = type1(xs5)
	if (r_761 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_761), 2)
	end
	return accumulateWith1(p1, _2d_or1, false, xs5)
end)
elem_3f_1 = (function(x9, xs6)
	local r_791 = type1(xs6)
	if (r_791 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_791), 2)
	end
	return any1((function(y2)
		return eq_3f_1(x9, y2)
	end), xs6)
end)
last1 = (function(xs7)
	local r_821 = type1(xs7)
	if (r_821 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_821), 2)
	end
	return xs7[xs7["n"]]
end)
nths1 = (function(xss2, idx1)
	local out5 = ({tag = "list", n = 0})
	local r_471 = xss2["n"]
	local r_451 = nil
	r_451 = (function(r_461)
		if (r_461 <= r_471) then
			pushCdr_21_1(out5, xss2[r_461][idx1])
			return r_451((r_461 + 1))
		else
		end
	end)
	r_451(1)
	return out5
end)
pushCdr_21_1 = (function(xs8, val4)
	local r_841 = type1(xs8)
	if (r_841 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_841), 2)
	end
	local len2 = (xs8["n"] + 1)
	xs8["n"] = len2
	xs8[len2] = val4
	return xs8
end)
popLast_21_1 = (function(xs9)
	local r_851 = type1(xs9)
	if (r_851 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_851), 2)
	end
	local x10 = xs9[xs9["n"]]
	xs9[xs9["n"]] = nil
	xs9["n"] = (xs9["n"] - 1)
	return x10
end)
removeNth_21_1 = (function(li1, idx2)
	local r_861 = type1(li1)
	if (r_861 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "li", "list", r_861), 2)
	end
	li1["n"] = (li1["n"] - 1)
	return remove1(li1, idx2)
end)
append1 = (function(xs10, ys1)
	return (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_temp = xs10
		for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_temp = ys1
		for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 0
		return _result
	end)()
end)
accumulateWith1 = (function(f2, ac1, z2, xs11)
	local r_881 = type1(f2)
	if (r_881 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "f", "function", r_881), 2)
	end
	local r_891 = type1(ac1)
	if (r_891 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "ac", "function", r_891), 2)
	end
	return foldr1(ac1, z2, map1(f2, xs11))
end)
_2e2e_2 = (function(...)
	local args1 = _pack(...) args1.tag = "list"
	return concat1(args1)
end)
split1 = (function(text1, pattern1, limit1)
	local out6 = ({tag = "list", n = 0})
	local loop1 = true
	local start1 = 1
	local r_941 = nil
	r_941 = (function()
		if loop1 then
			local pos1 = list1(find1(text1, pattern1, start1))
			local nstart1 = car1(pos1)
			local nend1 = car1(cdr1(pos1))
			if ((nstart1 == nil) or (limit1 and (out6["n"] >= limit1))) then
				loop1 = false
				pushCdr_21_1(out6, sub1(text1, start1, len1(text1)))
				start1 = (len1(text1) + 1)
			elseif (nstart1 > len1(text1)) then
				if (start1 <= len1(text1)) then
					pushCdr_21_1(out6, sub1(text1, start1, len1(text1)))
				end
				loop1 = false
			elseif (nend1 < nstart1) then
				pushCdr_21_1(out6, sub1(text1, start1, nstart1))
				start1 = (nstart1 + 1)
			else
				pushCdr_21_1(out6, sub1(text1, start1, (nstart1 - 1)))
				start1 = (nend1 + 1)
			end
			return r_941()
		else
		end
	end)
	r_941()
	return out6
end)
trim1 = (function(str1)
	return (gsub1(gsub1(str1, "^%s+", ""), "%s+$", ""))
end)
local escapes1 = ({})
local r_901 = nil
r_901 = (function(r_911)
	if (r_911 <= 31) then
		escapes1[char1(r_911)] = _2e2e_2("\\", tostring1(r_911))
		return r_901((r_911 + 1))
	else
	end
end)
r_901(0)
escapes1["\n"] = "n"
quoted1 = (function(str2)
	return (gsub1(format1("%q", str2), ".", escapes1))
end)
clock1 = os.clock
execute1 = os.execute
exit1 = os.exit
getenv1 = os.getenv
assoc1 = (function(list2, key1, orVal1)
	if (not (type1(list2) == "list") or empty_3f_1(list2)) then
		return orVal1
	elseif eq_3f_1(car1(car1(list2)), key1) then
		return car1(cdr1(car1(list2)))
	else
		return assoc1(cdr1(list2), key1, orVal1)
	end
end)
assoc_3f_1 = (function(list3, key2)
	if (not (type1(list3) == "list") or empty_3f_1(list3)) then
		return false
	elseif eq_3f_1(car1(car1(list3)), key2) then
		return true
	else
		return assoc_3f_1(cdr1(list3), key2)
	end
end)
struct1 = (function(...)
	local entries1 = _pack(...) entries1.tag = "list"
	if ((entries1["n"] % 2) == 1) then
		error1("Expected an even number of arguments to struct", 2)
	end
	local out7 = ({})
	local r_1051 = entries1["n"]
	local r_1031 = nil
	r_1031 = (function(r_1041)
		if (r_1041 <= r_1051) then
			local key3 = entries1[r_1041]
			local val5 = entries1[(1 + r_1041)]
			out7[(function()
				if (type1(key3) == "key") then
					return key3["contents"]
				else
					return key3
				end
			end)()
			] = val5
			return r_1031((r_1041 + 2))
		else
		end
	end)
	r_1031(1)
	return out7
end)
values1 = (function(st1)
	local out8 = ({tag = "list", n = 0})
	iterPairs1(st1, (function(_5f_1, v2)
		return pushCdr_21_1(out8, v2)
	end))
	return out8
end)
createLookup1 = (function(values2)
	local res1 = ({})
	local r_1131 = values2["n"]
	local r_1111 = nil
	r_1111 = (function(r_1121)
		if (r_1121 <= r_1131) then
			res1[values2[r_1121]] = r_1121
			return r_1111((r_1121 + 1))
		else
		end
	end)
	r_1111(1)
	return res1
end)
invokable_3f_1 = (function(x11)
	return ((type1(x11) == "function") or ((type_23_1(x11) == "table") and ((type_23_1((getmetatable1(x11))) == "table") and invokable_3f_1(getmetatable1(x11)["__call"]))))
end)
flush1 = io.flush
open1 = io.open
read1 = io.read
write1 = io.write
symbol_2d3e_string1 = (function(x12)
	if (type1(x12) == "symbol") then
		return x12["contents"]
	else
		return nil
	end
end)
fail_21_1 = (function(x13)
	return error1(x13, 0)
end)
exit_21_1 = (function(reason1, code1)
	local code2
	if string_3f_1(reason1) then
		code2 = code1
	else
		code2 = reason1
	end
	if string_3f_1(reason1) then
		print1(reason1)
	end
	return exit1(code2)
end)
id1 = (function(x14)
	return x14
end)
self1 = (function(x15, key4, ...)
	local args2 = _pack(...) args2.tag = "list"
	return x15[key4](x15, unpack1(args2, 1, args2["n"]))
end)
create1 = (function(description1)
	return ({["desc"]=description1,["flag-map"]=({}),["opt-map"]=({}),["opt"]=({tag = "list", n = 0}),["pos"]=({tag = "list", n = 0})})
end)
setAction1 = (function(arg2, data1, value2)
	data1[arg2["name"]] = value2
	return nil
end)
addAction1 = (function(arg3, data2, value3)
	local lst1 = data2[arg3["name"]]
	if lst1 then
	else
		lst1 = ({tag = "list", n = 0})
		data2[arg3["name"]] = lst1
	end
	return pushCdr_21_1(lst1, value3)
end)
setNumAction1 = (function(aspec1, data3, value4, usage_21_1)
	local val6 = tonumber1(value4)
	if val6 then
		data3[aspec1["name"]] = val6
		return nil
	else
		return usage_21_1(_2e2e_2("Expected number for ", car1(arg1["names"]), ", got ", value4))
	end
end)
addArgument_21_1 = (function(spec1, names1, ...)
	local options1 = _pack(...) options1.tag = "list"
	local r_2411 = type1(names1)
	if (r_2411 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "names", "list", r_2411), 2)
	end
	if empty_3f_1(names1) then
		error1("Names list is empty")
	end
	if ((options1["n"] % 2) == 0) then
	else
		error1("Options list should be a multiple of two")
	end
	local result1 = ({["names"]=names1,["action"]=nil,["narg"]=0,["default"]=false,["help"]="",["value"]=true})
	local first1 = car1(names1)
	if (sub1(first1, 1, 2) == "--") then
		pushCdr_21_1(spec1["opt"], result1)
		result1["name"] = sub1(first1, 3)
	elseif (sub1(first1, 1, 1) == "-") then
		pushCdr_21_1(spec1["opt"], result1)
		result1["name"] = sub1(first1, 2)
	else
		result1["name"] = first1
		result1["narg"] = "*"
		result1["default"] = ({tag = "list", n = 0})
		pushCdr_21_1(spec1["pos"], result1)
	end
	local r_2461 = names1["n"]
	local r_2441 = nil
	r_2441 = (function(r_2451)
		if (r_2451 <= r_2461) then
			local name1 = names1[r_2451]
			if (sub1(name1, 1, 2) == "--") then
				spec1["opt-map"][sub1(name1, 3)] = result1
			elseif (sub1(name1, 1, 1) == "-") then
				spec1["flag-map"][sub1(name1, 2)] = result1
			end
			return r_2441((r_2451 + 1))
		else
		end
	end)
	r_2441(1)
	local r_2501 = options1["n"]
	local r_2481 = nil
	r_2481 = (function(r_2491)
		if (r_2491 <= r_2501) then
			local key5 = options1[r_2491]
			result1[key5] = (options1[((r_2491 + 1))])
			return r_2481((r_2491 + 2))
		else
		end
	end)
	r_2481(1)
	if result1["var"] then
	else
		result1["var"] = upper1(result1["name"])
	end
	if result1["action"] then
	else
		result1["action"] = (function()
			local temp1
			if number_3f_1(result1["narg"]) then
				temp1 = (result1["narg"] <= 1)
			else
				temp1 = (result1["narg"] == "?")
			end
			if temp1 then
				return setAction1
			else
				return addAction1
			end
		end)()
	end
	return result1
end)
addHelp_21_1 = (function(spec2)
	return addArgument_21_1(spec2, ({tag = "list", n = 2, "--help", "-h"}), "help", "Show this help message", "default", nil, "value", nil, "action", (function(arg4, result2, value5)
		help_21_1(spec2)
		return exit_21_1(0)
	end))
end)
helpNarg_21_1 = (function(buffer1, arg5)
	local r_2931 = arg5["narg"]
	if (r_2931 == "?") then
		return pushCdr_21_1(buffer1, _2e2e_2(" [", arg5["var"], "]"))
	elseif (r_2931 == "*") then
		return pushCdr_21_1(buffer1, _2e2e_2(" [", arg5["var"], "...]"))
	elseif (r_2931 == "+") then
		return pushCdr_21_1(buffer1, _2e2e_2(" ", arg5["var"], " [", arg5["var"], "...]"))
	else
		local r_2941 = nil
		r_2941 = (function(r_2951)
			if (r_2951 <= r_2931) then
				pushCdr_21_1(buffer1, _2e2e_2(" ", arg5["var"]))
				return r_2941((r_2951 + 1))
			else
			end
		end)
		return r_2941(1)
	end
end)
usage_21_2 = (function(spec3, name2)
	if name2 then
	else
		name2 = (arg1[0] or (arg1[-1] or "?"))
	end
	local usage1 = list1("usage: ", name2)
	local r_2551 = spec3["opt"]
	local r_2581 = r_2551["n"]
	local r_2561 = nil
	r_2561 = (function(r_2571)
		if (r_2571 <= r_2581) then
			local arg6 = r_2551[r_2571]
			pushCdr_21_1(usage1, _2e2e_2(" [", car1(arg6["names"])))
			helpNarg_21_1(usage1, arg6)
			pushCdr_21_1(usage1, "]")
			return r_2561((r_2571 + 1))
		else
		end
	end)
	r_2561(1)
	local r_2611 = spec3["pos"]
	local r_2641 = r_2611["n"]
	local r_2621 = nil
	r_2621 = (function(r_2631)
		if (r_2631 <= r_2641) then
			helpNarg_21_1(usage1, (r_2611[r_2631]))
			return r_2621((r_2631 + 1))
		else
		end
	end)
	r_2621(1)
	return print1(concat1(usage1))
end)
help_21_1 = (function(spec4, name3)
	if name3 then
	else
		name3 = (arg1[0] or (arg1[-1] or "?"))
	end
	usage_21_2(spec4, name3)
	if spec4["desc"] then
		print1()
		print1(spec4["desc"])
	end
	local max3 = 0
	local r_2691 = spec4["pos"]
	local r_2721 = r_2691["n"]
	local r_2701 = nil
	r_2701 = (function(r_2711)
		if (r_2711 <= r_2721) then
			local arg7 = r_2691[r_2711]
			local len3 = len1(arg7["var"])
			if (len3 > max3) then
				max3 = len3
			end
			return r_2701((r_2711 + 1))
		else
		end
	end)
	r_2701(1)
	local r_2751 = spec4["opt"]
	local r_2781 = r_2751["n"]
	local r_2761 = nil
	r_2761 = (function(r_2771)
		if (r_2771 <= r_2781) then
			local arg8 = r_2751[r_2771]
			local len4 = len1(concat1(arg8["names"], ", "))
			if (len4 > max3) then
				max3 = len4
			end
			return r_2761((r_2771 + 1))
		else
		end
	end)
	r_2761(1)
	local fmt1 = _2e2e_2(" %-", tostring1((max3 + 1)), "s %s")
	if empty_3f_1(spec4["pos"]) then
	else
		print1()
		print1("Positional arguments")
		local r_2811 = spec4["pos"]
		local r_2841 = r_2811["n"]
		local r_2821 = nil
		r_2821 = (function(r_2831)
			if (r_2831 <= r_2841) then
				local arg9 = r_2811[r_2831]
				print1(format1(fmt1, arg9["var"], arg9["help"]))
				return r_2821((r_2831 + 1))
			else
			end
		end)
		r_2821(1)
	end
	if empty_3f_1(spec4["opt"]) then
	else
		print1()
		print1("Optional arguments")
		local r_2871 = spec4["opt"]
		local r_2901 = r_2871["n"]
		local r_2881 = nil
		r_2881 = (function(r_2891)
			if (r_2891 <= r_2901) then
				local arg10 = r_2871[r_2891]
				print1(format1(fmt1, concat1(arg10["names"], ", "), arg10["help"]))
				return r_2881((r_2891 + 1))
			else
			end
		end)
		return r_2881(1)
	end
end)
matcher1 = (function(pattern2)
	return (function(x16)
		local res2 = list1(match1(x16, pattern2))
		if (car1(res2) == nil) then
			return nil
		else
			return res2
		end
	end)
end)
parse_21_1 = (function(spec5, args3)
	if args3 then
	else
		args3 = arg1
	end
	local result3 = ({})
	local pos2 = spec5["pos"]
	local idx3 = 1
	local len5 = args3["n"]
	local usage_21_3 = (function(msg1)
		usage_21_2(spec5, (args3[0]))
		print1(msg1)
		return exit_21_1(1)
	end)
	local readArgs1 = (function(key6, arg11)
		local r_3291 = arg11["narg"]
		if (r_3291 == "+") then
			idx3 = (idx3 + 1)
			local elem1 = args3[idx3]
			if (elem1 == nil) then
				local msg2 = _2e2e_2("Expected ", arg11["var"], " after --", key6, ", got nothing")
				usage_21_2(spec5, (args3[0]))
				print1(msg2)
				exit_21_1(1)
			elseif (not arg11["all"] and find1(elem1, "^%-")) then
				local msg3 = _2e2e_2("Expected ", arg11["var"], " after --", key6, ", got ", args3[idx3])
				usage_21_2(spec5, (args3[0]))
				print1(msg3)
				exit_21_1(1)
			else
				arg11["action"](arg11, result3, elem1, usage_21_3)
			end
			local running1 = true
			local r_3311 = nil
			r_3311 = (function()
				if running1 then
					idx3 = (idx3 + 1)
					local elem2 = args3[idx3]
					if (elem2 == nil) then
						running1 = false
					elseif (not arg11["all"] and find1(elem2, "^%-")) then
						running1 = false
					else
						arg11["action"](arg11, result3, elem2, usage_21_3)
					end
					return r_3311()
				else
				end
			end)
			return r_3311()
		elseif (r_3291 == "*") then
			local running2 = true
			local r_3331 = nil
			r_3331 = (function()
				if running2 then
					idx3 = (idx3 + 1)
					local elem3 = args3[idx3]
					if (elem3 == nil) then
						running2 = false
					elseif (not arg11["all"] and find1(elem3, "^%-")) then
						running2 = false
					else
						arg11["action"](arg11, result3, elem3, usage_21_3)
					end
					return r_3331()
				else
				end
			end)
			return r_3331()
		elseif (r_3291 == "?") then
			idx3 = (idx3 + 1)
			local elem4 = args3[idx3]
			if ((elem4 == nil) or (not arg11["all"] and find1(elem4, "^%-"))) then
				return arg11["action"](arg11, result3, arg11["value"])
			else
				idx3 = (idx3 + 1)
				return arg11["action"](arg11, result3, elem4, usage_21_3)
			end
		elseif (r_3291 == 0) then
			idx3 = (idx3 + 1)
			local value6 = arg11["value"]
			return arg11["action"](arg11, result3, value6, usage_21_3)
		else
			local r_3371 = nil
			r_3371 = (function(r_3381)
				if (r_3381 <= r_3291) then
					idx3 = (idx3 + 1)
					local elem5 = args3[idx3]
					if (elem5 == nil) then
						local msg4 = _2e2e_2("Expected ", r_3291, " args for ", key6, ", got ", (r_3381 - 1))
						usage_21_2(spec5, (args3[0]))
						print1(msg4)
						exit_21_1(1)
					elseif (not arg11["all"] and find1(elem5, "^%-")) then
						local msg5 = _2e2e_2("Expected ", r_3291, " for ", key6, ", got ", (r_3381 - 1))
						usage_21_2(spec5, (args3[0]))
						print1(msg5)
						exit_21_1(1)
					else
						arg11["action"](arg11, result3, elem5, usage_21_3)
					end
					return r_3371((r_3381 + 1))
				else
				end
			end)
			r_3371(1)
			idx3 = (idx3 + 1)
			return nil
		end
	end)
	local r_2921 = nil
	r_2921 = (function()
		if (idx3 <= len5) then
			local r_2981 = args3[idx3]
			local temp2
			local r_2991 = matcher1("^%-%-([^=]+)=(.+)$")(r_2981)
			temp2 = ((type1(r_2991) == "list") and ((r_2991["n"] >= 2) and ((r_2991["n"] <= 2) and true)))
			if temp2 then
				local key7 = matcher1("^%-%-([^=]+)=(.+)$")(r_2981)[1]
				local val7 = matcher1("^%-%-([^=]+)=(.+)$")(r_2981)[2]
				local arg12 = spec5["opt-map"][key7]
				if (arg12 == nil) then
					local msg6 = _2e2e_2("Unknown argument ", key7, " in ", args3[idx3])
					usage_21_2(spec5, (args3[0]))
					print1(msg6)
					exit_21_1(1)
				elseif (not arg12["many"] and (nil ~= result3[arg12["name"]])) then
					local msg7 = _2e2e_2("Too may values for ", key7, " in ", args3[idx3])
					usage_21_2(spec5, (args3[0]))
					print1(msg7)
					exit_21_1(1)
				else
					local narg1 = arg12["narg"]
					if (number_3f_1(narg1) and (narg1 ~= 1)) then
						local msg8 = _2e2e_2("Expected ", tostring1(narg1), " values, got 1 in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg8)
						exit_21_1(1)
					end
					arg12["action"](arg12, result3, val7, usage_21_3)
				end
				idx3 = (idx3 + 1)
			else
				local temp3
				local r_3001 = matcher1("^%-%-(.*)$")(r_2981)
				temp3 = ((type1(r_3001) == "list") and ((r_3001["n"] >= 1) and ((r_3001["n"] <= 1) and true)))
				if temp3 then
					local key8 = matcher1("^%-%-(.*)$")(r_2981)[1]
					local arg13 = spec5["opt-map"][key8]
					if (arg13 == nil) then
						local msg9 = _2e2e_2("Unknown argument ", key8, " in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg9)
						exit_21_1(1)
					elseif (not arg13["many"] and (nil ~= result3[arg13["name"]])) then
						local msg10 = _2e2e_2("Too may values for ", key8, " in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg10)
						exit_21_1(1)
					else
						readArgs1(key8, arg13)
					end
				else
					local temp4
					local r_3011 = matcher1("^%-(.+)$")(r_2981)
					temp4 = ((type1(r_3011) == "list") and ((r_3011["n"] >= 1) and ((r_3011["n"] <= 1) and true)))
					if temp4 then
						local flags1 = matcher1("^%-(.+)$")(r_2981)[1]
						local i1 = 1
						local s1 = len1(flags1)
						local r_3151 = nil
						r_3151 = (function()
							if (i1 <= s1) then
								local key9
								local x17 = i1
								key9 = sub1(flags1, x17, x17)
								local arg14 = spec5["flag-map"][key9]
								if (arg14 == nil) then
									local msg11 = _2e2e_2("Unknown flag ", key9, " in ", args3[idx3])
									usage_21_2(spec5, (args3[0]))
									print1(msg11)
									exit_21_1(1)
								elseif (not arg14["many"] and (nil ~= result3[arg14["name"]])) then
									local msg12 = _2e2e_2("Too many occurances of ", key9, " in ", args3[idx3])
									usage_21_2(spec5, (args3[0]))
									print1(msg12)
									exit_21_1(1)
								else
									local narg2 = arg14["narg"]
									if (i1 == s1) then
										readArgs1(key9, arg14)
									elseif (narg2 == 0) then
										local value7 = arg14["value"]
										arg14["action"](arg14, result3, value7, usage_21_3)
									else
										local value8 = sub1(flags1, (i1 + 1))
										arg14["action"](arg14, result3, value8, usage_21_3)
										i1 = (s1 + 1)
										idx3 = (idx3 + 1)
									end
								end
								i1 = (i1 + 1)
								return r_3151()
							else
							end
						end)
						r_3151()
					else
						local arg15 = car1(spec5["pos"])
						if arg15 then
							arg15["action"](arg15, result3, r_2981, usage_21_3)
						else
							local msg13 = _2e2e_2("Unknown argument ", arg15)
							usage_21_2(spec5, (args3[0]))
							print1(msg13)
							exit_21_1(1)
						end
						idx3 = (idx3 + 1)
					end
				end
			end
			return r_2921()
		else
		end
	end)
	r_2921()
	local r_3181 = spec5["opt"]
	local r_3211 = r_3181["n"]
	local r_3191 = nil
	r_3191 = (function(r_3201)
		if (r_3201 <= r_3211) then
			local arg16 = r_3181[r_3201]
			if (result3[arg16["name"]] == nil) then
				result3[arg16["name"]] = arg16["default"]
			end
			return r_3191((r_3201 + 1))
		else
		end
	end)
	r_3191(1)
	local r_3241 = spec5["pos"]
	local r_3271 = r_3241["n"]
	local r_3251 = nil
	r_3251 = (function(r_3261)
		if (r_3261 <= r_3271) then
			local arg17 = r_3241[r_3261]
			if (result3[arg17["name"]] == nil) then
				result3[arg17["name"]] = arg17["default"]
			end
			return r_3251((r_3261 + 1))
		else
		end
	end)
	r_3251(1)
	return result3
end)
builtins1 = require1("tacky.analysis.resolve")["builtins"]
builtinVars1 = require1("tacky.analysis.resolve")["declaredVars"]
builtin_3f_1 = (function(node1, name4)
	return ((type1(node1) == "symbol") and (node1["var"] == builtins1[name4]))
end)
sideEffect_3f_1 = (function(node2)
	local tag3 = type1(node2)
	if ((tag3 == "number") or ((tag3 == "string") or ((tag3 == "key") or (tag3 == "symbol")))) then
		return false
	elseif (tag3 == "list") then
		local fst1 = car1(node2)
		if (type1(fst1) == "symbol") then
			local var1 = fst1["var"]
			return ((var1 ~= builtins1["lambda"]) and (var1 ~= builtins1["quote"]))
		else
			return true
		end
	else
		_error("unmatched item")
	end
end)
constant_3f_1 = (function(node3)
	return (string_3f_1(node3) or (number_3f_1(node3) or (type1(node3) == "key")))
end)
urn_2d3e_val1 = (function(node4)
	if string_3f_1(node4) then
		return node4["value"]
	elseif number_3f_1(node4) then
		return node4["value"]
	elseif (type1(node4) == "key") then
		return node4["value"]
	else
		_error("unmatched item")
	end
end)
val_2d3e_urn1 = (function(val8)
	if (type_23_1(val8) == "string") then
		return ({["tag"]="string",["value"]=val8})
	elseif (type_23_1(val8) == "number") then
		return ({["tag"]="number",["value"]=val8})
	elseif (type_23_1(val8) == "nil") then
		return ({["tag"]="symbol",["contents"]="nil",["var"]=builtins1["nil"]})
	elseif (type_23_1(val8) == "boolean") then
		return ({["tag"]="symbol",["contents"]=tostring1(val8),["var"]=builtins1[tostring1(val8)]})
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(type_23_1(val8)), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"nil\"`\n  Tried: `\"boolean\"`"))
	end
end)
urn_2d3e_bool1 = (function(node5)
	if (string_3f_1(node5) or ((type1(node5) == "key") or number_3f_1(node5))) then
		return true
	elseif (type1(node5) == "symbol") then
		if (builtins1["true"] == node5["var"]) then
			return true
		elseif (builtins1["false"] == node5["var"]) then
			return false
		elseif (builtins1["nil"] == node5["var"]) then
			return false
		else
			return nil
		end
	else
		return nil
	end
end)
makeProgn1 = (function(body1)
	return ({tag = "list", n = 1, (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_result[1 + _offset] = (function(var2)
			return ({["tag"]="symbol",["contents"]=var2["name"],["var"]=var2})
		end)(builtins1["lambda"])
		_result[2 + _offset] = ({tag = "list", n = 0})
		_temp = body1
		for _c = 1, _temp.n do _result[2 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 2
		return _result
	end)()
	})
end)
makeSymbol1 = (function(var3)
	return ({["tag"]="symbol",["contents"]=var3["name"],["var"]=var3})
end)
local r_3631 = builtins1["nil"]
makeNil1 = (function()
	return ({["tag"]="symbol",["contents"]=r_3631["name"],["var"]=r_3631})
end)
fastAll1 = (function(fn2, li2, i2)
	if (i2 > li2["n"]) then
		return true
	elseif fn2(li2[i2]) then
		return fastAll1(fn2, li2, (i2 + 1))
	else
		return false
	end
end)
startTimer_21_1 = (function(timer1, name5, level1)
	local instance1 = timer1["timers"][name5]
	if instance1 then
	else
		instance1 = ({["name"]=name5,["level"]=(level1 or 1),["running"]=false,["total"]=0})
		timer1["timers"][name5] = instance1
	end
	if instance1["running"] then
		error1(_2e2e_2("Timer ", name5, " is already running"))
	end
	instance1["running"] = true
	instance1["start"] = clock1()
	return nil
end)
pauseTimer_21_1 = (function(timer2, name6)
	local instance2 = timer2["timers"][name6]
	if instance2 then
	else
		error1(_2e2e_2("Timer ", name6, " does not exist"))
	end
	if instance2["running"] then
	else
		error1(_2e2e_2("Timer ", name6, " is not running"))
	end
	instance2["running"] = false
	instance2["total"] = ((clock1() - instance2["start"]) + instance2["total"])
	return nil
end)
stopTimer_21_1 = (function(timer3, name7)
	local instance3 = timer3["timers"][name7]
	if instance3 then
	else
		error1(_2e2e_2("Timer ", name7, " does not exist"))
	end
	if instance3["running"] then
	else
		error1(_2e2e_2("Timer ", name7, " is not running"))
	end
	timer3["timers"][name7] = nil
	instance3["total"] = ((clock1() - instance3["start"]) + instance3["total"])
	return timer3["callback"](instance3["name"], instance3["total"], instance3["level"])
end)
void1 = ({["callback"]=(function()
end),["timers"]=({})})
config1 = package.config
coloredAnsi1 = (function(col1, msg14)
	return _2e2e_2("\27[", col1, "m", msg14, "\27[0m")
end)
if (config1 and (sub1(config1, 1, 1) ~= "\\")) then
	colored_3f_1 = true
elseif (getenv1 and (getenv1("ANSICON") ~= nil)) then
	colored_3f_1 = true
else
	local temp5
	if getenv1 then
		local term1 = getenv1("TERM")
		if term1 then
			temp5 = find1(term1, "xterm")
		else
			temp5 = nil
		end
	else
		temp5 = false
	end
	if temp5 then
		colored_3f_1 = true
	else
		colored_3f_1 = false
	end
end
if colored_3f_1 then
	colored1 = coloredAnsi1
else
	colored1 = (function(col2, msg15)
		return msg15
	end)
end
putError_21_1 = (function(logger1, msg16)
	return self1(logger1, "put-error!", msg16)
end)
putWarning_21_1 = (function(logger2, msg17)
	return self1(logger2, "put-warning!", msg17)
end)
putVerbose_21_1 = (function(logger3, msg18)
	return self1(logger3, "put-verbose!", msg18)
end)
putDebug_21_1 = (function(logger4, msg19)
	return self1(logger4, "put-debug!", msg19)
end)
putNodeError_21_1 = (function(logger5, msg20, node6, explain1, ...)
	local lines1 = _pack(...) lines1.tag = "list"
	return self1(logger5, "put-node-error!", msg20, node6, explain1, lines1)
end)
putNodeWarning_21_1 = (function(logger6, msg21, node7, explain2, ...)
	local lines2 = _pack(...) lines2.tag = "list"
	return self1(logger6, "put-node-warning!", msg21, node7, explain2, lines2)
end)
doNodeError_21_1 = (function(logger7, msg22, node8, explain3, ...)
	local lines3 = _pack(...) lines3.tag = "list"
	self1(logger7, "put-node-error!", msg22, node8, explain3, lines3)
	return error1((match1(msg22, "^([^\n]+)\n") or msg22), 0)
end)
local _ = ({["startTimer"]=startTimer_21_1,["pauseTimer"]=pauseTimer_21_1,["stopTimer"]=stopTimer_21_1,["putError"]=putError_21_1,["putWarning"]=putWarning_21_1,["putVerbose"]=putVerbose_21_1,["putDebug"]=putDebug_21_1,["putNodeError"]=putNodeError_21_1,["putNodeWarning"]=putNodeWarning_21_1,["doNodeError"]=doNodeError_21_1,["colored"]=colored1})
passEnabled_3f_1 = (function(pass1, options2)
	local override1 = options2["override"]
	if (override1[pass1["name"]] == true) then
		return true
	elseif (override1[pass1["name"]] == false) then
		return false
	elseif any1((function(cat1)
		return (override1[cat1] == true)
	end), pass1["cat"]) then
		return true
	elseif any1((function(cat2)
		return (override1[cat2] == false)
	end), pass1["cat"]) then
		return false
	else
		return ((pass1["on"] ~= false) and (options2["level"] >= (pass1["level"] or 1)))
	end
end)
runPass1 = (function(pass2, options3, tracker1, ...)
	local args4 = _pack(...) args4.tag = "list"
	if passEnabled_3f_1(pass2, options3) then
		local ptracker1 = ({["changed"]=false})
		local name8 = _2e2e_2("[", concat1(pass2["cat"], " "), "] ", pass2["name"])
		startTimer_21_1(options3["timer"], name8, 2)
		pass2["run"](ptracker1, options3, unpack1(args4, 1, args4["n"]))
		stopTimer_21_1(options3["timer"], name8)
		if ptracker1["changed"] then
			if options3["track"] then
				self1(options3["logger"], "put-verbose!", (_2e2e_2(name8, " did something.")))
			end
			if tracker1 then
				tracker1["changed"] = true
			end
		end
		return ptracker1["changed"]
	else
	end
end)
builtins2 = require1("tacky.analysis.resolve")["builtins"]
traverseQuote1 = (function(node9, visitor1, level2)
	if (level2 == 0) then
		return traverseNode1(node9, visitor1)
	else
		local tag4 = node9["tag"]
		if ((tag4 == "string") or ((tag4 == "number") or ((tag4 == "key") or (tag4 == "symbol")))) then
			return node9
		elseif (tag4 == "list") then
			local first2 = node9[1]
			if (first2 and (first2["tag"] == "symbol")) then
				if ((first2["contents"] == "unquote") or (first2["contents"] == "unquote-splice")) then
					node9[2] = traverseQuote1(node9[2], visitor1, (level2 - 1))
					return node9
				elseif (first2["contents"] == "syntax-quote") then
					node9[2] = traverseQuote1(node9[2], visitor1, (level2 + 1))
					return node9
				else
					local r_3911 = node9["n"]
					local r_3891 = nil
					r_3891 = (function(r_3901)
						if (r_3901 <= r_3911) then
							node9[r_3901] = traverseQuote1(node9[r_3901], visitor1, level2)
							return r_3891((r_3901 + 1))
						else
						end
					end)
					r_3891(1)
					return node9
				end
			else
				local r_3951 = node9["n"]
				local r_3931 = nil
				r_3931 = (function(r_3941)
					if (r_3941 <= r_3951) then
						node9[r_3941] = traverseQuote1(node9[r_3941], visitor1, level2)
						return r_3931((r_3941 + 1))
					else
					end
				end)
				r_3931(1)
				return node9
			end
		elseif error1 then
			return _2e2e_2("Unknown tag ", tag4)
		else
			_error("unmatched item")
		end
	end
end)
traverseNode1 = (function(node10, visitor2)
	local tag5 = node10["tag"]
	if ((tag5 == "string") or ((tag5 == "number") or ((tag5 == "key") or (tag5 == "symbol")))) then
		return visitor2(node10, visitor2)
	elseif (tag5 == "list") then
		local first3 = car1(node10)
		first3 = visitor2(first3, visitor2)
		node10[1] = first3
		if (first3["tag"] == "symbol") then
			local func1 = first3["var"]
			local funct1 = func1["tag"]
			if (func1 == builtins2["lambda"]) then
				traverseBlock1(node10, 3, visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["cond"]) then
				local r_3991 = node10["n"]
				local r_3971 = nil
				r_3971 = (function(r_3981)
					if (r_3981 <= r_3991) then
						local case1 = node10[r_3981]
						case1[1] = traverseNode1(case1[1], visitor2)
						traverseBlock1(case1, 2, visitor2)
						return r_3971((r_3981 + 1))
					else
					end
				end)
				r_3971(2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["set!"]) then
				node10[3] = traverseNode1(node10[3], visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["quote"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["syntax-quote"]) then
				node10[2] = traverseQuote1(node10[2], visitor2, 1)
				return visitor2(node10, visitor2)
			elseif ((func1 == builtins2["unquote"]) or (func1 == builtins2["unquote-splice"])) then
				return error1("unquote/unquote-splice should never appear head", 0)
			elseif ((func1 == builtins2["define"]) or (func1 == builtins2["define-macro"])) then
				node10[node10["n"]] = traverseNode1(node10[(node10["n"])], visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["define-native"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["import"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["struct-literal"]) then
				traverseList1(node10, 2, visitor2)
				return visitor2(node10, visitor2)
			elseif ((funct1 == "defined") or ((funct1 == "arg") or ((funct1 == "native") or (funct1 == "macro")))) then
				traverseList1(node10, 1, visitor2)
				return visitor2(node10, visitor2)
			else
				return error1(_2e2e_2("Unknown kind ", funct1, " for variable ", func1["name"]), 0)
			end
		else
			traverseList1(node10, 1, visitor2)
			return visitor2(node10, visitor2)
		end
	else
		return error1(_2e2e_2("Unknown tag ", tag5))
	end
end)
traverseBlock1 = (function(node11, start2, visitor3)
	local r_3781 = node11["n"]
	local r_3761 = nil
	r_3761 = (function(r_3771)
		if (r_3771 <= r_3781) then
			node11[r_3771] = (traverseNode1(node11[((r_3771 + 0))], visitor3))
			return r_3761((r_3771 + 1))
		else
		end
	end)
	r_3761(start2)
	return node11
end)
traverseList1 = (function(node12, start3, visitor4)
	local r_3821 = node12["n"]
	local r_3801 = nil
	r_3801 = (function(r_3811)
		if (r_3811 <= r_3821) then
			node12[r_3811] = traverseNode1(node12[r_3811], visitor4)
			return r_3801((r_3811 + 1))
		else
		end
	end)
	r_3801(start3)
	return node12
end)
builtins3 = require1("tacky.analysis.resolve")["builtins"]
visitQuote1 = (function(node13, visitor5, level3)
	if (level3 == 0) then
		return visitNode1(node13, visitor5)
	else
		local tag6 = node13["tag"]
		if ((tag6 == "string") or ((tag6 == "number") or ((tag6 == "key") or (tag6 == "symbol")))) then
			return nil
		elseif (tag6 == "list") then
			local first4 = node13[1]
			if (first4 and (first4["tag"] == "symbol")) then
				if ((first4["contents"] == "unquote") or (first4["contents"] == "unquote-splice")) then
					return visitQuote1(node13[2], visitor5, (level3 - 1))
				elseif (first4["contents"] == "syntax-quote") then
					return visitQuote1(node13[2], visitor5, (level3 + 1))
				else
					local r_4301 = node13["n"]
					local r_4281 = nil
					r_4281 = (function(r_4291)
						if (r_4291 <= r_4301) then
							visitQuote1(node13[r_4291], visitor5, level3)
							return r_4281((r_4291 + 1))
						else
						end
					end)
					return r_4281(1)
				end
			else
				local r_4361 = node13["n"]
				local r_4341 = nil
				r_4341 = (function(r_4351)
					if (r_4351 <= r_4361) then
						visitQuote1(node13[r_4351], visitor5, level3)
						return r_4341((r_4351 + 1))
					else
					end
				end)
				return r_4341(1)
			end
		elseif error1 then
			return _2e2e_2("Unknown tag ", tag6)
		else
			_error("unmatched item")
		end
	end
end)
visitNode1 = (function(node14, visitor6)
	if (visitor6(node14, visitor6) == false) then
	else
		local tag7 = node14["tag"]
		if ((tag7 == "string") or ((tag7 == "number") or ((tag7 == "key") or (tag7 == "symbol")))) then
			return nil
		elseif (tag7 == "list") then
			local first5 = node14[1]
			if (first5["tag"] == "symbol") then
				local func2 = first5["var"]
				local funct2 = func2["tag"]
				if (func2 == builtins3["lambda"]) then
					return visitBlock1(node14, 3, visitor6)
				elseif (func2 == builtins3["cond"]) then
					local r_4401 = node14["n"]
					local r_4381 = nil
					r_4381 = (function(r_4391)
						if (r_4391 <= r_4401) then
							local case2 = node14[r_4391]
							visitNode1(case2[1], visitor6)
							visitBlock1(case2, 2, visitor6)
							return r_4381((r_4391 + 1))
						else
						end
					end)
					return r_4381(2)
				elseif (func2 == builtins3["set!"]) then
					return visitNode1(node14[3], visitor6)
				elseif (func2 == builtins3["quote"]) then
				elseif (func2 == builtins3["syntax-quote"]) then
					return visitQuote1(node14[2], visitor6, 1)
				elseif ((func2 == builtins3["unquote"]) or (func2 == builtins3["unquote-splice"])) then
					return error1("unquote/unquote-splice should never appear here", 0)
				elseif ((func2 == builtins3["define"]) or (func2 == builtins3["define-macro"])) then
					return visitNode1(node14[(node14["n"])], visitor6)
				elseif (func2 == builtins3["define-native"]) then
				elseif (func2 == builtins3["import"]) then
				elseif (func2 == builtins3["struct-literal"]) then
					return visitBlock1(node14, 2, visitor6)
				elseif ((funct2 == "defined") or ((funct2 == "arg") or ((funct2 == "native") or (funct2 == "macro")))) then
					return visitBlock1(node14, 1, visitor6)
				else
					return error1(_2e2e_2("Unknown kind ", funct2, " for variable ", func2["name"]), 0)
				end
			else
				return visitBlock1(node14, 1, visitor6)
			end
		else
			return error1(_2e2e_2("Unknown tag ", tag7))
		end
	end
end)
visitBlock1 = (function(node15, start4, visitor7)
	local r_4191 = node15["n"]
	local r_4171 = nil
	r_4171 = (function(r_4181)
		if (r_4181 <= r_4191) then
			visitNode1(node15[r_4181], visitor7)
			return r_4171((r_4181 + 1))
		else
		end
	end)
	return r_4171(start4)
end)
getVar1 = (function(state1, var4)
	local entry1 = state1["vars"][var4]
	if entry1 then
	else
		entry1 = ({["var"]=var4,["usages"]=({tag = "list", n = 0}),["defs"]=({tag = "list", n = 0}),["active"]=false})
		state1["vars"][var4] = entry1
	end
	return entry1
end)
addUsage_21_1 = (function(state2, var5, node16)
	local varMeta1 = getVar1(state2, var5)
	pushCdr_21_1(varMeta1["usages"], node16)
	varMeta1["active"] = true
	return nil
end)
addDefinition_21_1 = (function(state3, var6, node17, kind1, value9)
	return pushCdr_21_1(getVar1(state3, var6)["defs"], ({["tag"]=kind1,["node"]=node17,["value"]=value9}))
end)
definitionsVisitor1 = (function(state4, node18, visitor8)
	if ((type1(node18) == "list") and (type1((car1(node18))) == "symbol")) then
		local func3 = car1(node18)["var"]
		if (func3 == builtins1["lambda"]) then
			local r_4481 = node18[2]
			local r_4511 = r_4481["n"]
			local r_4491 = nil
			r_4491 = (function(r_4501)
				if (r_4501 <= r_4511) then
					local arg18 = r_4481[r_4501]
					addDefinition_21_1(state4, arg18["var"], arg18, "var", arg18["var"])
					return r_4491((r_4501 + 1))
				else
				end
			end)
			return r_4491(1)
		elseif (func3 == builtins1["set!"]) then
			return addDefinition_21_1(state4, node18[2]["var"], node18, "val", node18[3])
		elseif ((func3 == builtins1["define"]) or (func3 == builtins1["define-macro"])) then
			return addDefinition_21_1(state4, node18["defVar"], node18, "val", node18[(node18["n"])])
		elseif (func3 == builtins1["define-native"]) then
			return addDefinition_21_1(state4, node18["defVar"], node18, "var", node18["defVar"])
		else
		end
	elseif ((type1(node18) == "list") and ((type1((car1(node18))) == "list") and ((type1((car1(car1(node18)))) == "symbol") and (car1(car1(node18))["var"] == builtins1["lambda"])))) then
		local lam1 = car1(node18)
		local args5 = lam1[2]
		local offset1 = 1
		local r_4591 = args5["n"]
		local r_4571 = nil
		r_4571 = (function(r_4581)
			if (r_4581 <= r_4591) then
				local arg19 = args5[r_4581]
				local val9 = node18[((r_4581 + offset1))]
				if arg19["var"]["isVariadic"] then
					local count1 = (node18["n"] - args5["n"])
					if (count1 < 0) then
						count1 = 0
					end
					offset1 = count1
					addDefinition_21_1(state4, arg19["var"], arg19, "var", arg19["var"])
				else
					addDefinition_21_1(state4, arg19["var"], arg19, "val", (val9 or ({["tag"]="symbol",["contents"]="nil",["var"]=builtins1["nil"]})))
				end
				return r_4571((r_4581 + 1))
			else
			end
		end)
		r_4571(1)
		visitBlock1(node18, 2, visitor8)
		visitBlock1(lam1, 3, visitor8)
		return false
	else
	end
end)
definitionsVisit1 = (function(state5, nodes1)
	return visitBlock1(nodes1, 1, (function(r_4731, r_4741)
		return definitionsVisitor1(state5, r_4731, r_4741)
	end))
end)
usagesVisit1 = (function(state6, nodes2, pred1)
	if pred1 then
	else
		pred1 = (function()
			return true
		end)
	end
	local queue1 = ({tag = "list", n = 0})
	local visited1 = ({})
	local addUsage1 = (function(var7, user1)
		local varMeta2 = getVar1(state6, var7)
		if varMeta2["active"] then
		else
			local r_4671 = varMeta2["defs"]
			local r_4701 = r_4671["n"]
			local r_4681 = nil
			r_4681 = (function(r_4691)
				if (r_4691 <= r_4701) then
					local def1 = r_4671[r_4691]
					local val10 = def1["value"]
					if ((def1["tag"] == "val") and not visited1[val10]) then
						pushCdr_21_1(queue1, val10)
					end
					return r_4681((r_4691 + 1))
				else
				end
			end)
			r_4681(1)
		end
		return addUsage_21_1(state6, var7, user1)
	end)
	local visit1 = (function(node19)
		if visited1[node19] then
			return false
		else
			visited1[node19] = true
			if (type1(node19) == "symbol") then
				addUsage1(node19["var"], node19)
				return true
			elseif ((type1(node19) == "list") and ((node19["n"] > 0) and (type1((car1(node19))) == "symbol"))) then
				local func4 = car1(node19)["var"]
				if ((func4 == builtins1["set!"]) or ((func4 == builtins1["define"]) or (func4 == builtins1["define-macro"]))) then
					if pred1(node19[3]) then
						return true
					else
						return false
					end
				else
					return true
				end
			else
				return true
			end
		end
	end)
	local r_4111 = nodes2["n"]
	local r_4091 = nil
	r_4091 = (function(r_4101)
		if (r_4101 <= r_4111) then
			pushCdr_21_1(queue1, (nodes2[r_4101]))
			return r_4091((r_4101 + 1))
		else
		end
	end)
	r_4091(1)
	local r_4131 = nil
	r_4131 = (function()
		if (queue1["n"] > 0) then
			visitNode1(popLast_21_1(queue1), visit1)
			return r_4131()
		else
		end
	end)
	return r_4131()
end)
tagUsage1 = ({["name"]="tag-usage",["help"]="Gathers usage and definition data for all expressions in NODES, storing it in LOOKUP.",["cat"]=({tag = "list", n = 2, "tag", "usage"}),["run"]=(function(r_4751, state7, nodes3, lookup1)
	definitionsVisit1(lookup1, nodes3)
	return usagesVisit1(lookup1, nodes3, sideEffect_3f_1)
end)})
formatPosition1 = (function(pos3)
	return _2e2e_2(pos3["line"], ":", pos3["column"])
end)
formatRange1 = (function(range1)
	if range1["finish"] then
		return format1("%s:[%s .. %s]", range1["name"], (function(pos4)
			return _2e2e_2(pos4["line"], ":", pos4["column"])
		end)(range1["start"]), (function(pos5)
			return _2e2e_2(pos5["line"], ":", pos5["column"])
		end)(range1["finish"]))
	else
		return format1("%s:[%s]", range1["name"], (function(pos6)
			return _2e2e_2(pos6["line"], ":", pos6["column"])
		end)(range1["start"]))
	end
end)
formatNode1 = (function(node20)
	if (node20["range"] and node20["contents"]) then
		return format1("%s (%q)", formatRange1(node20["range"]), node20["contents"])
	elseif node20["range"] then
		return formatRange1(node20["range"])
	elseif node20["owner"] then
		local owner1 = node20["owner"]
		if owner1["var"] then
			return format1("macro expansion of %s (%s)", owner1["var"]["name"], formatNode1(owner1["node"]))
		else
			return format1("unquote expansion (%s)", formatNode1(owner1["node"]))
		end
	elseif (node20["start"] and node20["finish"]) then
		return formatRange1(node20)
	else
		return "?"
	end
end)
getSource1 = (function(node21)
	local result4 = nil
	local r_4781 = nil
	r_4781 = (function()
		if (node21 and not result4) then
			result4 = node21["range"]
			node21 = node21["parent"]
			return r_4781()
		else
		end
	end)
	r_4781()
	return result4
end)
local _ = ({["formatPosition"]=formatPosition1,["formatRange"]=formatRange1,["formatNode"]=formatNode1,["getSource"]=getSource1})
stripImport1 = ({["name"]="strip-import",["help"]="Strip all import expressions in NODES",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4752, state8, nodes4)
	local r_4801 = nil
	r_4801 = (function(r_4811)
		if (r_4811 >= 1) then
			local node22 = nodes4[r_4811]
			if ((type1(node22) == "list") and ((node22["n"] > 0) and ((type1((car1(node22))) == "symbol") and (car1(node22)["var"] == builtins1["import"])))) then
				if (r_4811 == nodes4["n"]) then
					nodes4[r_4811] = makeNil1()
				else
					removeNth_21_1(nodes4, r_4811)
				end
				r_4752["changed"] = true
			end
			return r_4801((r_4811 + -1))
		else
		end
	end)
	return r_4801(nodes4["n"])
end)})
stripPure1 = ({["name"]="strip-pure",["help"]="Strip all pure expressions in NODES (apart from the last one).",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4753, state9, nodes5)
	local r_4871 = nil
	r_4871 = (function(r_4881)
		if (r_4881 >= 1) then
			if sideEffect_3f_1((nodes5[r_4881])) then
			else
				removeNth_21_1(nodes5, r_4881)
				r_4753["changed"] = true
			end
			return r_4871((r_4881 + -1))
		else
		end
	end)
	return r_4871((nodes5["n"] - 1))
end)})
constantFold1 = ({["name"]="constant-fold",["help"]="A primitive constant folder\n\nThis simply finds function calls with constant functions and looks up the function.\nIf the function is native and pure then we'll execute it and replace the node with the\nresult. There are a couple of caveats:\n\n - If the function call errors then we will flag a warning and continue.\n - If this returns a decimal (or infinity or NaN) then we'll continue: we cannot correctly\n   accurately handle this.\n - If this doesn't return exactly one value then we will stop. This might be a future enhancement.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4754, state10, nodes6)
	return traverseList1(nodes6, 1, (function(node23)
		if ((type1(node23) == "list") and fastAll1(constant_3f_1, node23, 2)) then
			local head1 = car1(node23)
			local meta1 = ((type1(head1) == "symbol") and (not head1["folded"] and ((head1["var"]["tag"] == "native") and state10["meta"][head1["var"]["fullName"]])))
			if (meta1 and (meta1["pure"] and meta1["value"])) then
				local res3 = list1(pcall1(meta1["value"], unpack1(map1(urn_2d3e_val1, cdr1(node23)), 1, (node23["n"] - 1))))
				if car1(res3) then
					local val11 = res3[2]
					if ((res3["n"] ~= 2) or (number_3f_1(val11) and ((car1(cdr1((list1(modf1(val11))))) ~= 0) or (abs1(val11) == huge1)))) then
						head1["folded"] = true
						return node23
					else
						r_4754["changed"] = true
						return val_2d3e_urn1(val11)
					end
				else
					head1["folded"] = true
					putNodeWarning_21_1(state10["logger"], _2e2e_2("Cannot execute constant expression"), node23, nil, getSource1(node23), _2e2e_2("Executed ", pretty1(node23), ", failed with: ", res3[2]))
					return node23
				end
			else
				return node23
			end
		else
			return node23
		end
	end))
end)})
condFold1 = ({["name"]="cond-fold",["help"]="Simplify all `cond` nodes, removing `false` branches and killing\nall branches after a `true` one.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4755, state11, nodes7)
	return traverseList1(nodes7, 1, (function(node24)
		if ((type1(node24) == "list") and ((type1((car1(node24))) == "symbol") and (car1(node24)["var"] == builtins1["cond"]))) then
			local final1 = false
			local i3 = 2
			local r_4991 = nil
			r_4991 = (function()
				if (i3 <= node24["n"]) then
					local elem6 = node24[i3]
					if final1 then
						r_4755["changed"] = true
						removeNth_21_1(node24, i3)
					else
						local r_5081 = urn_2d3e_bool1(car1(elem6))
						if eq_3f_1(r_5081, false) then
							r_4755["changed"] = true
							removeNth_21_1(node24, i3)
						elseif eq_3f_1(r_5081, true) then
							final1 = true
							i3 = (i3 + 1)
						elseif eq_3f_1(r_5081, nil) then
							i3 = (i3 + 1)
						else
							error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5081), ", but none matched.\n", "  Tried: `false`\n  Tried: `true`\n  Tried: `nil`"))
						end
					end
					return r_4991()
				else
				end
			end)
			r_4991()
			if ((node24["n"] == 2) and (urn_2d3e_bool1(car1(node24[2])) == true)) then
				r_4755["changed"] = true
				local body2 = cdr1(node24[2])
				if (body2["n"] == 1) then
					return car1(body2)
				else
					return makeProgn1(cdr1(node24[2]))
				end
			else
				return node24
			end
		else
			return node24
		end
	end))
end)})
lambdaFold1 = ({["name"]="lambda-fold",["help"]="Simplify all directly called lambdas, inlining them were appropriate.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4756, state12, nodes8)
	return traverseList1(nodes8, 1, (function(node25)
		if ((type1(node25) == "list") and ((node25["n"] == 1) and ((type1((car1(node25))) == "list") and (builtin_3f_1(car1(car1(node25)), "lambda") and ((car1(node25)["n"] == 3) and empty_3f_1(car1(node25)[2])))))) then
			r_4756["changed"] = true
			return car1(node25)[3]
		else
			return node25
		end
	end))
end)})
getConstantVal1 = (function(lookup2, sym1)
	local var8 = sym1["var"]
	local def2 = getVar1(lookup2, sym1["var"])
	if (var8 == builtins1["true"]) then
		return sym1
	elseif (var8 == builtins1["false"]) then
		return sym1
	elseif (var8 == builtins1["nil"]) then
		return sym1
	elseif (def2["defs"]["n"] == 1) then
		local ent1 = car1(def2["defs"])
		local val12 = ent1["value"]
		local ty3 = ent1["tag"]
		if (string_3f_1(val12) or (number_3f_1(val12) or (type1(val12) == "key"))) then
			return val12
		elseif ((type1(val12) == "symbol") and (ty3 == "val")) then
			return (getConstantVal1(lookup2, val12) or sym1)
		else
			return sym1
		end
	else
		return nil
	end
end)
stripDefs1 = ({["name"]="strip-defs",["help"]="Strip all unused top level definitions.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_4757, state13, nodes9, lookup3)
	local r_5141 = nil
	r_5141 = (function(r_5151)
		if (r_5151 >= 1) then
			local node26 = nodes9[r_5151]
			if (node26["defVar"] and not getVar1(lookup3, node26["defVar"])["active"]) then
				if (r_5151 == nodes9["n"]) then
					nodes9[r_5151] = makeNil1()
				else
					removeNth_21_1(nodes9, r_5151)
				end
				r_4757["changed"] = true
			end
			return r_5141((r_5151 + -1))
		else
		end
	end)
	return r_5141(nodes9["n"])
end)})
stripArgs1 = ({["name"]="strip-args",["help"]="Strip all unused, pure arguments in directly called lambdas.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_4758, state14, nodes10, lookup4)
	return visitBlock1(nodes10, 1, (function(node27)
		if ((type1(node27) == "list") and ((type1((car1(node27))) == "list") and ((type1((car1(car1(node27)))) == "symbol") and (car1(car1(node27))["var"] == builtins1["lambda"])))) then
			local lam2 = car1(node27)
			local args6 = lam2[2]
			local offset2 = 1
			local remOffset1 = 0
			local removed1 = ({})
			local r_5241 = args6["n"]
			local r_5221 = nil
			r_5221 = (function(r_5231)
				if (r_5231 <= r_5241) then
					local arg20 = args6[((r_5231 - remOffset1))]
					local val13 = node27[(((r_5231 + offset2) - remOffset1))]
					if arg20["var"]["isVariadic"] then
						local count2 = (node27["n"] - args6["n"])
						if (count2 < 0) then
							count2 = 0
						end
						offset2 = count2
					elseif (nil == val13) then
					elseif sideEffect_3f_1(val13) then
					elseif (getVar1(lookup4, arg20["var"])["usages"]["n"] > 0) then
					else
						r_4758["changed"] = true
						removed1[args6[((r_5231 - remOffset1))]["var"]] = true
						removeNth_21_1(args6, (r_5231 - remOffset1))
						removeNth_21_1(node27, ((r_5231 + offset2) - remOffset1))
						remOffset1 = (remOffset1 + 1)
					end
					return r_5221((r_5231 + 1))
				else
				end
			end)
			r_5221(1)
			if (remOffset1 > 0) then
				return traverseList1(lam2, 3, (function(node28)
					if ((type1(node28) == "list") and (builtin_3f_1(car1(node28), "set!") and removed1[node28[2]["var"]])) then
						local val14 = node28[3]
						if sideEffect_3f_1(val14) then
							return makeProgn1(list1(val14, makeNil1()))
						else
							return makeNil1()
						end
					else
						return node28
					end
				end))
			else
			end
		else
		end
	end))
end)})
variableFold1 = ({["name"]="variable-fold",["help"]="Folds constant variable accesses",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_4759, state15, nodes11, lookup5)
	return traverseList1(nodes11, 1, (function(node29)
		if (type1(node29) == "symbol") then
			local var9 = getConstantVal1(lookup5, node29)
			if (var9 and (var9 ~= node29)) then
				r_4759["changed"] = true
				return var9
			else
				return node29
			end
		else
			return node29
		end
	end))
end)})
expressionFold1 = ({["name"]="expression-fold",["help"]="Folds basic variable accesses where execution order will not change.\n\nFor instance, converts ((lambda (x) (+ x 1)) (Y)) to (+ Y 1) in the case\nwhere Y is an arbitrary expression.\n\nThere are a couple of complexities in the implementation here. Firstly, we\nwant to ensure that the arguments are executed in the correct order and only\nonce.\n\nIn order to achieve this, we find the lambda forms and visit the body, stopping\nif we visit arguments in the wrong order or non-constant terms such as mutable\nvariables or other function calls. For simplicities sake, we fail if we hit\nother lambdas or conds as that makes analysing control flow significantly more\ncomplex.\n\nAnother source of added complexity is the case where where Y could return multiple\nvalues: namely in the last argument to function calls. Here it is an invalid optimisation\nto just place Y, as that could result in additional values being passed to the function.\n\nIn order to avoid this, Y will get converted to the form ((lambda (<tmp>) <tmp>) Y).\nThis is understood by the codegen and so is not as inefficient as it looks. However, we do\nhave to take additional steps to avoid trying to fold the above again and again.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_47510, state16, nodes12, lookup6)
	return visitBlock1(nodes12, 1, (function(root1)
		if ((type1(root1) == "list") and ((type1((car1(root1))) == "list") and ((type1((car1(car1(root1)))) == "symbol") and (car1(car1(root1))["var"] == builtins1["lambda"])))) then
			local lam3
			local args7
			local len6
			local validate1
			lam3 = car1(root1)
			args7 = lam3[2]
			len6 = args7["n"]
			validate1 = (function(i4)
				if (i4 > len6) then
					return true
				else
					local arg21 = args7[i4]
					local var10 = arg21["var"]
					local entry2 = getVar1(lookup6, var10)
					if var10["isVariadic"] then
						return false
					elseif (entry2["defs"]["n"] ~= 1) then
						return false
					elseif (entry2["usages"]["n"] ~= 1) then
						return false
					else
						return validate1((i4 + 1))
					end
				end
			end)
			if ((len6 > 0) and (((root1["n"] ~= 2) or ((len6 ~= 1) or ((lam3["n"] ~= 3) or (atom_3f_1(root1[2]) or (not (type1((lam3[3])) == "symbol") or (lam3[3]["var"] ~= car1(args7)["var"])))))) and validate1(1))) then
				local currentIdx1 = 1
				local argMap1 = ({})
				local wrapMap1 = ({})
				local ok1 = true
				local finished1 = false
				local r_5711 = args7["n"]
				local r_5691 = nil
				r_5691 = (function(r_5701)
					if (r_5701 <= r_5711) then
						argMap1[args7[r_5701]["var"]] = r_5701
						return r_5691((r_5701 + 1))
					else
					end
				end)
				r_5691(1)
				visitBlock1(lam3, 3, (function(node30, visitor9)
					if ok1 then
						local r_5731 = type1(node30)
						if (r_5731 == "string") then
						elseif (r_5731 == "number") then
						elseif (r_5731 == "key") then
						elseif (r_5731 == "symbol") then
							local idx4 = argMap1[node30["var"]]
							if (idx4 == nil) then
								if (getVar1(lookup6, node30["var"])["defs"]["n"] > 1) then
									ok1 = false
									return false
								else
								end
							elseif (idx4 == currentIdx1) then
								currentIdx1 = (currentIdx1 + 1)
								if (currentIdx1 > len6) then
									finished1 = true
									return nil
								else
								end
							else
								ok1 = false
								return false
							end
						elseif (r_5731 == "list") then
							local head2 = car1(node30)
							if (type1(head2) == "symbol") then
								local var11 = head2["var"]
								if (var11 == builtins1["set!"]) then
									visitNode1(node30[3], visitor9)
								elseif (var11 == builtins1["define"]) then
									visitNode1(last1(node30), visitor9)
								elseif (var11 == builtins1["define-macro"]) then
									visitNode1(last1(node30), visitor9)
								elseif (var11 == builtins1["define-native"]) then
								elseif (var11 == builtins1["cond"]) then
									visitNode1(car1(node30[2]), visitor9)
								elseif (var11 == builtins1["lambda"]) then
								elseif (var11 == builtins1["quote"]) then
								elseif (var11 == builtins1["import"]) then
								elseif (var11 == builtins1["syntax-quote"]) then
									visitQuote1(node30[2], visitor9, 1)
								elseif (var11 == builtins1["struct-literal"]) then
									visitBlock1(node30, 2, visitor9)
								else
									visitBlock1(node30, 1, visitor9)
								end
								if (node30["n"] > 1) then
									local last2 = node30[(node30["n"])]
									if (type1(last2) == "symbol") then
										local idx5 = argMap1[last2["var"]]
										if idx5 then
											if (type1(((root1[(idx5 + 1)]))) == "list") then
												wrapMap1[idx5] = true
											end
										end
									end
								end
								if finished1 then
								elseif (var11 == builtins1["set!"]) then
									ok1 = false
								elseif (var11 == builtins1["cond"]) then
									ok1 = false
								elseif (var11 == builtins1["lambda"]) then
									ok1 = false
								else
									ok1 = false
								end
								return false
							else
								ok1 = false
								return false
							end
						else
							return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5731), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
						end
					else
						return false
					end
				end))
				if (ok1 and finished1) then
					r_47510["changed"] = true
					traverseList1(root1, 1, (function(child1)
						if (type1(child1) == "symbol") then
							local var12 = child1["var"]
							local i5 = argMap1[var12]
							if i5 then
								if wrapMap1[i5] then
									return ({tag = "list", n = 2, ({tag = "list", n = 3, (function(var13)
										return ({["tag"]="symbol",["contents"]=var13["name"],["var"]=var13})
									end)(builtins1["lambda"]), ({tag = "list", n = 1, ({["tag"]="symbol",["contents"]=var12["name"],["var"]=var12})}), ({["tag"]="symbol",["contents"]=var12["name"],["var"]=var12})}), root1[((i5 + 1))]})
								else
									return (root1[((i5 + 1))] or makeNil1())
								end
							else
								return child1
							end
						else
							return child1
						end
					end))
					local r_5761 = nil
					r_5761 = (function(r_5771)
						if (r_5771 >= 2) then
							removeNth_21_1(root1, r_5771)
							return r_5761((r_5771 + -1))
						else
						end
					end)
					r_5761(root1["n"])
					local r_5801 = nil
					r_5801 = (function(r_5811)
						if (r_5811 >= 1) then
							removeNth_21_1(args7, r_5811)
							return r_5801((r_5811 + -1))
						else
						end
					end)
					return r_5801(args7["n"])
				else
				end
			else
			end
		else
		end
	end))
end)})
condEliminate1 = ({["name"]="cond-eliminate",["help"]="Replace variables with known truthy/falsey values with `true` or `false` when used in branches.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_47511, state17, nodes13, varLookup1)
	local lookup7 = ({})
	return visitBlock1(nodes13, 1, (function(node31, visitor10, isCond1)
		local r_5321 = type1(node31)
		if (r_5321 == "symbol") then
			if isCond1 then
				local r_5331 = lookup7[node31["var"]]
				if eq_3f_1(r_5331, false) then
					local var14 = builtins1["false"]
					return ({["tag"]="symbol",["contents"]=var14["name"],["var"]=var14})
				elseif eq_3f_1(r_5331, true) then
					local var15 = builtins1["true"]
					return ({["tag"]="symbol",["contents"]=var15["name"],["var"]=var15})
				else
					return nil
				end
			else
			end
		elseif (r_5321 == "list") then
			local head3 = car1(node31)
			local r_5341 = type1(head3)
			if (r_5341 == "symbol") then
				if builtin_3f_1(head3, "cond") then
					local vars1 = ({tag = "list", n = 0})
					local r_5371 = node31["n"]
					local r_5351 = nil
					r_5351 = (function(r_5361)
						if (r_5361 <= r_5371) then
							local entry3 = node31[r_5361]
							local test1 = car1(entry3)
							local len7 = entry3["n"]
							local var16 = ((type1(test1) == "symbol") and test1["var"])
							if var16 then
								if (lookup7[var16] ~= nil) then
									var16 = nil
								elseif (getVar1(varLookup1, var16)["defs"]["n"] > 1) then
									var16 = nil
								end
							end
							local r_5391 = visitor10(test1, visitor10, true)
							if eq_3f_1(r_5391, nil) then
								visitNode1(test1, visitor10)
							elseif eq_3f_1(r_5391, false) then
							else
								r_47511["changed"] = true
								entry3[1] = r_5391
							end
							if var16 then
								pushCdr_21_1(vars1, var16)
								lookup7[var16] = true
							end
							local r_5421 = (len7 - 1)
							local r_5401 = nil
							r_5401 = (function(r_5411)
								if (r_5411 <= r_5421) then
									visitNode1(entry3[r_5411], visitor10)
									return r_5401((r_5411 + 1))
								else
								end
							end)
							r_5401(2)
							if (len7 > 1) then
								local last3 = entry3[len7]
								local r_5441 = visitor10(last3, visitor10, isCond1)
								if eq_3f_1(r_5441, nil) then
									visitNode1(last3, visitor10)
								elseif eq_3f_1(r_5441, false) then
								else
									r_47511["changed"] = true
									entry3[len7] = r_5441
								end
							end
							if var16 then
								lookup7[var16] = false
							end
							return r_5351((r_5361 + 1))
						else
						end
					end)
					r_5351(2)
					local r_5501 = vars1["n"]
					local r_5481 = nil
					r_5481 = (function(r_5491)
						if (r_5491 <= r_5501) then
							lookup7[vars1[r_5491]] = nil
							return r_5481((r_5491 + 1))
						else
						end
					end)
					r_5481(1)
					return false
				else
				end
			elseif (r_5341 == "list") then
				if (isCond1 and builtin_3f_1(car1(head3), "lambda")) then
					local r_5551 = node31["n"]
					local r_5531 = nil
					r_5531 = (function(r_5541)
						if (r_5541 <= r_5551) then
							visitNode1(node31[r_5541], visitor10)
							return r_5531((r_5541 + 1))
						else
						end
					end)
					r_5531(2)
					local len8 = head3["n"]
					local r_5591 = (len8 - 1)
					local r_5571 = nil
					r_5571 = (function(r_5581)
						if (r_5581 <= r_5591) then
							visitNode1(head3[r_5581], visitor10)
							return r_5571((r_5581 + 1))
						else
						end
					end)
					r_5571(3)
					if (len8 > 2) then
						local last4 = head3[len8]
						local r_5611 = visitor10(last4, visitor10, isCond1)
						if eq_3f_1(r_5611, nil) then
							visitNode1(last4, visitor10)
						elseif eq_3f_1(r_5611, false) then
						else
							r_47511["changed"] = true
							node31[head3] = r_5611
						end
					end
					return false
				else
				end
			else
			end
		else
		end
	end))
end)})
scope_2f_child1 = require1("tacky.analysis.scope")["child"]
scope_2f_add_21_1 = require1("tacky.analysis.scope")["add"]
copyOf1 = (function(x18)
	local res4 = ({})
	iterPairs1(x18, (function(k2, v3)
		res4[k2] = v3
		return nil
	end))
	return res4
end)
getScope1 = (function(scope1, lookup8, n1)
	local newScope1 = lookup8["scopes"][scope1]
	if newScope1 then
		return newScope1
	else
		local newScope2 = scope_2f_child1()
		lookup8["scopes"][scope1] = newScope2
		return newScope2
	end
end)
getVar2 = (function(var17, lookup9)
	return (lookup9["vars"][var17] or var17)
end)
copyNode1 = (function(node32, lookup10)
	local r_5851 = type1(node32)
	if (r_5851 == "string") then
		return copyOf1(node32)
	elseif (r_5851 == "key") then
		return copyOf1(node32)
	elseif (r_5851 == "number") then
		return copyOf1(node32)
	elseif (r_5851 == "symbol") then
		local copy1 = copyOf1(node32)
		local oldVar1 = node32["var"]
		local newVar1 = getVar2(oldVar1, lookup10)
		if ((oldVar1 ~= newVar1) and (oldVar1["node"] == node32)) then
			newVar1["node"] = copy1
		end
		copy1["var"] = newVar1
		return copy1
	elseif (r_5851 == "list") then
		if builtin_3f_1(car1(node32), "lambda") then
			local args8 = car1(cdr1(node32))
			if empty_3f_1(args8) then
			else
				local newScope3 = scope_2f_child1(getScope1(car1(args8)["var"]["scope"], lookup10, node32))
				local r_5991 = args8["n"]
				local r_5971 = nil
				r_5971 = (function(r_5981)
					if (r_5981 <= r_5991) then
						local arg22 = args8[r_5981]
						local var18 = arg22["var"]
						local newVar2 = scope_2f_add_21_1(newScope3, var18["name"], var18["tag"], nil)
						newVar2["isVariadic"] = var18["isVariadic"]
						lookup10["vars"][var18] = newVar2
						return r_5971((r_5981 + 1))
					else
					end
				end)
				r_5971(1)
			end
		end
		local res5 = copyOf1(node32)
		local r_6031 = res5["n"]
		local r_6011 = nil
		r_6011 = (function(r_6021)
			if (r_6021 <= r_6031) then
				res5[r_6021] = copyNode1(res5[r_6021], lookup10)
				return r_6011((r_6021 + 1))
			else
			end
		end)
		r_6011(1)
		return res5
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5851), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"key\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
scoreNode1 = (function(node33)
	local r_5871 = type1(node33)
	if (r_5871 == "string") then
		return 0
	elseif (r_5871 == "key") then
		return 0
	elseif (r_5871 == "number") then
		return 0
	elseif (r_5871 == "symbol") then
		return 1
	elseif (r_5871 == "list") then
		if (type1(car1(node33)) == "symbol") then
			local func5 = car1(node33)["var"]
			if (func5 == builtins1["lambda"]) then
				return scoreNodes1(node33, 3, 10)
			elseif (func5 == builtins1["cond"]) then
				return scoreNodes1(node33, 2, 10)
			elseif (func5 == builtins1["set!"]) then
				return scoreNodes1(node33, 2, 5)
			elseif (func5 == builtins1["quote"]) then
				return scoreNodes1(node33, 2, 2)
			elseif (func5 == builtins1["quasi-quote"]) then
				return scoreNodes1(node33, 2, 3)
			elseif (func5 == builtins1["unquote-splice"]) then
				return scoreNodes1(node33, 2, 10)
			else
				return scoreNodes1(node33, 1, (node33["n"] + 1))
			end
		else
			return scoreNodes1(node33, 1, (node33["n"] + 1))
		end
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5871), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"key\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
getScore1 = (function(lookup11, node34)
	local score1 = lookup11[node34]
	if (score1 == nil) then
		score1 = 0
		local r_5901 = node34[2]
		local r_5931 = r_5901["n"]
		local r_5911 = nil
		r_5911 = (function(r_5921)
			if (r_5921 <= r_5931) then
				if r_5901[r_5921]["var"]["isVariadic"] then
					score1 = false
				end
				return r_5911((r_5921 + 1))
			else
			end
		end)
		r_5911(1)
		if score1 then
			score1 = scoreNodes1(node34, 3, score1)
		end
		lookup11[node34] = score1
	end
	return (score1 or huge1)
end)
scoreNodes1 = (function(nodes14, start5, sum1)
	if (start5 > nodes14["n"]) then
		return sum1
	else
		local score2 = scoreNode1(nodes14[start5])
		if score2 then
			if (score2 > 20) then
				return score2
			else
				return scoreNodes1(nodes14, (start5 + 1), (sum1 + score2))
			end
		else
			return false
		end
	end
end)
inline1 = ({["name"]="inline",["help"]="Inline simple functions.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["level"]=2,["run"]=(function(r_47512, state18, nodes15, usage2)
	local scoreLookup1 = ({})
	return visitBlock1(nodes15, 1, (function(node35)
		if ((type1(node35) == "list") and (type1((car1(node35))) == "symbol")) then
			local func6 = car1(node35)["var"]
			local def3 = getVar1(usage2, func6)
			if (def3["defs"]["n"] == 1) then
				local ent2 = car1(def3["defs"])
				local val15 = ent2["value"]
				if ((type1(val15) == "list") and (builtin_3f_1(car1(val15), "lambda") and (getScore1(scoreLookup1, val15) <= 20))) then
					local copy2 = copyNode1(val15, ({["scopes"]=({}),["vars"]=({}),["root"]=func6["scope"]}))
					node35[1] = copy2
					r_47512["changed"] = true
					return nil
				else
				end
			else
			end
		else
		end
	end))
end)})
optimiseOnce1 = (function(nodes16, state19)
	local tracker2 = ({["changed"]=false})
	local r_3431 = state19["pass"]["normal"]
	local r_3461 = r_3431["n"]
	local r_3441 = nil
	r_3441 = (function(r_3451)
		if (r_3451 <= r_3461) then
			runPass1(r_3431[r_3451], state19, tracker2, nodes16)
			return r_3441((r_3451 + 1))
		else
		end
	end)
	r_3441(1)
	local lookup12 = ({["vars"]=({}),["nodes"]=({})})
	runPass1(tagUsage1, state19, tracker2, nodes16, lookup12)
	local r_6091 = state19["pass"]["usage"]
	local r_6121 = r_6091["n"]
	local r_6101 = nil
	r_6101 = (function(r_6111)
		if (r_6111 <= r_6121) then
			runPass1(r_6091[r_6111], state19, tracker2, nodes16, lookup12)
			return r_6101((r_6111 + 1))
		else
		end
	end)
	r_6101(1)
	return tracker2["changed"]
end)
optimise1 = (function(nodes17, state20)
	local maxN1 = state20["max-n"]
	local maxT1 = state20["max-time"]
	local iteration1 = 0
	local finish1 = (clock1() + maxT1)
	local changed1 = true
	local r_3481 = nil
	r_3481 = (function()
		if (changed1 and (((maxN1 < 0) or (iteration1 < maxN1)) and ((maxT1 < 0) or (clock1() < finish1)))) then
			changed1 = optimiseOnce1(nodes17, state20)
			iteration1 = (iteration1 + 1)
			return r_3481()
		else
		end
	end)
	return r_3481()
end)
default1 = (function()
	return ({["normal"]=list1(stripImport1, stripPure1, constantFold1, condFold1, lambdaFold1),["usage"]=list1(stripDefs1, stripArgs1, variableFold1, condEliminate1, expressionFold1, inline1)})
end)
builtins4 = require1("tacky.analysis.resolve")["builtins"]
tokens1 = ({tag = "list", n = 7, ({tag = "list", n = 2, "arg", "(%f[%a]%u+%f[%A])"}), ({tag = "list", n = 2, "mono", "```[a-z]*\n([^`]*)\n```"}), ({tag = "list", n = 2, "mono", "`([^`]*)`"}), ({tag = "list", n = 2, "bolic", "(%*%*%*%w.-%w%*%*%*)"}), ({tag = "list", n = 2, "bold", "(%*%*%w.-%w%*%*)"}), ({tag = "list", n = 2, "italic", "(%*%w.-%w%*)"}), ({tag = "list", n = 2, "link", "%[%[(.-)%]%]"})})
extractSignature1 = (function(var19)
	local ty4 = type1(var19)
	if ((ty4 == "macro") or (ty4 == "defined")) then
		local root2 = var19["node"]
		local node36 = root2[(root2["n"])]
		if ((type1(node36) == "list") and ((type1((car1(node36))) == "symbol") and (car1(node36)["var"] == builtins4["lambda"]))) then
			return node36[2]
		else
			return nil
		end
	else
		return nil
	end
end)
parseDocstring1 = (function(str3)
	local out9 = ({tag = "list", n = 0})
	local pos7 = 1
	local len9 = len1(str3)
	local r_6241 = nil
	r_6241 = (function()
		if (pos7 <= len9) then
			local spos1 = len9
			local epos1 = nil
			local name9 = nil
			local ptrn1 = nil
			local r_6291 = tokens1["n"]
			local r_6271 = nil
			r_6271 = (function(r_6281)
				if (r_6281 <= r_6291) then
					local tok1 = tokens1[r_6281]
					local npos1 = list1(find1(str3, tok1[2], pos7))
					if (car1(npos1) and (car1(npos1) < spos1)) then
						spos1 = car1(npos1)
						epos1 = npos1[2]
						name9 = car1(tok1)
						ptrn1 = tok1[2]
					end
					return r_6271((r_6281 + 1))
				else
				end
			end)
			r_6271(1)
			if name9 then
				if (pos7 < spos1) then
					pushCdr_21_1(out9, ({["tag"]="text",["contents"]=sub1(str3, pos7, (spos1 - 1))}))
				end
				pushCdr_21_1(out9, ({["tag"]=name9,["whole"]=sub1(str3, spos1, epos1),["contents"]=match1(sub1(str3, spos1, epos1), ptrn1)}))
				pos7 = (epos1 + 1)
			else
				pushCdr_21_1(out9, ({["tag"]="text",["contents"]=sub1(str3, pos7, len9)}))
				pos7 = (len9 + 1)
			end
			return r_6241()
		else
		end
	end)
	r_6241()
	return out9
end)
Scope1 = require1("tacky.analysis.scope")
checkArity1 = ({["name"]="check-arity",["help"]="Produce a warning if any NODE in NODES calls a function with too many arguments.\n\nLOOKUP is the variable usage lookup table.",["cat"]=({tag = "list", n = 2, "warn", "usage"}),["run"]=(function(r_47513, state21, nodes18, lookup13)
	local arity1
	local getArity1
	arity1 = ({})
	getArity1 = (function(symbol1)
		local var20 = getVar1(lookup13, symbol1["var"])
		local ari1 = arity1[var20]
		if (ari1 ~= nil) then
			return ari1
		elseif (var20["defs"]["n"] ~= 1) then
			return false
		else
			arity1[var20] = false
			local defData1 = car1(var20["defs"])
			local def4 = defData1["value"]
			if (defData1["tag"] == "var") then
				ari1 = false
			else
				if (type1(def4) == "symbol") then
					ari1 = getArity1(def4)
				elseif ((type1(def4) == "list") and ((type1((car1(def4))) == "symbol") and (car1(def4)["var"] == builtins1["lambda"]))) then
					local args9 = def4[2]
					if any1((function(x19)
						return x19["var"]["isVariadic"]
					end), args9) then
						ari1 = false
					else
						ari1 = args9["n"]
					end
				else
					ari1 = false
				end
			end
			arity1[var20] = ari1
			return ari1
		end
	end)
	return visitBlock1(nodes18, 1, (function(node37)
		if ((type1(node37) == "list") and (type1((car1(node37))) == "symbol")) then
			local arity2 = getArity1(car1(node37))
			if (arity2 and (arity2 < (node37["n"] - 1))) then
				return putNodeWarning_21_1(state21["logger"], _2e2e_2("Calling ", symbol_2d3e_string1(car1(node37)), " with ", tonumber1((node37["n"] - 1)), " arguments, expected ", tonumber1(arity2)), node37, nil, getSource1(node37), "Called here")
			else
			end
		else
		end
	end))
end)})
deprecated1 = ({["name"]="deprecated",["help"]="Produce a warning whenever a deprecated variable is used.",["cat"]=({tag = "list", n = 2, "warn", "usage"}),["run"]=(function(r_47514, state22, nodes19, lookup14)
	local r_6401 = nodes19["n"]
	local r_6381 = nil
	r_6381 = (function(r_6391)
		if (r_6391 <= r_6401) then
			local node38 = nodes19[r_6391]
			local defVar1 = node38["defVar"]
			visitNode1(node38, (function(node39)
				if (type1(node39) == "symbol") then
					local var21 = node39["var"]
					if ((var21 ~= defVar1) and var21["deprecated"]) then
						return putNodeWarning_21_1(state22["logger"], (function()
							if string_3f_1(var21["deprecated"]) then
								return format1("%s is deprecated: %s", node39["contents"], var21["deprecated"])
							else
								return format1("%s is deprecated.", node39["contents"])
							end
						end)()
						, node39, nil, getSource1(node39), "")
					else
					end
				else
				end
			end))
			return r_6381((r_6391 + 1))
		else
		end
	end)
	return r_6381(1)
end)})
documentation1 = ({["name"]="documentation",["help"]="Ensure doc comments are valid.",["cat"]=({tag = "list", n = 1, "warn"}),["run"]=(function(r_47515, state23, nodes20)
	local r_6471 = nodes20["n"]
	local r_6451 = nil
	r_6451 = (function(r_6461)
		if (r_6461 <= r_6471) then
			local node40 = nodes20[r_6461]
			local var22 = node40["defVar"]
			if var22 then
				local doc1 = var22["doc"]
				if doc1 then
					local r_6561 = parseDocstring1(doc1)
					local r_6591 = r_6561["n"]
					local r_6571 = nil
					r_6571 = (function(r_6581)
						if (r_6581 <= r_6591) then
							local tok2 = r_6561[r_6581]
							if (type1(tok2) == "link") then
								if Scope1["get"](var22["scope"], tok2["contents"]) then
								else
									putNodeWarning_21_1(state23["logger"], format1("%s is not defined.", quoted1(tok2["contents"])), node40, nil, getSource1(node40), "Referenced in docstring.")
								end
							end
							return r_6571((r_6581 + 1))
						else
						end
					end)
					r_6571(1)
				else
				end
			else
			end
			return r_6451((r_6461 + 1))
		else
		end
	end)
	return r_6451(1)
end)})
analyse1 = (function(nodes21, state24)
	local r_6161 = state24["pass"]["normal"]
	local r_6191 = r_6161["n"]
	local r_6171 = nil
	r_6171 = (function(r_6181)
		if (r_6181 <= r_6191) then
			runPass1(r_6161[r_6181], state24, nil, nodes21)
			return r_6171((r_6181 + 1))
		else
		end
	end)
	r_6171(1)
	local lookup15 = ({["vars"]=({}),["nodes"]=({})})
	runPass1(tagUsage1, state24, nil, nodes21, lookup15)
	local r_6501 = state24["pass"]["usage"]
	local r_6531 = r_6501["n"]
	local r_6511 = nil
	r_6511 = (function(r_6521)
		if (r_6521 <= r_6531) then
			runPass1(r_6501[r_6521], state24, nil, nodes21, lookup15)
			return r_6511((r_6521 + 1))
		else
		end
	end)
	return r_6511(1)
end)
create2 = (function()
	return ({["out"]=({tag = "list", n = 0}),["indent"]=0,["tabs-pending"]=false,["line"]=1,["lines"]=({}),["node-stack"]=({tag = "list", n = 0}),["active-pos"]=nil})
end)
append_21_1 = (function(writer1, text2)
	local r_6721 = type1(text2)
	if (r_6721 ~= "string") then
		error1(format1("bad argument %s (expected %s, got %s)", "text", "string", r_6721), 2)
	end
	local pos8 = writer1["active-pos"]
	if pos8 then
		local line1 = writer1["lines"][writer1["line"]]
		if line1 then
		else
			line1 = ({})
			writer1["lines"][writer1["line"]] = line1
		end
		line1[pos8] = true
	end
	if writer1["tabs-pending"] then
		writer1["tabs-pending"] = false
		pushCdr_21_1(writer1["out"], rep1("\9", writer1["indent"]))
	end
	return pushCdr_21_1(writer1["out"], text2)
end)
line_21_1 = (function(writer2, text3, force1)
	if text3 then
		append_21_1(writer2, text3)
	end
	if (force1 or not writer2["tabs-pending"]) then
		writer2["tabs-pending"] = true
		writer2["line"] = (writer2["line"] + 1)
		return pushCdr_21_1(writer2["out"], "\n")
	else
	end
end)
indent_21_1 = (function(writer3)
	writer3["indent"] = (writer3["indent"] + 1)
	return nil
end)
unindent_21_1 = (function(writer4)
	writer4["indent"] = (writer4["indent"] - 1)
	return nil
end)
beginBlock_21_1 = (function(writer5, text4)
	line_21_1(writer5, text4)
	writer5["indent"] = (writer5["indent"] + 1)
	return nil
end)
nextBlock_21_1 = (function(writer6, text5)
	writer6["indent"] = (writer6["indent"] - 1)
	line_21_1(writer6, text5)
	writer6["indent"] = (writer6["indent"] + 1)
	return nil
end)
endBlock_21_1 = (function(writer7, text6)
	writer7["indent"] = (writer7["indent"] - 1)
	return line_21_1(writer7, text6)
end)
pushNode_21_1 = (function(writer8, node41)
	local range2 = getSource1(node41)
	if range2 then
		pushCdr_21_1(writer8["node-stack"], node41)
		writer8["active-pos"] = range2
		return nil
	else
	end
end)
popNode_21_1 = (function(writer9, node42)
	if getSource1(node42) then
		local stack1 = writer9["node-stack"]
		local previous1 = last1(stack1)
		if (previous1 == node42) then
		else
			error1("Incorrect node popped")
		end
		popLast_21_1(stack1)
		writer9["arg-pos"] = last1(stack1)
		return nil
	else
	end
end)
estimateLength1 = (function(node43, max4)
	local tag8 = node43["tag"]
	if ((tag8 == "string") or ((tag8 == "number") or ((tag8 == "symbol") or (tag8 == "key")))) then
		return len1(tostring1(node43["contents"]))
	elseif (tag8 == "list") then
		local sum2 = 2
		local i6 = 1
		local r_6641 = nil
		r_6641 = (function()
			if ((sum2 <= max4) and (i6 <= node43["n"])) then
				sum2 = (sum2 + estimateLength1(node43[i6], (max4 - sum2)))
				if (i6 > 1) then
					sum2 = (sum2 + 1)
				end
				i6 = (i6 + 1)
				return r_6641()
			else
			end
		end)
		r_6641()
		return sum2
	else
		return error1(_2e2e_2("Unknown tag ", tag8), 0)
	end
end)
expression1 = (function(node44, writer10)
	local tag9 = node44["tag"]
	if (tag9 == "string") then
		return append_21_1(writer10, quoted1(node44["value"]))
	elseif (tag9 == "number") then
		return append_21_1(writer10, tostring1(node44["value"]))
	elseif (tag9 == "key") then
		return append_21_1(writer10, _2e2e_2(":", node44["value"]))
	elseif (tag9 == "symbol") then
		return append_21_1(writer10, node44["contents"])
	elseif (tag9 == "list") then
		append_21_1(writer10, "(")
		if empty_3f_1(node44) then
			return append_21_1(writer10, ")")
		else
			local newline1 = false
			local max5 = (60 - estimateLength1(car1(node44), 60))
			expression1(car1(node44), writer10)
			if (max5 <= 0) then
				newline1 = true
				writer10["indent"] = (writer10["indent"] + 1)
			end
			local r_6761 = node44["n"]
			local r_6741 = nil
			r_6741 = (function(r_6751)
				if (r_6751 <= r_6761) then
					local entry4 = node44[r_6751]
					if (not newline1 and (max5 > 0)) then
						max5 = (max5 - estimateLength1(entry4, max5))
						if (max5 <= 0) then
							newline1 = true
							writer10["indent"] = (writer10["indent"] + 1)
						end
					end
					if newline1 then
						line_21_1(writer10)
					else
						append_21_1(writer10, " ")
					end
					expression1(entry4, writer10)
					return r_6741((r_6751 + 1))
				else
				end
			end)
			r_6741(2)
			if newline1 then
				writer10["indent"] = (writer10["indent"] - 1)
			end
			return append_21_1(writer10, ")")
		end
	else
		return error1(_2e2e_2("Unknown tag ", tag9), 0)
	end
end)
block1 = (function(list4, writer11)
	local r_6701 = list4["n"]
	local r_6681 = nil
	r_6681 = (function(r_6691)
		if (r_6691 <= r_6701) then
			expression1(list4[r_6691], writer11)
			line_21_1(writer11)
			return r_6681((r_6691 + 1))
		else
		end
	end)
	return r_6681(1)
end)
cat3 = (function(category1, ...)
	local args10 = _pack(...) args10.tag = "list"
	return struct1("category", category1, unpack1(args10, 1, args10["n"]))
end)
partAll1 = (function(xs12, i7, e1, f3)
	if (i7 > e1) then
		return true
	elseif f3(xs12[i7]) then
		return partAll1(xs12, (i7 + 1), e1, f3)
	else
		return false
	end
end)
visitNode2 = (function(lookup16, node45, stmt1, test2, recur1)
	local cat4
	local r_6891 = type1(node45)
	if (r_6891 == "string") then
		cat4 = cat3("const")
	elseif (r_6891 == "number") then
		cat4 = cat3("const")
	elseif (r_6891 == "key") then
		cat4 = cat3("const")
	elseif (r_6891 == "symbol") then
		cat4 = cat3("const")
	elseif (r_6891 == "list") then
		local head4 = car1(node45)
		local r_6901 = type1(head4)
		if (r_6901 == "symbol") then
			local func7 = head4["var"]
			local funct3 = func7["tag"]
			if (func7 == builtins1["lambda"]) then
				visitNodes1(lookup16, node45, 3, true)
				cat4 = cat3("lambda")
			elseif (func7 == builtins1["cond"]) then
				local r_7191 = node45["n"]
				local r_7171 = nil
				r_7171 = (function(r_7181)
					if (r_7181 <= r_7191) then
						local case3 = node45[r_7181]
						visitNode2(lookup16, car1(case3), true, true)
						visitNodes1(lookup16, case3, 2, true, test2, recur1)
						return r_7171((r_7181 + 1))
					else
					end
				end)
				r_7171(2)
				local temp6
				if (node45["n"] == 3) then
					local temp7
					local sub2 = node45[2]
					temp7 = ((sub2["n"] == 2) and builtin_3f_1(sub2[2], "false"))
					if temp7 then
						local sub3 = node45[3]
						temp6 = ((sub3["n"] == 2) and (builtin_3f_1(sub3[1], "true") and builtin_3f_1(sub3[2], "true")))
					else
						temp6 = false
					end
				else
					temp6 = false
				end
				if temp6 then
					cat4 = cat3("not", "stmt", lookup16[car1(node45[2])]["stmt"])
				else
					local temp8
					if (node45["n"] == 3) then
						local first6 = node45[2]
						local second1 = node45[3]
						local branch1 = car1(first6)
						local last5 = second1[2]
						temp8 = ((first6["n"] == 2) and ((second1["n"] == 2) and (not lookup16[first6[2]]["stmt"] and (builtin_3f_1(car1(second1), "true") and ((type1(last5) == "symbol") and (((type1(branch1) == "symbol") and (branch1["var"] == last5["var"])) or (test2 and (not lookup16[branch1]["stmt"] and (last5["var"] == builtins1["false"])))))))))
					else
						temp8 = false
					end
					if temp8 then
						cat4 = cat3("and")
					else
						local temp9
						if (node45["n"] >= 3) then
							if partAll1(node45, 2, (node45["n"] - 1), (function(branch2)
								local head5 = car1(branch2)
								local tail1 = branch2[2]
								return ((branch2["n"] == 2) and ((type1(tail1) == "symbol") and (((type1(head5) == "symbol") and (head5["var"] == tail1["var"])) or (test2 and (not lookup16[head5]["stmt"] and (tail1["var"] == builtins1["true"]))))))
							end)) then
								local branch3 = last1(node45)
								temp9 = ((branch3["n"] == 2) and (builtin_3f_1(car1(branch3), "true") and not lookup16[branch3[2]]["stmt"]))
							else
								temp9 = false
							end
						else
							temp9 = false
						end
						if temp9 then
							cat4 = cat3("or")
						else
							cat4 = cat3("cond", "stmt", true)
						end
					end
				end
			elseif (func7 == builtins1["set!"]) then
				visitNode2(lookup16, node45[3], true)
				cat4 = cat3("set!")
			elseif (func7 == builtins1["quote"]) then
				visitQuote2(lookup16, node45)
				cat4 = cat3("quote")
			elseif (func7 == builtins1["syntax-quote"]) then
				visitSyntaxQuote1(lookup16, node45[2], 1)
				cat4 = cat3("syntax-quote")
			elseif (func7 == builtins1["unquote"]) then
				cat4 = error1("unquote should never appear", 0)
			elseif (func7 == builtins1["unquote-splice"]) then
				cat4 = error1("unquote should never appear", 0)
			elseif ((func7 == builtins1["define"]) or (func7 == builtins1["define-macro"])) then
				local def5 = node45[(node45["n"])]
				if ((type1(def5) == "list") and builtin_3f_1(car1(def5), "lambda")) then
					local recur2 = ({["var"]=node45["defVar"],["def"]=def5})
					visitNodes1(lookup16, def5, 3, true, nil, recur2)
					lookup16[def5] = (function()
						if recur2["tail"] then
							return cat3("lambda", "recur", recur2)
						else
							return cat3("lambda")
						end
					end)()
				else
					visitNode2(lookup16, def5, true)
				end
				cat4 = cat3("define")
			elseif (func7 == builtins1["define-native"]) then
				cat4 = cat3("define-native")
			elseif (func7 == builtins1["import"]) then
				cat4 = cat3("import")
			elseif (func7 == builtins1["struct-literal"]) then
				visitNodes1(lookup16, node45, 2, false)
				cat4 = cat3("struct-literal")
			elseif (func7 == builtins1["true"]) then
				visitNodes1(lookup16, node45, 1, false)
				cat4 = cat3("call-literal")
			elseif (func7 == builtins1["false"]) then
				visitNodes1(lookup16, node45, 1, false)
				cat4 = cat3("call-literal")
			elseif (func7 == builtins1["nil"]) then
				visitNodes1(lookup16, node45, 1, false)
				cat4 = cat3("call-literal")
			else
				visitNodes1(lookup16, node45, 1, false)
				if (recur1 and (func7 == recur1["var"])) then
					recur1["tail"] = true
					cat4 = cat3("call-symbol", "recur", recur1)
				else
					cat4 = cat3("call-symbol")
				end
			end
		elseif (r_6901 == "list") then
			if ((node45["n"] == 2) and (builtin_3f_1(car1(head4), "lambda") and ((head4["n"] == 3) and ((head4[2]["n"] == 1) and ((type1((head4[3])) == "symbol") and (head4[3]["var"] == car1(head4[2])["var"])))))) then
				if visitNode2(lookup16, node45[2], stmt1, test2)["stmt"] then
					visitNode2(lookup16, head4, true)
					if stmt1 then
						cat4 = cat3("call-lambda", "stmt", true)
					else
						cat4 = cat3("call")
					end
				else
					cat4 = cat3("wrap-value")
				end
			else
				local temp10
				if (node45["n"] == 2) then
					if builtin_3f_1(car1(head4), "lambda") then
						if (head4["n"] == 3) then
							if (head4[2]["n"] == 1) then
								local elem7 = head4[3]
								temp10 = ((type1(elem7) == "list") and (builtin_3f_1(car1(elem7), "cond") and ((type1((car1(elem7[2]))) == "symbol") and (car1(elem7[2])["var"] == car1(head4[2])["var"]))))
							else
								temp10 = false
							end
						else
							temp10 = false
						end
					else
						temp10 = false
					end
				else
					temp10 = false
				end
				if temp10 then
					if visitNode2(lookup16, node45[2], stmt1, test2)["stmt"] then
						lookup16[head4] = cat3("lambda")
						local r_7631 = head4["n"]
						local r_7611 = nil
						r_7611 = (function(r_7621)
							if (r_7621 <= r_7631) then
								visitNode2(lookup16, head4[r_7621], true, test2)
								return r_7611((r_7621 + 1))
							else
							end
						end)
						r_7611(3)
						if stmt1 then
							cat4 = cat3("call-lambda", "stmt", true)
						else
							cat4 = cat3("call")
						end
					else
						local res6 = visitNode2(lookup16, head4[3], true, test2)
						local ty5 = res6["category"]
						lookup16[head4] = cat3("lambda")
						if (ty5 == "and") then
							cat4 = cat3("and-lambda")
						elseif (ty5 == "or") then
							cat4 = cat3("or-lambda")
						elseif stmt1 then
							cat4 = cat3("call-lambda", "stmt", true)
						else
							cat4 = cat3("call")
						end
					end
				elseif (stmt1 and builtin_3f_1(car1(head4), "lambda")) then
					visitNodes1(lookup16, car1(node45), 3, true, test2, recur1)
					local lam4 = car1(node45)
					local args11 = lam4[2]
					local offset3 = 1
					local r_7681 = args11["n"]
					local r_7661 = nil
					r_7661 = (function(r_7671)
						if (r_7671 <= r_7681) then
							if args11[r_7671]["var"]["isVariadic"] then
								local count3 = (node45["n"] - args11["n"])
								if (count3 < 0) then
									count3 = 0
								end
								local r_7721 = count3
								local r_7701 = nil
								r_7701 = (function(r_7711)
									if (r_7711 <= r_7721) then
										visitNode2(lookup16, node45[((r_7671 + r_7711))], false)
										return r_7701((r_7711 + 1))
									else
									end
								end)
								r_7701(1)
								offset3 = count3
							else
								local val16 = node45[((r_7671 + offset3))]
								if val16 then
									visitNode2(lookup16, val16, true)
								end
							end
							return r_7661((r_7671 + 1))
						else
						end
					end)
					r_7661(1)
					local r_7761 = node45["n"]
					local r_7741 = nil
					r_7741 = (function(r_7751)
						if (r_7751 <= r_7761) then
							visitNode2(lookup16, node45[r_7751], true)
							return r_7741((r_7751 + 1))
						else
						end
					end)
					r_7741((args11["n"] + (offset3 + 1)))
					cat4 = cat3("call-lambda", "stmt", true)
				elseif (builtin_3f_1(car1(head4), "quote") or builtin_3f_1(car1(head4), "syntax-quote")) then
					visitNodes1(lookup16, node45, 1, false)
					cat4 = cat3("call-literal")
				else
					visitNodes1(lookup16, node45, 1, false)
					cat4 = cat3("call")
				end
			end
		elseif eq_3f_1(r_6901, true) then
			visitNodes1(lookup16, node45, 1, false)
			cat4 = cat3("call-literal")
		else
			cat4 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6901), ", but none matched.\n", "  Tried: `\"symbol\"`\n  Tried: `\"list\"`\n  Tried: `true`"))
		end
	else
		cat4 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6891), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
	if (cat4 == nil) then
		error1(_2e2e_2("Node returned nil ", pretty1(node45)), 0)
	end
	lookup16[node45] = cat4
	return cat4
end)
visitNodes1 = (function(lookup17, nodes22, start6, stmt2, test3, recur3)
	local len10 = nodes22["n"]
	local r_6911 = nil
	r_6911 = (function(r_6921)
		if (r_6921 <= len10) then
			visitNode2(lookup17, nodes22[r_6921], stmt2, (test3 and (r_6921 == len10)), ((r_6921 == len10) and recur3))
			return r_6911((r_6921 + 1))
		else
		end
	end)
	return r_6911(start6)
end)
visitSyntaxQuote1 = (function(lookup18, node46, level4)
	if (level4 == 0) then
		return visitNode2(lookup18, node46, false)
	else
		local cat5
		local r_6971 = type1(node46)
		if (r_6971 == "string") then
			cat5 = cat3("quote-const")
		elseif (r_6971 == "number") then
			cat5 = cat3("quote-const")
		elseif (r_6971 == "key") then
			cat5 = cat3("quote-const")
		elseif (r_6971 == "symbol") then
			cat5 = cat3("quote-const")
		elseif (r_6971 == "list") then
			local r_6981 = car1(node46)
			if eq_3f_1(r_6981, ({ tag="symbol", contents="unquote"})) then
				visitSyntaxQuote1(lookup18, node46[2], (level4 - 1))
				cat5 = cat3("unquote")
			elseif eq_3f_1(r_6981, ({ tag="symbol", contents="unquote-splice"})) then
				visitSyntaxQuote1(lookup18, node46[2], (level4 - 1))
				cat5 = cat3("unquote-splice")
			elseif eq_3f_1(r_6981, ({ tag="symbol", contents="syntax-quote"})) then
				local r_7031 = node46["n"]
				local r_7011 = nil
				r_7011 = (function(r_7021)
					if (r_7021 <= r_7031) then
						visitSyntaxQuote1(lookup18, node46[r_7021], (level4 + 1))
						return r_7011((r_7021 + 1))
					else
					end
				end)
				r_7011(1)
				cat5 = cat3("quote-list")
			else
				local hasSplice1 = false
				local r_7091 = node46["n"]
				local r_7071 = nil
				r_7071 = (function(r_7081)
					if (r_7081 <= r_7091) then
						if (visitSyntaxQuote1(lookup18, node46[r_7081], level4)["category"] == "unquote-splice") then
							hasSplice1 = true
						end
						return r_7071((r_7081 + 1))
					else
					end
				end)
				r_7071(1)
				if hasSplice1 then
					cat5 = cat3("quote-splice", "stmt", true)
				else
					cat5 = cat3("quote-list")
				end
			end
		else
			cat5 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6971), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
		end
		if (cat5 == nil) then
			error1(_2e2e_2("Node returned nil ", pretty1(node46)), 0)
		end
		lookup18[node46] = cat5
		return cat5
	end
end)
visitQuote2 = (function(lookup19, node47)
	if (type1(node47) == "list") then
		local r_7151 = node47["n"]
		local r_7131 = nil
		r_7131 = (function(r_7141)
			if (r_7141 <= r_7151) then
				visitQuote2(lookup19, (node47[r_7141]))
				return r_7131((r_7141 + 1))
			else
			end
		end)
		r_7131(1)
		lookup19[node47] = cat3("quote-list")
		return nil
	else
		lookup19[node47] = cat3("quote-const")
		return nil
	end
end)
categoriseNodes1 = ({["name"]="categorise-nodes",["help"]="Categorise a group of NODES, annotating their appropriate node type.",["cat"]=({tag = "list", n = 1, "categorise"}),["run"]=(function(r_47516, state25, nodes23, lookup20)
	return visitNodes1(lookup20, nodes23, 1, true)
end)})
categoriseNode1 = ({["name"]="categorise-node",["help"]="Categorise a NODE, annotating it's appropriate node type.",["cat"]=({tag = "list", n = 1, "categorise"}),["run"]=(function(r_47517, state26, node48, lookup21, stmt3)
	return visitNode2(lookup21, node48, stmt3)
end)})
keywords1 = createLookup1(({tag = "list", n = 21, "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}))
escape1 = (function(name10)
	if (name10 == "") then
		return "_e"
	elseif keywords1[name10] then
		return _2e2e_2("_e", name10)
	elseif find1(name10, "^%w[_%w%d]*$") then
		return name10
	else
		local out10
		if find1(sub1(name10, 1, 1), "%d") then
			out10 = "_e"
		else
			out10 = ""
		end
		local upper2 = false
		local esc1 = false
		local r_7811 = len1(name10)
		local r_7791 = nil
		r_7791 = (function(r_7801)
			if (r_7801 <= r_7811) then
				local char2 = sub1(name10, r_7801, r_7801)
				if ((char2 == "-") and (find1((function(x20)
					return sub1(name10, x20, x20)
				end)((r_7801 - 1)), "[%a%d']") and find1((function(x21)
					return sub1(name10, x21, x21)
				end)((r_7801 + 1)), "[%a%d']"))) then
					upper2 = true
				elseif find1(char2, "[^%w%d]") then
					char2 = format1("%02x", (byte1(char2)))
					if esc1 then
					else
						esc1 = true
						out10 = _2e2e_2(out10, "_")
					end
					out10 = _2e2e_2(out10, char2)
				else
					if esc1 then
						esc1 = false
						out10 = _2e2e_2(out10, "_")
					end
					if upper2 then
						upper2 = false
						char2 = upper1(char2)
					end
					out10 = _2e2e_2(out10, char2)
				end
				return r_7791((r_7801 + 1))
			else
			end
		end)
		r_7791(1)
		if esc1 then
			out10 = _2e2e_2(out10, "_")
		end
		return out10
	end
end)
escapeVar1 = (function(var23, state27)
	if builtinVars1[var23] then
		return var23["name"]
	else
		local v4 = escape1(var23["name"])
		local id2 = state27["var-lookup"][var23]
		if id2 then
		else
			id2 = ((state27["ctr-lookup"][v4] or 0) + 1)
			state27["ctr-lookup"][v4] = id2
			state27["var-lookup"][var23] = id2
		end
		return _2e2e_2(v4, tostring1(id2))
	end
end)
truthy_3f_1 = (function(node49)
	return ((type1(node49) == "symbol") and (builtins1["true"] == node49["var"]))
end)
boringCategories1 = ({["const"]=true,["quote"]=true,["not"]=true,["cond"]=true})
compileNative1 = (function(out11, meta2)
	local ty6 = type1(meta2)
	if (ty6 == "var") then
		return append_21_1(out11, meta2["contents"])
	elseif ((ty6 == "expr") or (ty6 == "stmt")) then
		append_21_1(out11, "function(")
		local r_7971 = meta2["count"]
		local r_7951 = nil
		r_7951 = (function(r_7961)
			if (r_7961 <= r_7971) then
				if (r_7961 == 1) then
				else
					append_21_1(out11, ", ")
				end
				append_21_1(out11, _2e2e_2("v", tonumber1(r_7961)))
				return r_7951((r_7961 + 1))
			else
			end
		end)
		r_7951(1)
		if meta2["fold"] then
			append_21_1(out11, ", ...")
		end
		append_21_1(out11, ") ")
		if (meta2["tag"] == "stmt") then
		elseif meta2["fold"] then
			append_21_1(out11, "local t = ")
		else
			append_21_1(out11, "return ")
		end
		local r_8001 = meta2["contents"]
		local r_8031 = r_8001["n"]
		local r_8011 = nil
		r_8011 = (function(r_8021)
			if (r_8021 <= r_8031) then
				local entry5 = r_8001[r_8021]
				if number_3f_1(entry5) then
					append_21_1(out11, _2e2e_2("v", tonumber1(entry5)))
				else
					append_21_1(out11, entry5)
				end
				return r_8011((r_8021 + 1))
			else
			end
		end)
		r_8011(1)
		local r_8051 = meta2["fold"]
		if eq_3f_1(r_8051, nil) then
		elseif (r_8051 == "l") then
			append_21_1(out11, " for i = 1, _select('#', ...) do t = ")
			local r_8071 = meta2["contents"]
			local r_8101 = r_8071["n"]
			local r_8081 = nil
			r_8081 = (function(r_8091)
				if (r_8091 <= r_8101) then
					local node50 = r_8071[r_8091]
					if (node50 == 1) then
						append_21_1(out11, "t")
					elseif (node50 == 2) then
						append_21_1(out11, "_select(i, ...)")
					elseif string_3f_1(node50) then
						append_21_1(out11, node50)
					else
						error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(node50), ", but none matched.\n", "  Tried: `1`\n  Tried: `2`\n  Tried: `string?`"))
					end
					return r_8081((r_8091 + 1))
				else
				end
			end)
			r_8081(1)
			append_21_1(out11, " end return t")
		elseif (r_8051 == "r") then
			append_21_1(out11, " for i = _select('#', ...), 1, -1 do t = ")
			local r_8141 = meta2["contents"]
			local r_8171 = r_8141["n"]
			local r_8151 = nil
			r_8151 = (function(r_8161)
				if (r_8161 <= r_8171) then
					local node51 = r_8141[r_8161]
					if (node51 == 1) then
						append_21_1(out11, "_select(i, ...)")
					elseif (node51 == 2) then
						append_21_1(out11, "t")
					elseif string_3f_1(node51) then
						append_21_1(out11, node51)
					else
						error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(node51), ", but none matched.\n", "  Tried: `1`\n  Tried: `2`\n  Tried: `string?`"))
					end
					return r_8151((r_8161 + 1))
				else
				end
			end)
			r_8151(1)
			append_21_1(out11, " end return t")
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_8051), ", but none matched.\n", "  Tried: `nil`\n  Tried: `\"l\"`\n  Tried: `\"r\"`"))
		end
		return append_21_1(out11, " end")
	else
		_error("unmatched item")
	end
end)
compileExpression1 = (function(node52, out12, state28, ret1)
	local catLookup1 = state28["cat-lookup"]
	local cat6 = catLookup1[node52]
	local _5f_2
	if cat6 then
	else
		_5f_2 = print1("Cannot find", pretty1(node52), formatNode1(node52))
	end
	local catTag1 = cat6["category"]
	if boringCategories1[catTag1] then
	else
		pushNode_21_1(out12, node52)
	end
	if (catTag1 == "const") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out12, ret1)
			end
			if (type1(node52) == "symbol") then
				append_21_1(out12, escapeVar1(node52["var"], state28))
			elseif string_3f_1(node52) then
				append_21_1(out12, quoted1(node52["value"]))
			elseif number_3f_1(node52) then
				append_21_1(out12, tostring1(node52["value"]))
			elseif (type1(node52) == "key") then
				append_21_1(out12, quoted1(node52["value"]))
			else
				error1(_2e2e_2("Unknown type: ", type1(node52)))
			end
		end
	elseif (catTag1 == "lambda") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out12, ret1)
			end
			local args12 = node52[2]
			local variadic1 = nil
			local i8 = 1
			append_21_1(out12, "(function(")
			local r_8211 = nil
			r_8211 = (function()
				if ((i8 <= args12["n"]) and not variadic1) then
					if (i8 > 1) then
						append_21_1(out12, ", ")
					end
					local var24 = args12[i8]["var"]
					if var24["isVariadic"] then
						append_21_1(out12, "...")
						variadic1 = i8
					else
						append_21_1(out12, escapeVar1(var24, state28))
					end
					i8 = (i8 + 1)
					return r_8211()
				else
				end
			end)
			r_8211()
			line_21_1(out12, ")")
			out12["indent"] = (out12["indent"] + 1)
			if variadic1 then
				local argsVar1 = escapeVar1(args12[variadic1]["var"], state28)
				if (variadic1 == args12["n"]) then
					line_21_1(out12, _2e2e_2("local ", argsVar1, " = _pack(...) ", argsVar1, ".tag = \"list\""))
				else
					local remaining1 = (args12["n"] - variadic1)
					line_21_1(out12, _2e2e_2("local _n = _select(\"#\", ...) - ", tostring1(remaining1)))
					append_21_1(out12, _2e2e_2("local ", argsVar1))
					local r_8251 = args12["n"]
					local r_8231 = nil
					r_8231 = (function(r_8241)
						if (r_8241 <= r_8251) then
							append_21_1(out12, ", ")
							append_21_1(out12, escapeVar1(args12[r_8241]["var"], state28))
							return r_8231((r_8241 + 1))
						else
						end
					end)
					r_8231((variadic1 + 1))
					line_21_1(out12)
					line_21_1(out12, "if _n > 0 then")
					out12["indent"] = (out12["indent"] + 1)
					append_21_1(out12, argsVar1)
					line_21_1(out12, " = { tag=\"list\", n=_n, _unpack(_pack(...), 1, _n)}")
					local r_8291 = args12["n"]
					local r_8271 = nil
					r_8271 = (function(r_8281)
						if (r_8281 <= r_8291) then
							append_21_1(out12, escapeVar1(args12[r_8281]["var"], state28))
							if (r_8281 < args12["n"]) then
								append_21_1(out12, ", ")
							end
							return r_8271((r_8281 + 1))
						else
						end
					end)
					r_8271((variadic1 + 1))
					line_21_1(out12, " = select(_n + 1, ...)")
					out12["indent"] = (out12["indent"] - 1)
					line_21_1(out12, "else")
					out12["indent"] = (out12["indent"] + 1)
					append_21_1(out12, argsVar1)
					line_21_1(out12, " = { tag=\"list\", n=0}")
					local r_8331 = args12["n"]
					local r_8311 = nil
					r_8311 = (function(r_8321)
						if (r_8321 <= r_8331) then
							append_21_1(out12, escapeVar1(args12[r_8321]["var"], state28))
							if (r_8321 < args12["n"]) then
								append_21_1(out12, ", ")
							end
							return r_8311((r_8321 + 1))
						else
						end
					end)
					r_8311((variadic1 + 1))
					line_21_1(out12, " = ...")
					out12["indent"] = (out12["indent"] - 1)
					line_21_1(out12, "end")
				end
			end
			if cat6["recur"] then
				line_21_1(out12, "while true do")
				out12["indent"] = (out12["indent"] + 1)
			end
			compileBlock1(node52, out12, state28, 3, "return ")
			if cat6["recur"] then
				out12["indent"] = (out12["indent"] - 1)
				line_21_1(out12, "end")
			end
			out12["indent"] = (out12["indent"] - 1)
			append_21_1(out12, "end)")
		end
	elseif (catTag1 == "cond") then
		local closure1 = not ret1
		local hadFinal1 = false
		local ends1 = 1
		if closure1 then
			line_21_1(out12, "(function()")
			out12["indent"] = (out12["indent"] + 1)
			ret1 = "return "
		end
		local i9 = 2
		local r_8351 = nil
		r_8351 = (function()
			if (not hadFinal1 and (i9 <= node52["n"])) then
				local item1 = node52[i9]
				local case4 = item1[1]
				local isFinal1 = truthy_3f_1(case4)
				if ((i9 > 2) and (not isFinal1 or ((ret1 ~= "") or (item1["n"] ~= 1)))) then
					append_21_1(out12, "else")
				end
				if isFinal1 then
					if (i9 == 2) then
						append_21_1(out12, "do")
					end
				elseif catLookup1[case4]["stmt"] then
					if (i9 > 2) then
						out12["indent"] = (out12["indent"] + 1)
						line_21_1(out12)
						ends1 = (ends1 + 1)
					end
					local tmp1 = escapeVar1(({["name"]="temp"}), state28)
					line_21_1(out12, _2e2e_2("local ", tmp1))
					compileExpression1(case4, out12, state28, _2e2e_2(tmp1, " = "))
					line_21_1(out12)
					line_21_1(out12, _2e2e_2("if ", tmp1, " then"))
				else
					append_21_1(out12, "if ")
					compileExpression1(case4, out12, state28)
					append_21_1(out12, " then")
				end
				out12["indent"] = (out12["indent"] + 1)
				line_21_1(out12)
				compileBlock1(item1, out12, state28, 2, ret1)
				out12["indent"] = (out12["indent"] - 1)
				if isFinal1 then
					hadFinal1 = true
				end
				i9 = (i9 + 1)
				return r_8351()
			else
			end
		end)
		r_8351()
		if hadFinal1 then
		else
			append_21_1(out12, "else")
			out12["indent"] = (out12["indent"] + 1)
			line_21_1(out12)
			append_21_1(out12, "_error(\"unmatched item\")")
			out12["indent"] = (out12["indent"] - 1)
			line_21_1(out12)
		end
		local r_8421 = ends1
		local r_8401 = nil
		r_8401 = (function(r_8411)
			if (r_8411 <= r_8421) then
				append_21_1(out12, "end")
				if (r_8411 < ends1) then
					out12["indent"] = (out12["indent"] - 1)
					line_21_1(out12)
				end
				return r_8401((r_8411 + 1))
			else
			end
		end)
		r_8401(1)
		if closure1 then
			line_21_1(out12)
			out12["indent"] = (out12["indent"] - 1)
			line_21_1(out12, "end)()")
		end
	elseif (catTag1 == "not") then
		if ret1 then
			ret1 = _2e2e_2(ret1, "not ")
		else
			append_21_1(out12, "not ")
		end
		compileExpression1(car1(node52[2]), out12, state28, ret1)
	elseif (catTag1 == "or") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		local len11 = node52["n"]
		local r_8441 = nil
		r_8441 = (function(r_8451)
			if (r_8451 <= len11) then
				if (r_8451 > 2) then
					append_21_1(out12, " or ")
				end
				compileExpression1(node52[r_8451][(function(idx6)
					return idx6
				end)((function()
					if (r_8451 == len11) then
						return 2
					else
						return 1
					end
				end)()
				)], out12, state28)
				return r_8441((r_8451 + 1))
			else
			end
		end)
		r_8441(2)
		append_21_1(out12, ")")
	elseif (catTag1 == "or-lambda") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		compileExpression1(node52[2], out12, state28)
		local branch4 = car1(node52)[3]
		local len12 = branch4["n"]
		local r_8481 = nil
		r_8481 = (function(r_8491)
			if (r_8491 <= len12) then
				append_21_1(out12, " or ")
				compileExpression1(branch4[r_8491][(function(idx7)
					return idx7
				end)((function()
					if (r_8491 == len12) then
						return 2
					else
						return 1
					end
				end)()
				)], out12, state28)
				return r_8481((r_8491 + 1))
			else
			end
		end)
		r_8481(3)
		append_21_1(out12, ")")
	elseif (catTag1 == "and") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		compileExpression1(node52[2][1], out12, state28)
		append_21_1(out12, " and ")
		compileExpression1(node52[2][2], out12, state28)
		append_21_1(out12, ")")
	elseif (catTag1 == "and-lambda") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		compileExpression1(node52[2], out12, state28)
		append_21_1(out12, " and ")
		compileExpression1(car1(node52)[3][2][2], out12, state28)
		append_21_1(out12, ")")
	elseif (catTag1 == "set!") then
		compileExpression1(node52[3], out12, state28, _2e2e_2(escapeVar1(node52[2]["var"], state28), " = "))
		if (ret1 and (ret1 ~= "")) then
			line_21_1(out12)
			append_21_1(out12, ret1)
			append_21_1(out12, "nil")
		end
	elseif (catTag1 == "struct-literal") then
		if (ret1 == "") then
			append_21_1(out12, "local _ = ")
		elseif ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "({")
		local r_8551 = node52["n"]
		local r_8531 = nil
		r_8531 = (function(r_8541)
			if (r_8541 <= r_8551) then
				if (r_8541 > 2) then
					append_21_1(out12, ",")
				end
				append_21_1(out12, "[")
				compileExpression1(node52[r_8541], out12, state28)
				append_21_1(out12, "]=")
				compileExpression1(node52[((r_8541 + 1))], out12, state28)
				return r_8531((r_8541 + 2))
			else
			end
		end)
		r_8531(2)
		append_21_1(out12, "})")
	elseif (catTag1 == "define") then
		compileExpression1(node52[(node52["n"])], out12, state28, _2e2e_2(escapeVar1(node52["defVar"], state28), " = "))
	elseif (catTag1 == "define-native") then
		local meta3 = state28["meta"][node52["defVar"]["fullName"]]
		if (meta3 == nil) then
			append_21_1(out12, format1("%s = _libs[%q]", escapeVar1(node52["defVar"], state28), node52["defVar"]["fullName"]))
		else
			append_21_1(out12, format1("%s = ", escapeVar1(node52["defVar"], state28)))
			compileNative1(out12, meta3)
		end
	elseif (catTag1 == "quote") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out12, ret1)
			end
			compileExpression1(node52[2], out12, state28)
		end
	elseif (catTag1 == "quote-const") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out12, ret1)
			end
			local r_8571 = type1(node52)
			if (r_8571 == "string") then
				append_21_1(out12, quoted1(node52["value"]))
			elseif (r_8571 == "number") then
				append_21_1(out12, tostring1(node52["value"]))
			elseif (r_8571 == "symbol") then
				append_21_1(out12, _2e2e_2("({ tag=\"symbol\", contents=", quoted1(node52["contents"])))
				if node52["var"] then
					append_21_1(out12, _2e2e_2(", var=", quoted1(tostring1(node52["var"]))))
				end
				append_21_1(out12, "})")
			elseif (r_8571 == "key") then
				append_21_1(out12, _2e2e_2("({tag=\"key\", value=", quoted1(node52["value"]), "})"))
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_8571), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"key\"`"))
			end
		end
	elseif (catTag1 == "quote-list") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, _2e2e_2("({tag = \"list\", n = ", tostring1(node52["n"])))
		local r_8621 = node52["n"]
		local r_8601 = nil
		r_8601 = (function(r_8611)
			if (r_8611 <= r_8621) then
				local sub4 = node52[r_8611]
				append_21_1(out12, ", ")
				compileExpression1(sub4, out12, state28)
				return r_8601((r_8611 + 1))
			else
			end
		end)
		r_8601(1)
		append_21_1(out12, "})")
	elseif (catTag1 == "quote-splice") then
		if ret1 then
		else
			line_21_1(out12, "(function()")
			out12["indent"] = (out12["indent"] + 1)
		end
		line_21_1(out12, "local _offset, _result, _temp = 0, {tag=\"list\",n=0}")
		local offset4 = 0
		local r_8661 = node52["n"]
		local r_8641 = nil
		r_8641 = (function(r_8651)
			if (r_8651 <= r_8661) then
				local sub5 = node52[r_8651]
				local cat7 = state28["cat-lookup"][sub5]
				if cat7 then
				else
					print1("Cannot find", pretty1(sub5), formatNode1(sub5))
				end
				if (cat7["category"] == "unquote-splice") then
					offset4 = (offset4 + 1)
					append_21_1(out12, "_temp = ")
					compileExpression1(sub5[2], out12, state28)
					line_21_1(out12)
					line_21_1(out12, _2e2e_2("for _c = 1, _temp.n do _result[", tostring1((r_8651 - offset4)), " + _c + _offset] = _temp[_c] end"))
					line_21_1(out12, "_offset = _offset + _temp.n")
				else
					append_21_1(out12, _2e2e_2("_result[", tostring1((r_8651 - offset4)), " + _offset] = "))
					compileExpression1(sub5, out12, state28)
					line_21_1(out12)
				end
				return r_8641((r_8651 + 1))
			else
			end
		end)
		r_8641(1)
		line_21_1(out12, _2e2e_2("_result.n = _offset + ", tostring1((node52["n"] - offset4))))
		if (ret1 == "") then
		elseif ret1 then
			append_21_1(out12, _2e2e_2(ret1, "_result"))
		else
			line_21_1(out12, "return _result")
			out12["indent"] = (out12["indent"] - 1)
			line_21_1(out12, "end)()")
		end
	elseif (catTag1 == "syntax-quote") then
		compileExpression1(node52[2], out12, state28, ret1)
	elseif (catTag1 == "unquote") then
		compileExpression1(node52[2], out12, state28, ret1)
	elseif (catTag1 == "unquote-splice") then
		error1("Should neve have explicit unquote-splice", 0)
	elseif (catTag1 == "import") then
		if (ret1 == nil) then
			append_21_1(out12, "nil")
		elseif (ret1 ~= "") then
			append_21_1(out12, ret1)
			append_21_1(out12, "nil")
		end
	elseif (catTag1 == "call-symbol") then
		local head6 = car1(node52)
		local meta4 = ((type1(head6) == "symbol") and ((head6["var"]["tag"] == "native") and state28["meta"][head6["var"]["fullName"]]))
		local metaTy1 = type1(meta4)
		if (metaTy1 == "nil") then
		elseif (metaTy1 == "boolean") then
		elseif (metaTy1 == "expr") then
		elseif (metaTy1 == "stmt") then
			if ret1 then
			else
				meta4 = nil
			end
		elseif (metaTy1 == "var") then
			meta4 = nil
		else
			_error("unmatched item")
		end
		local temp11
		if meta4 then
			if meta4["fold"] then
				temp11 = ((node52["n"] - 1) >= meta4["count"])
			else
				temp11 = ((node52["n"] - 1) == meta4["count"])
			end
		else
			temp11 = false
		end
		if temp11 then
			if (meta4["tag"] == "expr") then
				if (ret1 == "") then
					append_21_1(out12, "local _ = ")
				elseif ret1 then
					append_21_1(out12, ret1)
				end
			end
			local contents1 = meta4["contents"]
			local fold1 = meta4["fold"]
			local count4 = meta4["count"]
			local build1
			build1 = (function(start7, _eend1)
				local r_8831 = contents1["n"]
				local r_8811 = nil
				r_8811 = (function(r_8821)
					if (r_8821 <= r_8831) then
						local entry6 = contents1[r_8821]
						if string_3f_1(entry6) then
							append_21_1(out12, entry6)
						elseif ((fold1 == "l") and ((entry6 == 1) and (start7 < _eend1))) then
							build1(start7, (_eend1 - 1))
							start7 = _eend1
						elseif ((fold1 == "r") and ((entry6 == 2) and (start7 < _eend1))) then
							build1((start7 + 1), _eend1)
						else
							compileExpression1(node52[((entry6 + start7))], out12, state28)
						end
						return r_8811((r_8821 + 1))
					else
					end
				end)
				return r_8811(1)
			end)
			build1(1, (node52["n"] - count4))
			if ((meta4["tag"] ~= "expr") and (ret1 ~= "")) then
				line_21_1(out12)
				append_21_1(out12, ret1)
				append_21_1(out12, "nil")
				line_21_1(out12)
			end
		elseif cat6["recur"] then
			local head7 = cat6["recur"]["def"]
			local args13 = head7[2]
			if (args13["n"] > 0) then
				local packName1 = nil
				local offset5 = 1
				local done1 = false
				local r_8921 = args13["n"]
				local r_8901 = nil
				r_8901 = (function(r_8911)
					if (r_8911 <= r_8921) then
						local var25 = args13[r_8911]["var"]
						if var25["isVariadic"] then
							local count5 = (node52["n"] - args13["n"])
							if (count5 < 0) then
								count5 = 0
							end
							if done1 then
								append_21_1(out12, ", ")
							else
								done1 = true
							end
							append_21_1(out12, escapeVar1(var25, state28))
							offset5 = count5
						else
							local expr1 = node52[((r_8911 + offset5))]
							if (expr1 and (not (type1(expr1) == "symbol") or (expr1["var"] ~= var25))) then
								if done1 then
									append_21_1(out12, ", ")
								else
									done1 = true
								end
								append_21_1(out12, escapeVar1(var25, state28))
							end
						end
						return r_8901((r_8911 + 1))
					else
					end
				end)
				r_8901(1)
				append_21_1(out12, " = ")
				local offset6 = 1
				local done2 = false
				local r_8981 = args13["n"]
				local r_8961 = nil
				r_8961 = (function(r_8971)
					if (r_8971 <= r_8981) then
						local var26 = args13[r_8971]["var"]
						if var26["isVariadic"] then
							local count6 = (node52["n"] - args13["n"])
							if (count6 < 0) then
								count6 = 0
							end
							if done2 then
								append_21_1(out12, ", ")
							else
								done2 = true
							end
							if compilePack1(node52, out12, state28, r_8971, count6) then
								packName1 = escapeVar1(var26, state28)
							end
							offset6 = count6
						else
							local expr2 = node52[((r_8971 + offset6))]
							if (expr2 and (not (type1(expr2) == "symbol") or (expr2["var"] ~= var26))) then
								if done2 then
									append_21_1(out12, ", ")
								else
									done2 = true
								end
								compileExpression1(node52[((r_8971 + offset6))], out12, state28)
							end
						end
						return r_8961((r_8971 + 1))
					else
					end
				end)
				r_8961(1)
				local r_9041 = node52["n"]
				local r_9021 = nil
				r_9021 = (function(r_9031)
					if (r_9031 <= r_9041) then
						if (r_9031 > 1) then
							append_21_1(out12, ", ")
						end
						compileExpression1(node52[r_9031], out12, state28)
						return r_9021((r_9031 + 1))
					else
					end
				end)
				r_9021((args13["n"] + (offset6 + 1)))
				line_21_1(out12)
				if packName1 then
					line_21_1(_2e2e_2(packName1, ".tag = \"list\""))
				end
			else
				local r_9081 = node52["n"]
				local r_9061 = nil
				r_9061 = (function(r_9071)
					if (r_9071 <= r_9081) then
						if (r_9071 > 1) then
							append_21_1(out12, ", ")
						end
						compileExpression1(node52[r_9071], out12, state28, "")
						line_21_1(out12)
						return r_9061((r_9071 + 1))
					else
					end
				end)
				r_9061(1)
			end
		else
			if ret1 then
				append_21_1(out12, ret1)
			end
			compileExpression1(head6, out12, state28)
			append_21_1(out12, "(")
			local r_9121 = node52["n"]
			local r_9101 = nil
			r_9101 = (function(r_9111)
				if (r_9111 <= r_9121) then
					if (r_9111 > 2) then
						append_21_1(out12, ", ")
					end
					compileExpression1(node52[r_9111], out12, state28)
					return r_9101((r_9111 + 1))
				else
				end
			end)
			r_9101(2)
			append_21_1(out12, ")")
		end
	elseif (catTag1 == "wrap-value") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		compileExpression1(node52[2], out12, state28)
		append_21_1(out12, ")")
	elseif (catTag1 == "call-lambda") then
		if (ret1 == nil) then
			print1(pretty1(node52), " marked as call-lambda for ", ret1)
		end
		local head8 = car1(node52)
		local args14 = head8[2]
		local offset7 = 1
		local r_9181 = args14["n"]
		local r_9161 = nil
		r_9161 = (function(r_9171)
			if (r_9171 <= r_9181) then
				local var27 = args14[r_9171]["var"]
				local esc2 = escapeVar1(var27, state28)
				append_21_1(out12, _2e2e_2("local ", esc2))
				if var27["isVariadic"] then
					local count7 = (node52["n"] - args14["n"])
					if (count7 < 0) then
						count7 = 0
					end
					append_21_1(out12, " = ")
					if compilePack1(node52, out12, state28, r_9171, count7) then
						append_21_1(out12, _2e2e_2(" ", esc2, ".tag = \"list\""))
					end
					line_21_1(out12)
					offset7 = count7
				else
					local expr3 = node52[((r_9171 + offset7))]
					local name11 = escapeVar1(var27, state28)
					local ret2 = nil
					if expr3 then
						if catLookup1[expr3]["stmt"] then
							ret2 = _2e2e_2(name11, " = ")
							line_21_1(out12)
						else
							append_21_1(out12, " = ")
						end
						compileExpression1(expr3, out12, state28, ret2)
						line_21_1(out12)
					else
						line_21_1(out12)
					end
				end
				return r_9161((r_9171 + 1))
			else
			end
		end)
		r_9161(1)
		local r_9221 = node52["n"]
		local r_9201 = nil
		r_9201 = (function(r_9211)
			if (r_9211 <= r_9221) then
				compileExpression1(node52[r_9211], out12, state28, "")
				line_21_1(out12)
				return r_9201((r_9211 + 1))
			else
			end
		end)
		r_9201((args14["n"] + (offset7 + 1)))
		compileBlock1(head8, out12, state28, 3, ret1)
	elseif (catTag1 == "call-literal") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		append_21_1(out12, "(")
		compileExpression1(car1(node52), out12, state28)
		append_21_1(out12, ")(")
		local r_9261 = node52["n"]
		local r_9241 = nil
		r_9241 = (function(r_9251)
			if (r_9251 <= r_9261) then
				if (r_9251 > 2) then
					append_21_1(out12, ", ")
				end
				compileExpression1(node52[r_9251], out12, state28)
				return r_9241((r_9251 + 1))
			else
			end
		end)
		r_9241(2)
		append_21_1(out12, ")")
	elseif (catTag1 == "call") then
		if ret1 then
			append_21_1(out12, ret1)
		end
		compileExpression1(car1(node52), out12, state28)
		append_21_1(out12, "(")
		local r_9301 = node52["n"]
		local r_9281 = nil
		r_9281 = (function(r_9291)
			if (r_9291 <= r_9301) then
				if (r_9291 > 2) then
					append_21_1(out12, ", ")
				end
				compileExpression1(node52[r_9291], out12, state28)
				return r_9281((r_9291 + 1))
			else
			end
		end)
		r_9281(2)
		append_21_1(out12, ")")
	else
		error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(catTag1), ", but none matched.\n", "  Tried: `\"const\"`\n  Tried: `\"lambda\"`\n  Tried: `\"cond\"`\n  Tried: `\"not\"`\n  Tried: `\"or\"`\n  Tried: `\"or-lambda\"`\n  Tried: `\"and\"`\n  Tried: `\"and-lambda\"`\n  Tried: `\"set!\"`\n  Tried: `\"struct-literal\"`\n  Tried: `\"define\"`\n  Tried: `\"define-native\"`\n  Tried: `\"quote\"`\n  Tried: `\"quote-const\"`\n  Tried: `\"quote-list\"`\n  Tried: `\"quote-splice\"`\n  Tried: `\"syntax-quote\"`\n  Tried: `\"unquote\"`\n  Tried: `\"unquote-splice\"`\n  Tried: `\"import\"`\n  Tried: `\"call-symbol\"`\n  Tried: `\"wrap-value\"`\n  Tried: `\"call-lambda\"`\n  Tried: `\"call-literal\"`\n  Tried: `\"call\"`"))
	end
	if boringCategories1[catTag1] then
	else
		return popNode_21_1(out12, node52)
	end
end)
compilePack1 = (function(node53, out13, state29, start8, count8)
	if ((count8 <= 0) or atom_3f_1(node53[((start8 + count8))])) then
		append_21_1(out13, "{ tag=\"list\", n=")
		append_21_1(out13, tostring1(count8))
		local r_8681 = nil
		r_8681 = (function(r_8691)
			if (r_8691 <= count8) then
				append_21_1(out13, ", ")
				compileExpression1(node53[((start8 + r_8691))], out13, state29)
				return r_8681((r_8691 + 1))
			else
			end
		end)
		r_8681(1)
		append_21_1(out13, "}")
		return false
	else
		append_21_1(out13, " _pack(")
		local r_8721 = nil
		r_8721 = (function(r_8731)
			if (r_8731 <= count8) then
				if (r_8731 > 1) then
					append_21_1(out13, ", ")
				end
				compileExpression1(node53[((start8 + r_8731))], out13, state29)
				return r_8721((r_8731 + 1))
			else
			end
		end)
		r_8721(1)
		append_21_1(out13, ")")
		return true
	end
end)
compileBlock1 = (function(nodes24, out14, state30, start9, ret3)
	local r_6871 = nodes24["n"]
	local r_6851 = nil
	r_6851 = (function(r_6861)
		if (r_6861 <= r_6871) then
			local ret_27_1
			if (r_6861 == nodes24["n"]) then
				ret_27_1 = ret3
			else
				ret_27_1 = ""
			end
			compileExpression1(nodes24[r_6861], out14, state30, ret_27_1)
			line_21_1(out14)
			return r_6851((r_6861 + 1))
		else
		end
	end)
	r_6851(start9)
	if ((nodes24["n"] < start9) and (ret3 and (ret3 ~= ""))) then
		append_21_1(out14, ret3)
		return line_21_1(out14, "nil")
	else
	end
end)
prelude1 = (function(out15)
	line_21_1(out15, "if not table.pack then table.pack = function(...) return { n = select(\"#\", ...), ... } end end")
	line_21_1(out15, "if not table.unpack then table.unpack = unpack end")
	line_21_1(out15, "local load = load if _VERSION:find(\"5.1\") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then error(e, 2) end if env then setfenv(f, env) end return f end end")
	return line_21_1(out15, "local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error")
end)
expression2 = (function(node54, out16, state31, ret4)
	runPass1(categoriseNode1, state31, nil, node54, state31["cat-lookup"], (ret4 ~= nil))
	return compileExpression1(node54, out16, state31, ret4)
end)
block2 = (function(nodes25, out17, state32, start10, ret5)
	runPass1(categoriseNodes1, state32, nil, nodes25, state32["cat-lookup"])
	return compileBlock1(nodes25, out17, state32, start10, ret5)
end)
getinfo1 = debug.getinfo
sethook1 = debug.sethook
traceback1 = debug.traceback
unmangleIdent1 = (function(ident1)
	local esc3 = match1(ident1, "^(.-)%d+$")
	if (esc3 == nil) then
		return ident1
	elseif (sub1(esc3, 1, 2) == "_e") then
		return sub1(ident1, 3)
	else
		local buffer2 = ({tag = "list", n = 0})
		local pos9 = 0
		local len13 = len1(esc3)
		local r_9321 = nil
		r_9321 = (function()
			if (pos9 <= len13) then
				local char3
				local x22 = pos9
				char3 = sub1(esc3, x22, x22)
				if (char3 == "_") then
					local r_9331 = list1(find1(esc3, "^_[%da-z]+_", pos9))
					if ((type1(r_9331) == "list") and ((r_9331["n"] >= 2) and ((r_9331["n"] <= 2) and true))) then
						local start11 = r_9331[1]
						local _eend2 = r_9331[2]
						pos9 = (pos9 + 1)
						local r_9391 = nil
						r_9391 = (function()
							if (pos9 < _eend2) then
								pushCdr_21_1(buffer2, char1(tonumber1(sub1(esc3, pos9, (pos9 + 1)), 16)))
								pos9 = (pos9 + 2)
								return r_9391()
							else
							end
						end)
						r_9391()
					else
						pushCdr_21_1(buffer2, "_")
					end
				elseif between_3f_1(char3, "A", "Z") then
					pushCdr_21_1(buffer2, "-")
					pushCdr_21_1(buffer2, lower1(char3))
				else
					pushCdr_21_1(buffer2, char3)
				end
				pos9 = (pos9 + 1)
				return r_9321()
			else
			end
		end)
		r_9321()
		return concat1(buffer2)
	end
end)
remapError1 = (function(msg23)
	return (gsub1(gsub1(gsub1(gsub1(msg23, "local '([^']+)'", (function(x23)
		return _2e2e_2("local '", unmangleIdent1(x23), "'")
	end)), "global '([^']+)'", (function(x24)
		return _2e2e_2("global '", unmangleIdent1(x24), "'")
	end)), "upvalue '([^']+)'", (function(x25)
		return _2e2e_2("upvalue '", unmangleIdent1(x25), "'")
	end)), "function '([^']+)'", (function(x26)
		return _2e2e_2("function '", unmangleIdent1(x26), "'")
	end)))
end)
remapMessage1 = (function(mappings1, msg24)
	local r_9441 = list1(match1(msg24, "^(.-):(%d+)(.*)$"))
	if ((type1(r_9441) == "list") and ((r_9441["n"] >= 3) and ((r_9441["n"] <= 3) and true))) then
		local file1 = r_9441[1]
		local line2 = r_9441[2]
		local extra1 = r_9441[3]
		local mapping1 = mappings1[file1]
		if mapping1 then
			local range3 = mapping1[tonumber1(line2)]
			if range3 then
				return _2e2e_2(range3, " (", file1, ":", line2, ")", remapError1(extra1))
			else
				return msg24
			end
		else
			return msg24
		end
	else
		return msg24
	end
end)
remapTraceback1 = (function(mappings2, msg25)
	return gsub1(gsub1(gsub1(gsub1(gsub1(gsub1(gsub1(msg25, "^([^\n:]-:%d+:[^\n]*)", (function(r_9581)
		return remapMessage1(mappings2, r_9581)
	end)), "\9([^\n:]-:%d+:)", (function(msg26)
		return _2e2e_2("\9", remapMessage1(mappings2, msg26))
	end)), "<([^\n:]-:%d+)>\n", (function(msg27)
		return _2e2e_2("<", remapMessage1(mappings2, msg27), ">\n")
	end)), "in local '([^']+)'\n", (function(x27)
		return _2e2e_2("in local '", unmangleIdent1(x27), "'\n")
	end)), "in global '([^']+)'\n", (function(x28)
		return _2e2e_2("in global '", unmangleIdent1(x28), "'\n")
	end)), "in upvalue '([^']+)'\n", (function(x29)
		return _2e2e_2("in upvalue '", unmangleIdent1(x29), "'\n")
	end)), "in function '([^']+)'\n", (function(x30)
		return _2e2e_2("in function '", unmangleIdent1(x30), "'\n")
	end))
end)
generateMappings1 = (function(lines4)
	local outLines1 = ({})
	iterPairs1(lines4, (function(line3, ranges1)
		local rangeLists1 = ({})
		iterPairs1(ranges1, (function(pos10)
			local file2 = pos10["name"]
			local rangeList1 = rangeLists1["file"]
			if rangeList1 then
			else
				rangeList1 = ({["n"]=0,["min"]=huge1,["max"]=(0 - huge1)})
				rangeLists1[file2] = rangeList1
			end
			local r_9611 = pos10["finish"]["line"]
			local r_9591 = nil
			r_9591 = (function(r_9601)
				if (r_9601 <= r_9611) then
					if rangeList1[r_9601] then
					else
						rangeList1["n"] = (rangeList1["n"] + 1)
						rangeList1[r_9601] = true
						if (r_9601 < rangeList1["min"]) then
							rangeList1["min"] = r_9601
						end
						if (r_9601 > rangeList1["max"]) then
							rangeList1["max"] = r_9601
						end
					end
					return r_9591((r_9601 + 1))
				else
				end
			end)
			return r_9591(pos10["start"]["line"])
		end))
		local bestName1 = nil
		local bestLines1 = nil
		local bestCount1 = 0
		iterPairs1(rangeLists1, (function(name12, lines5)
			if (lines5["n"] > bestCount1) then
				bestName1 = name12
				bestLines1 = lines5
				bestCount1 = lines5["n"]
				return nil
			else
			end
		end))
		outLines1[line3] = (function()
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
local _ = ({["remapTraceback"]=remapTraceback1})
createState1 = (function(meta5)
	return ({["level"]=1,["override"]=({}),["timer"]=void1,["count"]=0,["mappings"]=({}),["cat-lookup"]=({}),["ctr-lookup"]=({}),["var-lookup"]=({}),["meta"]=(meta5 or ({}))})
end)
file3 = (function(compiler1, shebang1)
	local state33 = createState1(compiler1["libMeta"])
	local out18 = create2()
	if shebang1 then
		line_21_1(out18, _2e2e_2("#!/usr/bin/env ", shebang1))
	end
	state33["trace"] = true
	prelude1(out18)
	line_21_1(out18, "local _libs = {}")
	local r_9841 = compiler1["libs"]
	local r_9871 = r_9841["n"]
	local r_9851 = nil
	r_9851 = (function(r_9861)
		if (r_9861 <= r_9871) then
			local lib1 = r_9841[r_9861]
			local prefix1 = quoted1(lib1["prefix"])
			local native1 = lib1["native"]
			if native1 then
				line_21_1(out18, "local _temp = (function()")
				local r_9901 = split1(native1, "\n")
				local r_9931 = r_9901["n"]
				local r_9911 = nil
				r_9911 = (function(r_9921)
					if (r_9921 <= r_9931) then
						local line4 = r_9901[r_9921]
						if (line4 ~= "") then
							append_21_1(out18, "\9")
							line_21_1(out18, line4)
						end
						return r_9911((r_9921 + 1))
					else
					end
				end)
				r_9911(1)
				line_21_1(out18, "end)()")
				line_21_1(out18, _2e2e_2("for k, v in pairs(_temp) do _libs[", prefix1, ".. k] = v end"))
			end
			return r_9851((r_9861 + 1))
		else
		end
	end)
	r_9851(1)
	local count9 = 0
	local r_9961 = compiler1["out"]
	local r_9991 = r_9961["n"]
	local r_9971 = nil
	r_9971 = (function(r_9981)
		if (r_9981 <= r_9991) then
			if r_9961[r_9981]["defVar"] then
				count9 = (count9 + 1)
			end
			return r_9971((r_9981 + 1))
		else
		end
	end)
	r_9971(1)
	if between_3f_1(count9, 1, 150) then
		append_21_1(out18, "local ")
		local first7 = true
		local r_10021 = compiler1["out"]
		local r_10051 = r_10021["n"]
		local r_10031 = nil
		r_10031 = (function(r_10041)
			if (r_10041 <= r_10051) then
				local node55 = r_10021[r_10041]
				local var28 = node55["defVar"]
				if var28 then
					if first7 then
						first7 = false
					else
						append_21_1(out18, ", ")
					end
					append_21_1(out18, escapeVar1(var28, state33))
				end
				return r_10031((r_10041 + 1))
			else
			end
		end)
		r_10031(1)
		line_21_1(out18)
	else
		line_21_1(out18, "local _ENV = setmetatable({}, {__index=ENV or (getfenv and getfenv()) or _G}) if setfenv then setfenv(0, _ENV) end")
	end
	block2(compiler1["out"], out18, state33, 1, "return ")
	return out18
end)
executeStates1 = (function(backState1, states1, global1, logger8)
	local stateList1 = ({tag = "list", n = 0})
	local nameList1 = ({tag = "list", n = 0})
	local exportList1 = ({tag = "list", n = 0})
	local escapeList1 = ({tag = "list", n = 0})
	local r_6791 = nil
	r_6791 = (function(r_6801)
		if (r_6801 >= 1) then
			local state34 = states1[r_6801]
			if (state34["stage"] == "executed") then
			else
				local node56
				if state34["node"] then
				else
					node56 = error1(_2e2e_2("State is in ", state34["stage"], " instead"), 0)
				end
				local var29 = (state34["var"] or ({["name"]="temp"}))
				local escaped1 = escapeVar1(var29, backState1)
				local name13 = var29["name"]
				pushCdr_21_1(stateList1, state34)
				pushCdr_21_1(exportList1, _2e2e_2(escaped1, " = ", escaped1))
				pushCdr_21_1(nameList1, name13)
				pushCdr_21_1(escapeList1, escaped1)
			end
			return r_6791((r_6801 + -1))
		else
		end
	end)
	r_6791(states1["n"])
	if empty_3f_1(stateList1) then
	else
		local out19 = create2()
		local id3 = backState1["count"]
		local name14 = concat1(nameList1, ",")
		backState1["count"] = (id3 + 1)
		if (len1(name14) > 20) then
			name14 = _2e2e_2(sub1(name14, 1, 17), "...")
		end
		name14 = _2e2e_2("compile#", id3, "{", name14, "}")
		prelude1(out19)
		line_21_1(out19, _2e2e_2("local ", concat1(escapeList1, ", ")))
		local r_10201 = stateList1["n"]
		local r_10181 = nil
		r_10181 = (function(r_10191)
			if (r_10191 <= r_10201) then
				local state35 = stateList1[r_10191]
				expression2(state35["node"], out19, backState1, (function()
					if state35["var"] then
						return ""
					else
						return _2e2e_2(escapeList1[r_10191], "= ")
					end
				end)()
				)
				line_21_1(out19)
				return r_10181((r_10191 + 1))
			else
			end
		end)
		r_10181(1)
		line_21_1(out19, _2e2e_2("return { ", concat1(exportList1, ", "), "}"))
		local str4 = concat1(out19["out"])
		backState1["mappings"][name14] = generateMappings1(out19["lines"])
		local r_10221 = list1(load1(str4, _2e2e_2("=", name14), "t", global1))
		if ((type1(r_10221) == "list") and ((r_10221["n"] >= 2) and ((r_10221["n"] <= 2) and (eq_3f_1(r_10221[1], nil) and true)))) then
			local msg28 = r_10221[2]
			local buffer3 = ({tag = "list", n = 0})
			local lines6 = split1(str4, "\n")
			local format2 = _2e2e_2("%", len1(tostring1(lines6["n"])), "d | %s")
			local r_10311 = lines6["n"]
			local r_10291 = nil
			r_10291 = (function(r_10301)
				if (r_10301 <= r_10311) then
					pushCdr_21_1(buffer3, format1(format2, r_10301, lines6[r_10301]))
					return r_10291((r_10301 + 1))
				else
				end
			end)
			r_10291(1)
			return error1(_2e2e_2(msg28, ":\n", concat1(buffer3, "\n")), 0)
		elseif ((type1(r_10221) == "list") and ((r_10221["n"] >= 1) and ((r_10221["n"] <= 1) and true))) then
			local fun1 = r_10221[1]
			local r_10361 = list1(xpcall1(fun1, traceback1))
			if ((type1(r_10361) == "list") and ((r_10361["n"] >= 2) and ((r_10361["n"] <= 2) and (eq_3f_1(r_10361[1], false) and true)))) then
				local msg29 = r_10361[2]
				return error1(remapTraceback1(backState1["mappings"], msg29), 0)
			elseif ((type1(r_10361) == "list") and ((r_10361["n"] >= 2) and ((r_10361["n"] <= 2) and (eq_3f_1(r_10361[1], true) and true)))) then
				local tbl1 = r_10361[2]
				local r_10491 = stateList1["n"]
				local r_10471 = nil
				r_10471 = (function(r_10481)
					if (r_10481 <= r_10491) then
						local state36 = stateList1[r_10481]
						local escaped2 = escapeList1[r_10481]
						local res7 = tbl1[escaped2]
						self1(state36, "executed", res7)
						if state36["var"] then
							global1[escaped2] = res7
						end
						return r_10471((r_10481 + 1))
					else
					end
				end)
				return r_10471(1)
			else
				return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10361), ", but none matched.\n", "  Tried: `(false ?msg)`\n  Tried: `(true ?tbl)`"))
			end
		else
			return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10221), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
end)
native2 = (function(meta6, global2)
	local out20 = create2()
	prelude1(out20)
	append_21_1(out20, "return ")
	compileNative1(out20, meta6)
	local r_10081 = list1(load1(concat1(out20["out"]), _2e2e_2("=", meta6["name"]), "t", global2))
	if ((type1(r_10081) == "list") and ((r_10081["n"] >= 2) and ((r_10081["n"] <= 2) and (eq_3f_1(r_10081[1], nil) and true)))) then
		local msg30 = r_10081[2]
		return error1(_2e2e_2("Cannot compile meta ", meta6["name"], ":\n", msg30), 0)
	elseif ((type1(r_10081) == "list") and ((r_10081["n"] >= 1) and ((r_10081["n"] <= 1) and true))) then
		return r_10081[1]()
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10081), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
	end
end)
emitLua1 = ({["name"]="emit-lua",["setup"]=(function(spec6)
	addArgument_21_1(spec6, ({tag = "list", n = 1, "--emit-lua"}), "help", "Emit a Lua file.")
	addArgument_21_1(spec6, ({tag = "list", n = 1, "--shebang"}), "value", (arg1[-1] or (arg1[0] or "lua")), "help", "Set the executable to use for the shebang.", "narg", "?")
	return addArgument_21_1(spec6, ({tag = "list", n = 1, "--chmod"}), "help", "Run chmod +x on the resulting file")
end),["pred"]=(function(args15)
	return args15["emit-lua"]
end),["run"]=(function(compiler2, args16)
	if empty_3f_1(args16["input"]) then
		self1(compiler2["log"], "put-error!", "No inputs to compile.")
		exit_21_1(1)
	end
	local out21 = file3(compiler2, args16["shebang"])
	local handle1 = open1(_2e2e_2(args16["output"], ".lua"), "w")
	self1(handle1, "write", concat1(out21["out"]))
	self1(handle1, "close")
	if args16["chmod"] then
		return execute1(_2e2e_2("chmod +x ", quoted1(_2e2e_2(args16["output"], ".lua"))))
	else
	end
end)})
emitLisp1 = ({["name"]="emit-lisp",["setup"]=(function(spec7)
	return addArgument_21_1(spec7, ({tag = "list", n = 1, "--emit-lisp"}), "help", "Emit a Lisp file.")
end),["pred"]=(function(args17)
	return args17["emit-lisp"]
end),["run"]=(function(compiler3, args18)
	if empty_3f_1(args18["input"]) then
		self1(compiler3["log"], "put-error!", "No inputs to compile.")
		exit_21_1(1)
	end
	local writer12 = create2()
	block1(compiler3["out"], writer12)
	local handle2 = open1(_2e2e_2(args18["output"], ".lisp"), "w")
	self1(handle2, "write", concat1(writer12["out"]))
	return self1(handle2, "close")
end)})
passArg1 = (function(arg23, data4, value10, usage_21_4)
	local val17 = tonumber1(value10)
	local name15 = _2e2e_2(arg23["name"], "-override")
	local override2 = data4[name15]
	if override2 then
	else
		override2 = ({})
		data4[name15] = override2
	end
	if val17 then
		data4[arg23["name"]] = val17
		return nil
	elseif (sub1(value10, 1, 1) == "-") then
		override2[sub1(value10, 2)] = false
		return nil
	elseif (sub1(value10, 1, 1) == "+") then
		override2[sub1(value10, 2)] = true
		return nil
	else
		return usage_21_4(_2e2e_2("Expected number or enable/disable flag for --", arg23["name"], " , got ", value10))
	end
end)
passRun1 = (function(fun2, name16, passes1)
	return (function(compiler4, args19)
		return fun2(compiler4["out"], ({["track"]=true,["level"]=args19[name16],["override"]=(args19[_2e2e_2(name16, "-override")] or ({})),["pass"]=compiler4[name16],["max-n"]=args19[_2e2e_2(name16, "-n")],["max-time"]=args19[_2e2e_2(name16, "-time")],["meta"]=compiler4["libMeta"],["libs"]=compiler4["libs"],["logger"]=compiler4["log"],["timer"]=compiler4["timer"]}))
	end)
end)
warning1 = ({["name"]="warning",["setup"]=(function(spec8)
	return addArgument_21_1(spec8, ({tag = "list", n = 2, "--warning", "-W"}), "help", "Either the warning level to use or an enable/disable flag for a pass.", "default", 1, "narg", 1, "var", "LEVEL", "action", passArg1)
end),["pred"]=(function(args20)
	return (args20["warning"] > 0)
end),["run"]=passRun1(analyse1, "warning")})
optimise2 = ({["name"]="optimise",["setup"]=(function(spec9)
	addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise", "-O"}), "help", "Either the optimiation level to use or an enable/disable flag for a pass.", "default", 1, "narg", 1, "var", "LEVEL", "action", passArg1)
	addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise-n", "--optn"}), "help", "The maximum number of iterations the optimiser should run for.", "default", 10, "narg", 1, "action", setNumAction1)
	return addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise-time", "--optt"}), "help", "The maximum time the optimiser should run for.", "default", -1, "narg", 1, "action", setNumAction1)
end),["pred"]=(function(args21)
	return (args21["optimise"] > 0)
end),["run"]=passRun1(optimise1, "optimise")})
Scope2 = require1("tacky.analysis.scope")
formatRange2 = (function(range4)
	return format1("%s:%s", range4["name"], (function(pos11)
		return _2e2e_2(pos11["line"], ":", pos11["column"])
	end)(range4["start"]))
end)
sortVars_21_1 = (function(list5)
	return sort1(list5, (function(a2, b2)
		return (car1(a2) < car1(b2))
	end))
end)
formatDefinition1 = (function(var30)
	local ty7 = type1(var30)
	if (ty7 == "builtin") then
		return "Builtin term"
	elseif (ty7 == "macro") then
		return _2e2e_2("Macro defined at ", formatRange2(getSource1(var30["node"])))
	elseif (ty7 == "native") then
		return _2e2e_2("Native defined at ", formatRange2(getSource1(var30["node"])))
	elseif (ty7 == "defined") then
		return _2e2e_2("Defined at ", formatRange2(getSource1(var30["node"])))
	else
		_error("unmatched item")
	end
end)
formatSignature1 = (function(name17, var31)
	local sig1 = extractSignature1(var31)
	if (sig1 == nil) then
		return name17
	elseif empty_3f_1(sig1) then
		return _2e2e_2("(", name17, ")")
	else
		return _2e2e_2("(", name17, " ", concat1(map1((function(r_10531)
			return r_10531["contents"]
		end), sig1), " "), ")")
	end
end)
writeDocstring1 = (function(out22, str5, scope2)
	local r_10551 = parseDocstring1(str5)
	local r_10581 = r_10551["n"]
	local r_10561 = nil
	r_10561 = (function(r_10571)
		if (r_10571 <= r_10581) then
			local tok3 = r_10551[r_10571]
			local ty8 = type1(tok3)
			if (ty8 == "text") then
				append_21_1(out22, tok3["contents"])
			elseif (ty8 == "boldic") then
				append_21_1(out22, tok3["contents"])
			elseif (ty8 == "bold") then
				append_21_1(out22, tok3["contents"])
			elseif (ty8 == "italic") then
				append_21_1(out22, tok3["contents"])
			elseif (ty8 == "arg") then
				append_21_1(out22, _2e2e_2("`", tok3["contents"], "`"))
			elseif (ty8 == "mono") then
				append_21_1(out22, tok3["whole"])
			elseif (ty8 == "link") then
				local name18 = tok3["contents"]
				local ovar1 = Scope2["get"](scope2, name18)
				if (ovar1 and ovar1["node"]) then
					local loc1 = gsub1(gsub1(getSource1((ovar1["node"]))["name"], "%.lisp$", ""), "/", ".")
					local sig2 = extractSignature1(ovar1)
					append_21_1(out22, format1("[`%s`](%s.md#%s)", name18, loc1, gsub1((function()
						if (sig2 == nil) then
							return ovar1["name"]
						elseif empty_3f_1(sig2) then
							return ovar1["name"]
						else
							return _2e2e_2(name18, " ", concat1(map1((function(r_10611)
								return r_10611["contents"]
							end), sig2), " "))
						end
					end)()
					, "%A+", "-")))
				else
					append_21_1(out22, format1("`%s`", name18))
				end
			else
				_error("unmatched item")
			end
			return r_10561((r_10571 + 1))
		else
		end
	end)
	r_10561(1)
	return line_21_1(out22)
end)
exported1 = (function(out23, title1, primary1, vars2, scope3)
	local documented1 = ({tag = "list", n = 0})
	local undocumented1 = ({tag = "list", n = 0})
	iterPairs1(vars2, (function(name19, var32)
		return pushCdr_21_1((function()
			if var32["doc"] then
				return documented1
			else
				return undocumented1
			end
		end)()
		, list1(name19, var32))
	end))
	sortVars_21_1(documented1)
	sortVars_21_1(undocumented1)
	line_21_1(out23, "---")
	line_21_1(out23, _2e2e_2("title: ", title1))
	line_21_1(out23, "---")
	line_21_1(out23, _2e2e_2("# ", title1))
	if primary1 then
		writeDocstring1(out23, primary1, scope3)
		line_21_1(out23, "", true)
	end
	local r_10701 = documented1["n"]
	local r_10681 = nil
	r_10681 = (function(r_10691)
		if (r_10691 <= r_10701) then
			local entry7 = documented1[r_10691]
			local name20 = car1(entry7)
			local var33 = entry7[2]
			line_21_1(out23, _2e2e_2("## `", formatSignature1(name20, var33), "`"))
			line_21_1(out23, _2e2e_2("*", formatDefinition1(var33), "*"))
			line_21_1(out23, "", true)
			if var33["deprecated"] then
				line_21_1(out23, (function()
					if string_3f_1(var33["deprecated"]) then
						return format1("> **Warning:** %s is deprecated: %s", name20, var33["deprecated"])
					else
						return format1("> **Warning:** %s is deprecated.", name20)
					end
				end)()
				)
				line_21_1(out23, "", true)
			end
			writeDocstring1(out23, var33["doc"], var33["scope"])
			line_21_1(out23, "", true)
			return r_10681((r_10691 + 1))
		else
		end
	end)
	r_10681(1)
	if empty_3f_1(undocumented1) then
	else
		line_21_1(out23, "## Undocumented symbols")
	end
	local r_10761 = undocumented1["n"]
	local r_10741 = nil
	r_10741 = (function(r_10751)
		if (r_10751 <= r_10761) then
			local entry8 = undocumented1[r_10751]
			local name21 = car1(entry8)
			local var34 = entry8[2]
			line_21_1(out23, _2e2e_2(" - `", formatSignature1(name21, var34), "` *", formatDefinition1(var34), "*"))
			return r_10741((r_10751 + 1))
		else
		end
	end)
	return r_10741(1)
end)
docs1 = (function(compiler5, args22)
	if empty_3f_1(args22["input"]) then
		self1(compiler5["log"], "put-error!", "No inputs to generate documentation for.")
		exit_21_1(1)
	end
	local r_10791 = args22["input"]
	local r_10821 = r_10791["n"]
	local r_10801 = nil
	r_10801 = (function(r_10811)
		if (r_10811 <= r_10821) then
			local path1 = r_10791[r_10811]
			if (sub1(path1, -5) == ".lisp") then
				path1 = sub1(path1, 1, -6)
			end
			local lib2 = compiler5["libCache"][path1]
			local writer13 = create2()
			exported1(writer13, lib2["name"], lib2["docs"], lib2["scope"]["exported"], lib2["scope"])
			local handle3 = open1(_2e2e_2(args22["docs"], "/", gsub1(path1, "/", "."), ".md"), "w")
			self1(handle3, "write", concat1(writer13["out"]))
			self1(handle3, "close")
			return r_10801((r_10811 + 1))
		else
		end
	end)
	return r_10801(1)
end)
task1 = ({["name"]="docs",["setup"]=(function(spec10)
	return addArgument_21_1(spec10, ({tag = "list", n = 1, "--docs"}), "help", "Specify the folder to emit documentation to.", "default", nil, "narg", 1)
end),["pred"]=(function(args23)
	return (nil ~= args23["docs"])
end),["run"]=docs1})
create3 = coroutine.create
resume1 = coroutine.resume
status1 = coroutine.status
yield1 = coroutine.yield
local discard1 = (function()
end)
void2 = ({["put-error!"]=discard1,["put-warning!"]=discard1,["put-verbose!"]=discard1,["put-debug!"]=discard1,["put-time!"]=discard1,["put-node-error!"]=discard1,["put-node-warning!"]=discard1})
hexDigit_3f_1 = (function(char4)
	return (between_3f_1(char4, "0", "9") or (between_3f_1(char4, "a", "f") or between_3f_1(char4, "A", "F")))
end)
binDigit_3f_1 = (function(char5)
	return ((char5 == "0") or (char5 == "1"))
end)
terminator_3f_1 = (function(char6)
	return ((char6 == "\n") or ((char6 == " ") or ((char6 == "\9") or ((char6 == ";") or ((char6 == "(") or ((char6 == ")") or ((char6 == "[") or ((char6 == "]") or ((char6 == "{") or ((char6 == "}") or (char6 == "")))))))))))
end)
digitError_21_1 = (function(logger9, pos12, name22, char7)
	return doNodeError_21_1(logger9, format1("Expected %s digit, got %s", name22, (function()
		if (char7 == "") then
			return "eof"
		else
			return quoted1(char7)
		end
	end)()
	), pos12, nil, pos12, "Invalid digit here")
end)
eofError_21_1 = (function(cont1, logger10, msg31, node57, explain4, ...)
	local lines7 = _pack(...) lines7.tag = "list"
	if cont1 then
		return error1(({["msg"]=msg31,["cont"]=true}), 0)
	else
		return doNodeError_21_1(logger10, msg31, node57, explain4, unpack1(lines7, 1, lines7["n"]))
	end
end)
lex1 = (function(logger11, str6, name23, cont2)
	str6 = gsub1(str6, "\13\n?", "\n")
	local lines8 = split1(str6, "\n")
	local line5 = 1
	local column1 = 1
	local offset8 = 1
	local length1 = len1(str6)
	local out24 = ({tag = "list", n = 0})
	local consume_21_1 = (function()
		if ((function(xs13, x31)
			return sub1(xs13, x31, x31)
		end)(str6, offset8) == "\n") then
			line5 = (line5 + 1)
			column1 = 1
		else
			column1 = (column1 + 1)
		end
		offset8 = (offset8 + 1)
		return nil
	end)
	local range5 = (function(start12, finish2)
		return ({["start"]=start12,["finish"]=(finish2 or start12),["lines"]=lines8,["name"]=name23})
	end)
	local appendWith_21_1 = (function(data5, start13, finish3)
		local start14 = (start13 or ({["line"]=line5,["column"]=column1,["offset"]=offset8}))
		local finish4 = (finish3 or ({["line"]=line5,["column"]=column1,["offset"]=offset8}))
		data5["range"] = range5(start14, finish4)
		data5["contents"] = sub1(str6, start14["offset"], finish4["offset"])
		return pushCdr_21_1(out24, data5)
	end)
	local parseBase1 = (function(name24, p2, base1)
		local start15 = offset8
		local char8
		local xs14 = str6
		local x32 = offset8
		char8 = sub1(xs14, x32, x32)
		if p2(char8) then
		else
			digitError_21_1(logger11, range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), name24, char8)
		end
		local xs15 = str6
		local x33 = (offset8 + 1)
		char8 = sub1(xs15, x33, x33)
		local r_11511 = nil
		r_11511 = (function()
			if p2(char8) then
				consume_21_1()
				local xs16 = str6
				local x34 = (offset8 + 1)
				char8 = sub1(xs16, x34, x34)
				return r_11511()
			else
			end
		end)
		r_11511()
		return tonumber1(sub1(str6, start15, offset8), base1)
	end)
	local r_11221 = nil
	r_11221 = (function()
		if (offset8 <= length1) then
			local char9
			local xs17 = str6
			local x35 = offset8
			char9 = sub1(xs17, x35, x35)
			if ((char9 == "\n") or ((char9 == "\9") or (char9 == " "))) then
			elseif (char9 == "(") then
				appendWith_21_1(({["tag"]="open",["close"]=")"}))
			elseif (char9 == ")") then
				appendWith_21_1(({["tag"]="close",["open"]="("}))
			elseif (char9 == "[") then
				appendWith_21_1(({["tag"]="open",["close"]="]"}))
			elseif (char9 == "]") then
				appendWith_21_1(({["tag"]="close",["open"]="["}))
			elseif (char9 == "{") then
				appendWith_21_1(({["tag"]="open-struct",["close"]="}"}))
			elseif (char9 == "}") then
				appendWith_21_1(({["tag"]="close",["open"]="{"}))
			elseif (char9 == "'") then
				local start16
				local finish5
				appendWith_21_1(({["tag"]="quote"}), nil, nil)
			elseif (char9 == "`") then
				local start17
				local finish6
				appendWith_21_1(({["tag"]="syntax-quote"}), nil, nil)
			elseif (char9 == "~") then
				local start18
				local finish7
				appendWith_21_1(({["tag"]="quasiquote"}), nil, nil)
			elseif (char9 == ",") then
				if ((function(xs18, x36)
					return sub1(xs18, x36, x36)
				end)(str6, (offset8 + 1)) == "@") then
					local start19 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
					consume_21_1()
					local finish8
					appendWith_21_1(({["tag"]="unquote-splice"}), start19, nil)
				else
					local start20
					local finish9
					appendWith_21_1(({["tag"]="unquote"}), nil, nil)
				end
			elseif find1(str6, "^%-?%.?[0-9]", offset8) then
				local start21 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
				local negative1 = (char9 == "-")
				if negative1 then
					consume_21_1()
					local xs19 = str6
					local x37 = offset8
					char9 = sub1(xs19, x37, x37)
				end
				local val18
				if ((char9 == "0") and (lower1((function(xs20, x38)
					return sub1(xs20, x38, x38)
				end)(str6, (offset8 + 1))) == "x")) then
					consume_21_1()
					consume_21_1()
					local res8 = parseBase1("hexadecimal", hexDigit_3f_1, 16)
					if negative1 then
						res8 = (0 - res8)
					end
					val18 = res8
				elseif ((char9 == "0") and (lower1((function(xs21, x39)
					return sub1(xs21, x39, x39)
				end)(str6, (offset8 + 1))) == "b")) then
					consume_21_1()
					consume_21_1()
					local res9 = parseBase1("binary", binDigit_3f_1, 2)
					if negative1 then
						res9 = (0 - res9)
					end
					val18 = res9
				else
					local r_11351 = nil
					r_11351 = (function()
						if between_3f_1((function(xs22, x40)
							return sub1(xs22, x40, x40)
						end)(str6, (offset8 + 1)), "0", "9") then
							consume_21_1()
							return r_11351()
						else
						end
					end)
					r_11351()
					if ((function(xs23, x41)
						return sub1(xs23, x41, x41)
					end)(str6, (offset8 + 1)) == ".") then
						consume_21_1()
						local r_11361 = nil
						r_11361 = (function()
							if between_3f_1((function(xs24, x42)
								return sub1(xs24, x42, x42)
							end)(str6, (offset8 + 1)), "0", "9") then
								consume_21_1()
								return r_11361()
							else
							end
						end)
						r_11361()
					end
					local xs25 = str6
					local x43 = (offset8 + 1)
					char9 = sub1(xs25, x43, x43)
					if ((char9 == "e") or (char9 == "E")) then
						consume_21_1()
						local xs26 = str6
						local x44 = (offset8 + 1)
						char9 = sub1(xs26, x44, x44)
						if ((char9 == "-") or (char9 == "+")) then
							consume_21_1()
						end
						local r_11391 = nil
						r_11391 = (function()
							if between_3f_1((function(xs27, x45)
								return sub1(xs27, x45, x45)
							end)(str6, (offset8 + 1)), "0", "9") then
								consume_21_1()
								return r_11391()
							else
							end
						end)
						r_11391()
					end
					val18 = tonumber1(sub1(str6, start21["offset"], offset8))
				end
				appendWith_21_1(({["tag"]="number",["value"]=val18}), start21)
				local xs28 = str6
				local x46 = (offset8 + 1)
				char9 = sub1(xs28, x46, x46)
				if terminator_3f_1(char9) then
				else
					consume_21_1()
					doNodeError_21_1(logger11, format1("Expected digit, got %s", (function()
						if (char9 == "") then
							return "eof"
						else
							return char9
						end
					end)()
					), range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "Illegal character here. Are you missing whitespace?")
				end
			elseif (char9 == "\"") then
				local start22 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
				local startCol1 = (column1 + 1)
				local buffer4 = ({tag = "list", n = 0})
				consume_21_1()
				local xs29 = str6
				local x47 = offset8
				char9 = sub1(xs29, x47, x47)
				local r_11401 = nil
				r_11401 = (function()
					if (char9 ~= "\"") then
						if (column1 == 1) then
							local running3 = true
							local lineOff1 = offset8
							local r_11411 = nil
							r_11411 = (function()
								if (running3 and (column1 < startCol1)) then
									if (char9 == " ") then
										consume_21_1()
									elseif (char9 == "\n") then
										consume_21_1()
										pushCdr_21_1(buffer4, "\n")
										lineOff1 = offset8
									elseif (char9 == "") then
										running3 = false
									else
										putNodeWarning_21_1(logger11, format1("Expected leading indent, got %q", char9), range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "You should try to align multi-line strings at the initial quote\nmark. This helps keep programs neat and tidy.", range5(start22), "String started with indent here", range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "Mis-aligned character here")
										pushCdr_21_1(buffer4, sub1(str6, lineOff1, (offset8 - 1)))
										running3 = false
									end
									local xs30 = str6
									local x48 = offset8
									char9 = sub1(xs30, x48, x48)
									return r_11411()
								else
								end
							end)
							r_11411()
						end
						if (char9 == "") then
							local start23 = range5(start22)
							local finish10 = range5(({["line"]=line5,["column"]=column1,["offset"]=offset8}))
							eofError_21_1(cont2, logger11, "Expected '\"', got eof", finish10, nil, start23, "string started here", finish10, "end of file here")
						elseif (char9 == "\\") then
							consume_21_1()
							local xs31 = str6
							local x49 = offset8
							char9 = sub1(xs31, x49, x49)
							if (char9 == "\n") then
							elseif (char9 == "a") then
								pushCdr_21_1(buffer4, "\7")
							elseif (char9 == "b") then
								pushCdr_21_1(buffer4, "\8")
							elseif (char9 == "f") then
								pushCdr_21_1(buffer4, "\12")
							elseif (char9 == "n") then
								pushCdr_21_1(buffer4, "\n")
							elseif (char9 == "r") then
								pushCdr_21_1(buffer4, "\13")
							elseif (char9 == "t") then
								pushCdr_21_1(buffer4, "\9")
							elseif (char9 == "v") then
								pushCdr_21_1(buffer4, "\11")
							elseif (char9 == "\"") then
								pushCdr_21_1(buffer4, "\"")
							elseif (char9 == "\\") then
								pushCdr_21_1(buffer4, "\\")
							elseif ((char9 == "x") or ((char9 == "X") or between_3f_1(char9, "0", "9"))) then
								local start24 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
								local val19
								if ((char9 == "x") or (char9 == "X")) then
									consume_21_1()
									local start25 = offset8
									if hexDigit_3f_1((function(xs32, x50)
										return sub1(xs32, x50, x50)
									end)(str6, offset8)) then
									else
										digitError_21_1(logger11, range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "hexadecimal", (function(xs33, x51)
											return sub1(xs33, x51, x51)
										end)(str6, offset8))
									end
									if hexDigit_3f_1((function(xs34, x52)
										return sub1(xs34, x52, x52)
									end)(str6, (offset8 + 1))) then
										consume_21_1()
									end
									val19 = tonumber1(sub1(str6, start25, offset8), 16)
								else
									local start26 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
									local ctr1 = 0
									local xs35 = str6
									local x53 = (offset8 + 1)
									char9 = sub1(xs35, x53, x53)
									local r_11461 = nil
									r_11461 = (function()
										if ((ctr1 < 2) and between_3f_1(char9, "0", "9")) then
											consume_21_1()
											local xs36 = str6
											local x54 = (offset8 + 1)
											char9 = sub1(xs36, x54, x54)
											ctr1 = (ctr1 + 1)
											return r_11461()
										else
										end
									end)
									r_11461()
									val19 = tonumber1(sub1(str6, start26["offset"], offset8))
								end
								if (val19 >= 256) then
									doNodeError_21_1(logger11, "Invalid escape code", range5(start24), nil, range5(start24, ({["line"]=line5,["column"]=column1,["offset"]=offset8})), _2e2e_2("Must be between 0 and 255, is ", val19))
								end
								pushCdr_21_1(buffer4, char1(val19))
							elseif (char9 == "") then
								eofError_21_1(cont2, logger11, "Expected escape code, got eof", range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "end of file here")
							else
								doNodeError_21_1(logger11, "Illegal escape character", range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset8})), "Unknown escape character")
							end
						else
							pushCdr_21_1(buffer4, char9)
						end
						consume_21_1()
						local xs37 = str6
						local x55 = offset8
						char9 = sub1(xs37, x55, x55)
						return r_11401()
					else
					end
				end)
				r_11401()
				appendWith_21_1(({["tag"]="string",["value"]=concat1(buffer4)}), start22)
			elseif (char9 == ";") then
				local r_11481 = nil
				r_11481 = (function()
					if ((offset8 <= length1) and ((function(xs38, x56)
						return sub1(xs38, x56, x56)
					end)(str6, (offset8 + 1)) ~= "\n")) then
						consume_21_1()
						return r_11481()
					else
					end
				end)
				r_11481()
			else
				local start27 = ({["line"]=line5,["column"]=column1,["offset"]=offset8})
				local key10 = (char9 == ":")
				local xs39 = str6
				local x57 = (offset8 + 1)
				char9 = sub1(xs39, x57, x57)
				local r_11501 = nil
				r_11501 = (function()
					if not terminator_3f_1(char9) then
						consume_21_1()
						local xs40 = str6
						local x58 = (offset8 + 1)
						char9 = sub1(xs40, x58, x58)
						return r_11501()
					else
					end
				end)
				r_11501()
				if key10 then
					appendWith_21_1(({["tag"]="key",["value"]=sub1(str6, (start27["offset"] + 1), offset8)}), start27)
				else
					local finish11
					appendWith_21_1(({["tag"]="symbol"}), start27, nil)
				end
			end
			consume_21_1()
			return r_11221()
		else
		end
	end)
	r_11221()
	local start28
	local finish12
	appendWith_21_1(({["tag"]="eof"}), nil, nil)
	return out24
end)
parse1 = (function(logger12, toks1, cont3)
	local head9 = ({tag = "list", n = 0})
	local stack2 = ({tag = "list", n = 0})
	local push_21_1 = (function()
		local next1 = ({tag = "list", n = 0})
		pushCdr_21_1(stack2, head9)
		pushCdr_21_1(head9, next1)
		head9 = next1
		return nil
	end)
	local pop_21_1 = (function()
		head9["open"] = nil
		head9["close"] = nil
		head9["auto-close"] = nil
		head9["last-node"] = nil
		head9 = last1(stack2)
		return popLast_21_1(stack2)
	end)
	local r_11291 = toks1["n"]
	local r_11271 = nil
	r_11271 = (function(r_11281)
		if (r_11281 <= r_11291) then
			local tok4 = toks1[r_11281]
			local tag10 = tok4["tag"]
			local autoClose1 = false
			local previous2 = head9["last-node"]
			local tokPos1 = tok4["range"]
			local temp12
			if (tag10 ~= "eof") then
				if (tag10 ~= "close") then
					if head9["range"] then
						temp12 = (tokPos1["start"]["line"] ~= head9["range"]["start"]["line"])
					else
						temp12 = true
					end
				else
					temp12 = false
				end
			else
				temp12 = false
			end
			if temp12 then
				if previous2 then
					local prevPos1 = previous2["range"]
					if (tokPos1["start"]["line"] ~= prevPos1["start"]["line"]) then
						head9["last-node"] = tok4
						if (tokPos1["start"]["column"] ~= prevPos1["start"]["column"]) then
							putNodeWarning_21_1(logger12, "Different indent compared with previous expressions.", tok4, "You should try to maintain consistent indentation across a program,\ntry to ensure all expressions are lined up.\nIf this looks OK to you, check you're not missing a closing ')'.", prevPos1, "", tokPos1, "")
						end
					end
				else
					head9["last-node"] = tok4
				end
			end
			if ((tag10 == "string") or ((tag10 == "number") or ((tag10 == "symbol") or (tag10 == "key")))) then
				pushCdr_21_1(head9, tok4)
			elseif (tag10 == "open") then
				push_21_1()
				head9["open"] = tok4["contents"]
				head9["close"] = tok4["close"]
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
			elseif (tag10 == "open-struct") then
				push_21_1()
				head9["open"] = tok4["contents"]
				head9["close"] = tok4["close"]
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
				local node58 = ({["tag"]="symbol",["contents"]="struct-literal",["range"]=head9["range"]})
				pushCdr_21_1(head9, node58)
			elseif (tag10 == "close") then
				if empty_3f_1(stack2) then
					doNodeError_21_1(logger12, format1("'%s' without matching '%s'", tok4["contents"], tok4["open"]), tok4, nil, getSource1(tok4), "")
				elseif head9["auto-close"] then
					doNodeError_21_1(logger12, format1("'%s' without matching '%s' inside quote", tok4["contents"], tok4["open"]), tok4, nil, head9["range"], "quote opened here", tok4["range"], "attempting to close here")
				elseif (head9["close"] ~= tok4["contents"]) then
					doNodeError_21_1(logger12, format1("Expected '%s', got '%s'", head9["close"], tok4["contents"]), tok4, nil, head9["range"], format1("block opened with '%s'", head9["open"]), tok4["range"], format1("'%s' used here", tok4["contents"]))
				else
					head9["range"]["finish"] = tok4["range"]["finish"]
					pop_21_1()
				end
			elseif ((tag10 == "quote") or ((tag10 == "unquote") or ((tag10 == "syntax-quote") or ((tag10 == "unquote-splice") or (tag10 == "quasiquote"))))) then
				push_21_1()
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
				local node59 = ({["tag"]="symbol",["contents"]=tag10,["range"]=tok4["range"]})
				pushCdr_21_1(head9, node59)
				autoClose1 = true
				head9["auto-close"] = true
			elseif (tag10 == "eof") then
				if (0 ~= stack2["n"]) then
					eofError_21_1(cont3, logger12, format1("Expected '%s', got 'eof'", head9["close"]), tok4, nil, head9["range"], "block opened here", tok4["range"], "end of file here")
				end
			else
				error1(_2e2e_2("Unsupported type", tag10))
			end
			if autoClose1 then
			else
				local r_11621 = nil
				r_11621 = (function()
					if head9["auto-close"] then
						if empty_3f_1(stack2) then
							doNodeError_21_1(logger12, format1("'%s' without matching '%s'", tok4["contents"], tok4["open"]), tok4, nil, getSource1(tok4), "")
						end
						head9["range"]["finish"] = tok4["range"]["finish"]
						pop_21_1()
						return r_11621()
					else
					end
				end)
				r_11621()
			end
			return r_11271((r_11281 + 1))
		else
		end
	end)
	r_11271(1)
	return head9
end)
read2 = (function(x59, path2)
	return parse1(void2, lex1(void2, x59, (path2 or "")))
end)
compile1 = require1("tacky.compile")["compile"]
Scope3 = require1("tacky.analysis.scope")
requiresInput1 = (function(str7)
	local r_10841 = list1(pcall1((function()
		return parse1(void2, lex1(void2, str7, "<stdin>", true), true)
	end)))
	if ((type1(r_10841) == "list") and ((r_10841["n"] >= 2) and ((r_10841["n"] <= 2) and (eq_3f_1(r_10841[1], true) and true)))) then
		return false
	elseif ((type1(r_10841) == "list") and ((r_10841["n"] >= 2) and ((r_10841["n"] <= 2) and (eq_3f_1(r_10841[1], false) and (type_23_1((r_10841[2])) == "table"))))) then
		if r_10841[2]["cont"] then
			return true
		else
			return false
		end
	elseif ((type1(r_10841) == "list") and ((r_10841["n"] >= 2) and ((r_10841["n"] <= 2) and (eq_3f_1(r_10841[1], false) and true)))) then
		return nil
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10841), ", but none matched.\n", "  Tried: `(true _)`\n  Tried: `(false (as table? ?x))`\n  Tried: `(false _)`"))
	end
end)
doResolve1 = (function(compiler6, scope4, str8)
	local logger13 = compiler6["log"]
	local lexed1 = lex1(logger13, str8, "<stdin>")
	return car1(cdr1((list1(compile1(compiler6, executeStates1, parse1(logger13, lexed1), scope4)))))
end)
if getenv1 then
	local clrs1 = getenv1("URN_COLOURS")
	if clrs1 then
		replColourScheme1 = (read2(clrs1) or nil)
	else
		replColourScheme1 = nil
	end
else
	replColourScheme1 = nil
end
colourFor1 = (function(elem8)
	if assoc_3f_1(replColourScheme1, ({["tag"]="symbol",["contents"]=elem8})) then
		return constVal1(assoc1(replColourScheme1, ({["tag"]="symbol",["contents"]=elem8})))
	else
		if (elem8 == "text") then
			return 0
		elseif (elem8 == "arg") then
			return 36
		elseif (elem8 == "mono") then
			return 97
		elseif (elem8 == "bold") then
			return 1
		elseif (elem8 == "italic") then
			return 3
		elseif (elem8 == "link") then
			return 94
		else
			return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(elem8), ", but none matched.\n", "  Tried: `\"text\"`\n  Tried: `\"arg\"`\n  Tried: `\"mono\"`\n  Tried: `\"bold\"`\n  Tried: `\"italic\"`\n  Tried: `\"link\"`"))
		end
	end
end)
printDocs_21_1 = (function(str9)
	local docs2 = parseDocstring1(str9)
	local r_11051 = docs2["n"]
	local r_11031 = nil
	r_11031 = (function(r_11041)
		if (r_11041 <= r_11051) then
			local tok5 = docs2[r_11041]
			local tag11 = tok5["tag"]
			if (tag11 == "bolic") then
				write1(colored1(colourFor1("bold"), colored1(colourFor1("italic"), tok5["contents"])))
			else
				write1(colored1(colourFor1(tag11), tok5["contents"]))
			end
			return r_11031((r_11041 + 1))
		else
		end
	end)
	r_11031(1)
	return print1()
end)
execCommand1 = (function(compiler7, scope5, args24)
	local logger14 = compiler7["log"]
	local command1 = car1(args24)
	if ((command1 == "help") or (command1 == "h")) then
		return print1("REPL commands:\n[:d]oc NAME        Get documentation about a symbol\n:scope             Print out all variables in the scope\n[:s]earch QUERY    Search the current scope for symbols and documentation containing a string.\n:module NAME       Display a loaded module's docs and definitions.")
	elseif ((command1 == "doc") or (command1 == "d")) then
		local name25 = args24[2]
		if name25 then
			local var35 = Scope3["get"](scope5, name25)
			if (var35 == nil) then
				return self1(logger14, "put-error!", (_2e2e_2("Cannot find '", name25, "'")))
			elseif not var35["doc"] then
				return self1(logger14, "put-error!", (_2e2e_2("No documentation for '", name25, "'")))
			else
				local sig3 = extractSignature1(var35)
				local name26 = var35["fullName"]
				if sig3 then
					local buffer5 = list1(name26)
					local r_11701 = sig3["n"]
					local r_11681 = nil
					r_11681 = (function(r_11691)
						if (r_11691 <= r_11701) then
							pushCdr_21_1(buffer5, sig3[r_11691]["contents"])
							return r_11681((r_11691 + 1))
						else
						end
					end)
					r_11681(1)
					name26 = _2e2e_2("(", concat1(buffer5, " "), ")")
				end
				print1(colored1(96, name26))
				return printDocs_21_1(var35["doc"])
			end
		else
			return self1(logger14, "put-error!", ":doc <variable>")
		end
	elseif (command1 == "module") then
		local name27 = args24[2]
		if name27 then
			local mod1 = compiler7["libNames"][name27]
			if (mod1 == nil) then
				return self1(logger14, "put-error!", (_2e2e_2("Cannot find '", name27, "'")))
			else
				print1(colored1(96, mod1["name"]))
				if mod1["docs"] then
					printDocs_21_1(mod1["docs"])
					print1()
				end
				print1(colored1(92, "Exported symbols"))
				local vars3 = ({tag = "list", n = 0})
				iterPairs1(mod1["scope"]["exported"], (function(name28)
					return pushCdr_21_1(vars3, name28)
				end))
				sort1(vars3)
				return print1(concat1(vars3, "  "))
			end
		else
			return self1(logger14, "put-error!", ":module <variable>")
		end
	elseif (command1 == "scope") then
		local vars4 = ({tag = "list", n = 0})
		local varsSet1 = ({})
		local current1 = scope5
		local r_11721 = nil
		r_11721 = (function()
			if current1 then
				iterPairs1(current1["variables"], (function(name29, var36)
					if varsSet1[name29] then
					else
						pushCdr_21_1(vars4, name29)
						varsSet1[name29] = true
						return nil
					end
				end))
				current1 = current1["parent"]
				return r_11721()
			else
			end
		end)
		r_11721()
		sort1(vars4)
		return print1(concat1(vars4, "  "))
	elseif ((command1 == "search") or (command1 == "s")) then
		if (args24["n"] > 1) then
			local keywords2 = map1(lower1, cdr1(args24))
			local nameResults1 = ({tag = "list", n = 0})
			local docsResults1 = ({tag = "list", n = 0})
			local vars5 = ({tag = "list", n = 0})
			local varsSet2 = ({})
			local current2 = scope5
			local r_11741 = nil
			r_11741 = (function()
				if current2 then
					iterPairs1(current2["variables"], (function(name30, var37)
						if varsSet2[name30] then
						else
							pushCdr_21_1(vars5, name30)
							varsSet2[name30] = true
							return nil
						end
					end))
					current2 = current2["parent"]
					return r_11741()
				else
				end
			end)
			r_11741()
			local r_11791 = vars5["n"]
			local r_11771 = nil
			r_11771 = (function(r_11781)
				if (r_11781 <= r_11791) then
					local var38 = vars5[r_11781]
					local r_11851 = keywords2["n"]
					local r_11831 = nil
					r_11831 = (function(r_11841)
						if (r_11841 <= r_11851) then
							if find1(var38, (keywords2[r_11841])) then
								pushCdr_21_1(nameResults1, var38)
							end
							return r_11831((r_11841 + 1))
						else
						end
					end)
					r_11831(1)
					local docVar1 = Scope3["get"](scope5, var38)
					if docVar1 then
						local tempDocs1 = docVar1["doc"]
						if tempDocs1 then
							local docs3 = lower1(tempDocs1)
							if docs3 then
								local keywordsFound1 = 0
								if keywordsFound1 then
									local r_11911 = keywords2["n"]
									local r_11891 = nil
									r_11891 = (function(r_11901)
										if (r_11901 <= r_11911) then
											if find1(docs3, (keywords2[r_11901])) then
												keywordsFound1 = (keywordsFound1 + 1)
											end
											return r_11891((r_11901 + 1))
										else
										end
									end)
									r_11891(1)
									if eq_3f_1(keywordsFound1, keywords2["n"]) then
										pushCdr_21_1(docsResults1, var38)
									end
								else
								end
							else
							end
						else
						end
					else
					end
					return r_11771((r_11781 + 1))
				else
				end
			end)
			r_11771(1)
			if (empty_3f_1(nameResults1) and empty_3f_1(docsResults1)) then
				return self1(logger14, "put-error!", "No results")
			else
				if not empty_3f_1(nameResults1) then
					print1(colored1(92, "Search by function name:"))
					if (nameResults1["n"] > 20) then
						print1(_2e2e_2(concat1(slice1(nameResults1, 1, 20), "  "), "  ..."))
					else
						print1(concat1(nameResults1, "  "))
					end
				end
				if not empty_3f_1(docsResults1) then
					print1(colored1(92, "Search by function docs:"))
					if (docsResults1["n"] > 20) then
						return print1(_2e2e_2(concat1(slice1(docsResults1, 1, 20), "  "), "  ..."))
					else
						return print1(concat1(docsResults1, "  "))
					end
				else
				end
			end
		else
			return self1(logger14, "put-error!", ":search <keywords>")
		end
	else
		return self1(logger14, "put-error!", (_2e2e_2("Unknown command '", command1, "'")))
	end
end)
execString1 = (function(compiler8, scope6, string1)
	local state37 = doResolve1(compiler8, scope6, string1)
	if (state37["n"] > 0) then
		local current3 = 0
		local exec1 = create3((function()
			local r_12161 = state37["n"]
			local r_12141 = nil
			r_12141 = (function(r_12151)
				if (r_12151 <= r_12161) then
					local elem9 = state37[r_12151]
					current3 = elem9
					self1(current3, "get")
					return r_12141((r_12151 + 1))
				else
				end
			end)
			return r_12141(1)
		end))
		local compileState1 = compiler8["compileState"]
		local rootScope1 = compiler8["rootScope"]
		local global3 = compiler8["global"]
		local logger15 = compiler8["log"]
		local run1 = true
		local r_11071 = nil
		r_11071 = (function()
			if run1 then
				local res10 = list1(resume1(exec1))
				if not car1(res10) then
					self1(logger15, "put-error!", (car1(cdr1(res10))))
					run1 = false
				elseif (status1(exec1) == "dead") then
					local lvl1 = self1(last1(state37), "get")
					print1(_2e2e_2("out = ", colored1(96, pretty1(lvl1))))
					global3[escapeVar1(Scope3["add"](scope6, "out", "defined", lvl1), compileState1)] = lvl1
					run1 = false
				else
					local states2 = car1(cdr1(res10))["states"]
					local latest1 = car1(states2)
					local co1 = create3(executeStates1)
					local task2 = nil
					local r_11941 = nil
					r_11941 = (function()
						if (run1 and (status1(co1) ~= "dead")) then
							compiler8["active-node"] = latest1["node"]
							compiler8["active-scope"] = latest1["scope"]
							local res11
							if task2 then
								res11 = list1(resume1(co1))
							else
								res11 = list1(resume1(co1, compileState1, states2, global3, logger15))
							end
							compiler8["active-node"] = nil
							compiler8["active-scope"] = nil
							if ((type1(res11) == "list") and ((res11["n"] >= 2) and ((res11["n"] <= 2) and (eq_3f_1(res11[1], false) and true)))) then
								error1((res11[2]), 0)
							elseif ((type1(res11) == "list") and ((res11["n"] >= 1) and ((res11["n"] <= 1) and eq_3f_1(res11[1], true)))) then
							elseif ((type1(res11) == "list") and ((res11["n"] >= 2) and ((res11["n"] <= 2) and (eq_3f_1(res11[1], true) and true)))) then
								local arg24 = res11[2]
								if (status1(co1) ~= "dead") then
									task2 = arg24
									local r_12111 = task2["tag"]
									if (r_12111 == "execute") then
										executeStates1(compileState1, task2["states"], global3, logger15)
									else
										_2e2e_2("Cannot handle ", r_12111)
									end
								end
							else
								error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(res11), ", but none matched.\n", "  Tried: `(false ?msg)`\n  Tried: `(true)`\n  Tried: `(true ?arg)`"))
							end
							return r_11941()
						else
						end
					end)
					r_11941()
				end
				return r_11071()
			else
			end
		end)
		return r_11071()
	else
	end
end)
repl1 = (function(compiler9)
	local scope7 = compiler9["rootScope"]
	local logger16 = compiler9["log"]
	local buffer6 = ""
	local running4 = true
	local r_11081 = nil
	r_11081 = (function()
		if running4 then
			write1(colored1(92, (function()
				if empty_3f_1(buffer6) then
					return "> "
				else
					return ". "
				end
			end)()
			))
			flush1()
			local line6 = read1("*l")
			if (not line6 and empty_3f_1(buffer6)) then
				running4 = false
			else
				local data6
				if line6 then
					data6 = _2e2e_2(buffer6, line6, "\n")
				else
					data6 = buffer6
				end
				if (sub1(data6, 1, 1) == ":") then
					buffer6 = ""
					execCommand1(compiler9, scope7, map1(trim1, split1(sub1(data6, 2), " ")))
				elseif (line6 and ((len1(line6) > 0) and requiresInput1(data6))) then
					buffer6 = data6
				else
					buffer6 = ""
					scope7 = Scope3["child"](scope7)
					scope7["isRoot"] = true
					local res12 = list1(pcall1(execString1, compiler9, scope7, data6))
					compiler9["active-node"] = nil
					compiler9["active-scope"] = nil
					if car1(res12) then
					else
						self1(logger16, "put-error!", (car1(cdr1(res12))))
					end
				end
			end
			return r_11081()
		else
		end
	end)
	return r_11081()
end)
exec2 = (function(compiler10)
	local data7 = read1("*a")
	local scope8 = compiler10["rootScope"]
	local logger17 = compiler10["log"]
	local res13 = list1(pcall1(execString1, compiler10, scope8, data7))
	if car1(res13) then
	else
		self1(logger17, "put-error!", (car1(cdr1(res13))))
	end
	return exit1(0)
end)
replTask1 = ({["name"]="repl",["setup"]=(function(spec11)
	return addArgument_21_1(spec11, ({tag = "list", n = 1, "--repl"}), "help", "Start an interactive session.")
end),["pred"]=(function(args25)
	return args25["repl"]
end),["run"]=repl1})
execTask1 = ({["name"]="exec",["setup"]=(function(spec12)
	return addArgument_21_1(spec12, ({tag = "list", n = 1, "--exec"}), "help", "Execute a program without compiling it.")
end),["pred"]=(function(args26)
	return args26["exec"]
end),["run"]=exec2})
profileCalls1 = (function(fn3, mappings3)
	local stats1 = ({})
	local callStack1 = ({tag = "list", n = 0})
	sethook1((function(action1)
		local info1 = getinfo1(2, "Sn")
		local start29 = clock1()
		if (action1 == "call") then
			local previous3 = callStack1[(callStack1["n"])]
			if previous3 then
				previous3["sum"] = (previous3["sum"] + (start29 - previous3["innerStart"]))
			end
		end
		if (action1 ~= "call") then
			if empty_3f_1(callStack1) then
			else
				local current4 = popLast_21_1(callStack1)
				local hash1 = (current4["source"] .. current4["linedefined"])
				local entry9 = stats1[hash1]
				if entry9 then
				else
					entry9 = ({["source"]=current4["source"],["short-src"]=current4["short_src"],["line"]=current4["linedefined"],["name"]=current4["name"],["calls"]=0,["totalTime"]=0,["innerTime"]=0})
					stats1[hash1] = entry9
				end
				entry9["calls"] = (1 + entry9["calls"])
				entry9["totalTime"] = (entry9["totalTime"] + (start29 - current4["totalStart"]))
				entry9["innerTime"] = (entry9["innerTime"] + (current4["sum"] + (start29 - current4["innerStart"])))
			end
		end
		if (action1 ~= "return") then
			info1["totalStart"] = start29
			info1["innerStart"] = start29
			info1["sum"] = 0
			pushCdr_21_1(callStack1, info1)
		end
		if (action1 == "return") then
			local next2 = last1(callStack1)
			if next2 then
				next2["innerStart"] = start29
				return nil
			else
			end
		else
		end
	end), "cr")
	fn3()
	sethook1()
	local out25 = values1(stats1)
	sort1(out25, (function(a3, b3)
		return (a3["innerTime"] > b3["innerTime"])
	end))
	print1("|               Method | Location                                                     |    Total |    Inner |   Calls |")
	print1("| -------------------- | ------------------------------------------------------------ | -------- | -------- | ------- |")
	local r_12341 = out25["n"]
	local r_12321 = nil
	r_12321 = (function(r_12331)
		if (r_12331 <= r_12341) then
			local entry10 = out25[r_12331]
			print1(format1("| %20s | %-60s | %8.5f | %8.5f | %7d | ", (function()
				if entry10["name"] then
					return unmangleIdent1(entry10["name"])
				else
					return "<unknown>"
				end
			end)()
			, remapMessage1(mappings3, _2e2e_2(entry10["short-src"], ":", entry10["line"])), entry10["totalTime"], entry10["innerTime"], entry10["calls"]))
			return r_12321((r_12331 + 1))
		else
		end
	end)
	r_12321(1)
	return stats1
end)
buildStack1 = (function(parent1, stack3, i10, history1, fold2)
	parent1["n"] = (parent1["n"] + 1)
	if (i10 >= 1) then
		local elem10 = stack3[i10]
		local hash2 = _2e2e_2(elem10["source"], "|", elem10["linedefined"])
		local previous4 = (fold2 and history1[hash2])
		local child2 = parent1[hash2]
		if previous4 then
			parent1["n"] = (parent1["n"] - 1)
			child2 = previous4
		end
		if child2 then
		else
			child2 = elem10
			elem10["n"] = 0
			parent1[hash2] = child2
		end
		if previous4 then
		else
			history1[hash2] = child2
		end
		buildStack1(child2, stack3, (i10 - 1), history1, fold2)
		if previous4 then
		else
			history1[hash2] = nil
			return nil
		end
	else
	end
end)
buildRevStack1 = (function(parent2, stack4, i11, history2, fold3)
	parent2["n"] = (parent2["n"] + 1)
	if (i11 <= stack4["n"]) then
		local elem11 = stack4[i11]
		local hash3 = _2e2e_2(elem11["source"], "|", elem11["linedefined"])
		local previous5 = (fold3 and history2[hash3])
		local child3 = parent2[hash3]
		if previous5 then
			parent2["n"] = (parent2["n"] - 1)
			child3 = previous5
		end
		if child3 then
		else
			child3 = elem11
			elem11["n"] = 0
			parent2[hash3] = child3
		end
		if previous5 then
		else
			history2[hash3] = child3
		end
		buildRevStack1(child3, stack4, (i11 + 1), history2, fold3)
		if previous5 then
		else
			history2[hash3] = nil
			return nil
		end
	else
	end
end)
finishStack1 = (function(element1)
	local children1 = ({tag = "list", n = 0})
	iterPairs1(element1, (function(k3, child4)
		if (type_23_1(child4) == "table") then
			return pushCdr_21_1(children1, child4)
		else
		end
	end))
	sort1(children1, (function(a4, b4)
		return (a4["n"] > b4["n"])
	end))
	element1["children"] = children1
	local r_12401 = children1["n"]
	local r_12381 = nil
	r_12381 = (function(r_12391)
		if (r_12391 <= r_12401) then
			finishStack1((children1[r_12391]))
			return r_12381((r_12391 + 1))
		else
		end
	end)
	return r_12381(1)
end)
showStack_21_1 = (function(out26, mappings4, total1, stack5, remaining2)
	line_21_1(out26, format1("└ %s %s %d (%2.5f%%)", (function()
		if stack5["name"] then
			return unmangleIdent1(stack5["name"])
		else
			return "<unknown>"
		end
	end)()
	, remapMessage1(mappings4, _2e2e_2(stack5["short_src"], ":", stack5["linedefined"])), stack5["n"], ((stack5["n"] / total1) * 100)))
	local temp13
	if remaining2 then
		temp13 = (remaining2 >= 1)
	else
		temp13 = true
	end
	if temp13 then
		out26["indent"] = (out26["indent"] + 1)
		local r_12431 = stack5["children"]
		local r_12461 = r_12431["n"]
		local r_12441 = nil
		r_12441 = (function(r_12451)
			if (r_12451 <= r_12461) then
				showStack_21_1(out26, mappings4, total1, r_12431[r_12451], (remaining2 and (remaining2 - 1)))
				return r_12441((r_12451 + 1))
			else
			end
		end)
		r_12441(1)
		out26["indent"] = (out26["indent"] - 1)
		return nil
	else
	end
end)
showFlame_21_1 = (function(mappings5, stack6, before1, remaining3)
	local renamed1 = _2e2e_2((function()
		if stack6["name"] then
			return unmangleIdent1(stack6["name"])
		else
			return "?"
		end
	end)()
	, "`", remapMessage1(mappings5, _2e2e_2(stack6["short_src"], ":", stack6["linedefined"])))
	print1(format1("%s%s %d", before1, renamed1, stack6["n"]))
	local temp14
	if remaining3 then
		temp14 = (remaining3 >= 1)
	else
		temp14 = true
	end
	if temp14 then
		local whole1 = _2e2e_2(before1, renamed1, ";")
		local r_12241 = stack6["children"]
		local r_12271 = r_12241["n"]
		local r_12251 = nil
		r_12251 = (function(r_12261)
			if (r_12261 <= r_12271) then
				showFlame_21_1(mappings5, r_12241[r_12261], whole1, (remaining3 and (remaining3 - 1)))
				return r_12251((r_12261 + 1))
			else
			end
		end)
		return r_12251(1)
	else
	end
end)
profileStack1 = (function(fn4, mappings6, args27)
	local stacks1 = ({tag = "list", n = 0})
	local top1 = getinfo1(2, "S")
	sethook1((function(action2)
		local pos13 = 3
		local stack7 = ({tag = "list", n = 0})
		local info2 = getinfo1(2, "Sn")
		local r_12491 = nil
		r_12491 = (function()
			if info2 then
				if ((info2["source"] == top1["source"]) and (info2["linedefined"] == top1["linedefined"])) then
					info2 = nil
				else
					pushCdr_21_1(stack7, info2)
					pos13 = (pos13 + 1)
					info2 = getinfo1(pos13, "Sn")
				end
				return r_12491()
			else
			end
		end)
		r_12491()
		return pushCdr_21_1(stacks1, stack7)
	end), "", 100000)
	fn4()
	sethook1()
	local folded1 = ({["n"]=0,["name"]="<root>"})
	local r_12551 = stacks1["n"]
	local r_12531 = nil
	r_12531 = (function(r_12541)
		if (r_12541 <= r_12551) then
			local stack8 = stacks1[r_12541]
			if (args27["stack-kind"] == "reverse") then
				buildRevStack1(folded1, stack8, 1, ({}), args27["stack-fold"])
			else
				buildStack1(folded1, stack8, stack8["n"], ({}), args27["stack-fold"])
			end
			return r_12531((r_12541 + 1))
		else
		end
	end)
	r_12531(1)
	finishStack1(folded1)
	if (args27["stack-show"] == "flame") then
		return showFlame_21_1(mappings6, folded1, "", (args27["stack-limit"] or 30))
	else
		local writer14 = create2()
		showStack_21_1(writer14, mappings6, stacks1["n"], folded1, (args27["stack-limit"] or 10))
		return print1(concat1(writer14["out"]))
	end
end)
runLua1 = (function(compiler11, args28)
	if empty_3f_1(args28["input"]) then
		self1(compiler11["log"], "put-error!", "No inputs to run.")
		exit_21_1(1)
	end
	local out27 = file3(compiler11, false)
	local lines9 = generateMappings1(out27["lines"])
	local logger18 = compiler11["log"]
	local name31 = _2e2e_2((args28["output"] or "out"), ".lua")
	local r_12591 = list1(load1(concat1(out27["out"]), _2e2e_2("=", name31)))
	if ((type1(r_12591) == "list") and ((r_12591["n"] >= 2) and ((r_12591["n"] <= 2) and (eq_3f_1(r_12591[1], nil) and true)))) then
		local msg32 = r_12591[2]
		self1(logger18, "put-error!", "Cannot load compiled source.")
		print1(msg32)
		print1(concat1(out27["out"]))
		return exit_21_1(1)
	elseif ((type1(r_12591) == "list") and ((r_12591["n"] >= 1) and ((r_12591["n"] <= 1) and true))) then
		local fun3 = r_12591[1]
		_5f_G1["arg"] = args28["script-args"]
		_5f_G1["arg"][0] = car1(args28["input"])
		local exec3 = (function()
			local r_12701 = list1(xpcall1(fun3, traceback1))
			if ((type1(r_12701) == "list") and ((r_12701["n"] >= 1) and (eq_3f_1(r_12701[1], true) and true))) then
				local res14 = slice1(r_12701, 2)
			elseif ((type1(r_12701) == "list") and ((r_12701["n"] >= 2) and ((r_12701["n"] <= 2) and (eq_3f_1(r_12701[1], false) and true)))) then
				local msg33 = r_12701[2]
				self1(logger18, "put-error!", "Execution failed.")
				print1(remapTraceback1(({[name31]=lines9}), msg33))
				return exit_21_1(1)
			else
				return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_12701), ", but none matched.\n", "  Tried: `(true . ?res)`\n  Tried: `(false ?msg)`"))
			end
		end)
		local r_12691 = args28["profile"]
		if (r_12691 == "none") then
			return exec3()
		elseif eq_3f_1(r_12691, nil) then
			return exec3()
		elseif (r_12691 == "call") then
			return profileCalls1(exec3, ({[name31]=lines9}))
		elseif (r_12691 == "stack") then
			return profileStack1(exec3, ({[name31]=lines9}), args28)
		else
			self1(logger18, "put-error!", (_2e2e_2("Unknown profiler '", r_12691, "'")))
			return exit_21_1(1)
		end
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_12591), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
	end
end)
task3 = ({["name"]="run",["setup"]=(function(spec13)
	addArgument_21_1(spec13, ({tag = "list", n = 2, "--run", "-r"}), "help", "Run the compiled code.")
	addArgument_21_1(spec13, ({tag = "list", n = 2, "--profile", "-p"}), "help", "Run the compiled code with the profiler.", "var", "none|call|stack", "default", nil, "value", "stack", "narg", "?")
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-kind"}), "help", "The kind of stack to emit when using the stack profiler. A reverse stack shows callers of that method instead.", "var", "forward|reverse", "default", "forward", "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-show"}), "help", "The method to use to display the profiling results.", "var", "flame|term", "default", "term", "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-limit"}), "help", "The maximum number of call frames to emit.", "var", "LIMIT", "default", nil, "action", setNumAction1, "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-fold"}), "help", "Whether to fold recursive functions into themselves. This hopefully makes deep graphs easier to understand, but may result in less accurate graphs.", "value", true, "default", false)
	return addArgument_21_1(spec13, ({tag = "list", n = 1, "--"}), "name", "script-args", "help", "Arguments to pass to the compiled script.", "var", "ARG", "all", true, "default", ({tag = "list", n = 0}), "action", addAction1, "narg", "*")
end),["pred"]=(function(args29)
	return (args29["run"] or args29["profile"])
end),["run"]=runLua1})
dotQuote1 = (function(prefix2, name32)
	if find1(name32, "^[%w_][%d%w_]*$") then
		if string_3f_1(prefix2) then
			return _2e2e_2(prefix2, ".", name32)
		else
			return name32
		end
	else
		if string_3f_1(prefix2) then
			return _2e2e_2(prefix2, "[", quoted1(name32), "]")
		else
			return _2e2e_2("_ENV[", quoted1(name32), "]")
		end
	end
end)
genNative1 = (function(compiler12, args30)
	if (args30["input"]["n"] ~= 1) then
		self1(compiler12["log"], "put-error!", "Expected just one input")
		exit_21_1(1)
	end
	local prefix3 = args30["gen-native"]
	local lib3 = compiler12["libCache"][gsub1(last1(args30["input"]), "%.lisp$", "")]
	local escaped3
	if string_3f_1(prefix3) then
		escaped3 = escape1(last1(split1(lib3["name"], "/")))
	else
		escaped3 = nil
	end
	local maxName1 = 0
	local maxQuot1 = 0
	local maxPref1 = 0
	local natives1 = ({tag = "list", n = 0})
	local r_12831 = lib3["out"]
	local r_12861 = r_12831["n"]
	local r_12841 = nil
	r_12841 = (function(r_12851)
		if (r_12851 <= r_12861) then
			local node60 = r_12831[r_12851]
			if ((type1(node60) == "list") and ((type1((car1(node60))) == "symbol") and (car1(node60)["contents"] == "define-native"))) then
				local name33 = node60[2]["contents"]
				pushCdr_21_1(natives1, name33)
				maxName1 = max2(maxName1, len1(quoted1(name33)))
				maxQuot1 = max2(maxQuot1, len1(quoted1(dotQuote1(prefix3, name33))))
				maxPref1 = max2(maxPref1, len1(dotQuote1(escaped3, name33)))
			end
			return r_12841((r_12851 + 1))
		else
		end
	end)
	r_12841(1)
	sort1(natives1)
	local handle4 = open1(_2e2e_2(lib3["path"], ".meta.lua"), "w")
	local format3 = _2e2e_2("\9[%-", tostring1((maxName1 + 3)), "s { tag = \"var\", contents = %-", tostring1((maxQuot1 + 1)), "s value = %-", tostring1((maxPref1 + 1)), "s },\n")
	if handle4 then
	else
		self1(compiler12["log"], "put-error!", (_2e2e_2("Cannot write to ", lib3["path"], ".meta.lua")))
		exit_21_1(1)
	end
	if string_3f_1(prefix3) then
		self1(handle4, "write", format1("local %s = %s or {}\n", escaped3, prefix3))
	end
	self1(handle4, "write", "return {\n")
	local r_12941 = natives1["n"]
	local r_12921 = nil
	r_12921 = (function(r_12931)
		if (r_12931 <= r_12941) then
			local native3 = natives1[r_12931]
			self1(handle4, "write", format1(format3, _2e2e_2(quoted1(native3), "] ="), _2e2e_2(quoted1(dotQuote1(prefix3, native3)), ","), _2e2e_2(dotQuote1(escaped3, native3), ",")))
			return r_12921((r_12931 + 1))
		else
		end
	end)
	r_12921(1)
	self1(handle4, "write", "}\n")
	return self1(handle4, "close")
end)
task4 = ({["name"]="gen-native",["setup"]=(function(spec14)
	return addArgument_21_1(spec14, ({tag = "list", n = 1, "--gen-native"}), "help", "Generate native bindings for a file", "var", "PREFIX", "narg", "?")
end),["pred"]=(function(args31)
	return args31["gen-native"]
end),["run"]=genNative1})
scope_2f_child2 = require1("tacky.analysis.scope")["child"]
compile2 = require1("tacky.compile")["compile"]
simplifyPath1 = (function(path3, paths1)
	local current5 = path3
	local r_13001 = paths1["n"]
	local r_12981 = nil
	r_12981 = (function(r_12991)
		if (r_12991 <= r_13001) then
			local search1 = paths1[r_12991]
			local sub6 = match1(path3, _2e2e_2("^", gsub1(search1, "%?", "(.*)"), "$"))
			if (sub6 and (len1(sub6) < len1(current5))) then
				current5 = sub6
			end
			return r_12981((r_12991 + 1))
		else
		end
	end)
	r_12981(1)
	return current5
end)
readMeta1 = (function(state38, name34, entry11)
	if (((entry11["tag"] == "expr") or (entry11["tag"] == "stmt")) and string_3f_1(entry11["contents"])) then
		local buffer7 = ({tag = "list", n = 0})
		local str10 = entry11["contents"]
		local idx8 = 0
		local max6 = 0
		local len14 = len1(str10)
		local r_13051 = nil
		r_13051 = (function()
			if (idx8 <= len14) then
				local r_13061 = list1(find1(str10, "%${(%d+)}", idx8))
				if ((type1(r_13061) == "list") and ((r_13061["n"] >= 2) and true)) then
					local start30 = r_13061[1]
					local finish13 = r_13061[2]
					if (start30 > idx8) then
						pushCdr_21_1(buffer7, sub1(str10, idx8, (start30 - 1)))
					end
					local val20 = tonumber1(sub1(str10, (start30 + 2), (finish13 - 1)))
					pushCdr_21_1(buffer7, val20)
					if (val20 > max6) then
						max6 = val20
					end
					idx8 = (finish13 + 1)
				else
					pushCdr_21_1(buffer7, sub1(str10, idx8, len14))
					idx8 = (len14 + 1)
				end
				return r_13051()
			else
			end
		end)
		r_13051()
		if entry11["count"] then
		else
			entry11["count"] = max6
		end
		entry11["contents"] = buffer7
	end
	local fold4 = entry11["fold"]
	if fold4 then
		if (entry11["tag"] ~= "expr") then
			error1(_2e2e_2("Cannot have fold for non-expression ", name34), 0)
		end
		if ((fold4 ~= "l") and (fold4 ~= "r")) then
			error1(_2e2e_2("Unknown fold ", fold4, " for ", name34), 0)
		end
		if (entry11["count"] ~= 2) then
			error1(_2e2e_2("Cannot have fold for length ", entry11["count"], " for ", name34), 0)
		end
	end
	entry11["name"] = name34
	if (entry11["value"] == nil) then
		local value11 = state38["libEnv"][name34]
		if (value11 == nil) then
			local r_13131 = list1(pcall1(native2, entry11, state38["global"]))
			if ((type1(r_13131) == "list") and ((r_13131["n"] >= 1) and (eq_3f_1(r_13131[1], true) and true))) then
				value11 = car1((slice1(r_13131, 2)))
			elseif ((type1(r_13131) == "list") and ((r_13131["n"] >= 2) and ((r_13131["n"] <= 2) and (eq_3f_1(r_13131[1], false) and true)))) then
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13131), ", but none matched.\n", "  Tried: `(true . ?res)`\n  Tried: `(false _)`"))
			end
			state38["libEnv"][name34] = value11
		end
		entry11["value"] = value11
	elseif (state38["libEnv"][name34] ~= nil) then
		error1(_2e2e_2("Duplicate value for ", name34, ": in native and meta file"), 0)
	else
		state38["libEnv"][name34] = entry11["value"]
	end
	state38["libMeta"][name34] = entry11
	return entry11
end)
readLibrary1 = (function(state39, name35, path4, lispHandle1)
	self1(state39["log"], "put-verbose!", (_2e2e_2("Loading ", path4, " into ", name35)))
	local prefix4 = _2e2e_2(name35, "-", state39["libs"]["n"], "/")
	local lib4 = ({["name"]=name35,["prefix"]=prefix4,["path"]=path4})
	local contents2 = self1(lispHandle1, "read", "*a")
	self1(lispHandle1, "close")
	local handle5 = open1(_2e2e_2(path4, ".lua"), "r")
	if handle5 then
		local contents3 = self1(handle5, "read", "*a")
		self1(handle5, "close")
		lib4["native"] = contents3
		local r_13241 = list1(load1(contents3, _2e2e_2("@", name35)))
		if ((type1(r_13241) == "list") and ((r_13241["n"] >= 2) and ((r_13241["n"] <= 2) and (eq_3f_1(r_13241[1], nil) and true)))) then
			error1((r_13241[2]), 0)
		elseif ((type1(r_13241) == "list") and ((r_13241["n"] >= 1) and ((r_13241["n"] <= 1) and true))) then
			local fun4 = r_13241[1]
			local res15 = fun4()
			if (type_23_1(res15) == "table") then
				iterPairs1(res15, (function(k4, v5)
					state39["libEnv"][_2e2e_2(prefix4, k4)] = v5
					return nil
				end))
			else
				error1(_2e2e_2(path4, ".lua returned a non-table value"), 0)
			end
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13241), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
	local handle6 = open1(_2e2e_2(path4, ".meta.lua"), "r")
	if handle6 then
		local contents4 = self1(handle6, "read", "*a")
		self1(handle6, "close")
		local r_13341 = list1(load1(contents4, _2e2e_2("@", name35)))
		if ((type1(r_13341) == "list") and ((r_13341["n"] >= 2) and ((r_13341["n"] <= 2) and (eq_3f_1(r_13341[1], nil) and true)))) then
			error1((r_13341[2]), 0)
		elseif ((type1(r_13341) == "list") and ((r_13341["n"] >= 1) and ((r_13341["n"] <= 1) and true))) then
			local fun5 = r_13341[1]
			local res16 = fun5()
			if (type_23_1(res16) == "table") then
				iterPairs1(res16, (function(k5, v6)
					return readMeta1(state39, _2e2e_2(prefix4, k5), v6)
				end))
			else
				error1(_2e2e_2(path4, ".meta.lua returned a non-table value"), 0)
			end
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13341), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
	startTimer_21_1(state39["timer"], _2e2e_2("[parse] ", path4), 2)
	local lexed2 = lex1(state39["log"], contents2, _2e2e_2(path4, ".lisp"))
	local parsed1 = parse1(state39["log"], lexed2)
	local scope9 = scope_2f_child2(state39["rootScope"])
	scope9["isRoot"] = true
	scope9["prefix"] = prefix4
	lib4["scope"] = scope9
	stopTimer_21_1(state39["timer"], _2e2e_2("[parse] ", path4))
	local compiled1 = compile2(state39, executeStates1, parsed1, scope9, path4)
	pushCdr_21_1(state39["libs"], lib4)
	if string_3f_1(car1(compiled1)) then
		lib4["docs"] = constVal1(car1(compiled1))
		removeNth_21_1(compiled1, 1)
	end
	lib4["out"] = compiled1
	local r_13481 = compiled1["n"]
	local r_13461 = nil
	r_13461 = (function(r_13471)
		if (r_13471 <= r_13481) then
			local node61 = compiled1[r_13471]
			pushCdr_21_1(state39["out"], node61)
			return r_13461((r_13471 + 1))
		else
		end
	end)
	r_13461(1)
	self1(state39["log"], "put-verbose!", (_2e2e_2("Loaded ", path4, " into ", name35)))
	return lib4
end)
pathLocator1 = (function(state40, name36)
	local searched1
	local paths2
	local searcher1
	searched1 = ({tag = "list", n = 0})
	paths2 = state40["paths"]
	searcher1 = (function(i12)
		if (i12 > paths2["n"]) then
			return list1(nil, _2e2e_2("Cannot find ", quoted1(name36), ".\nLooked in ", concat1(searched1, ", ")))
		else
			local path5 = gsub1(paths2[i12], "%?", name36)
			local cached1 = state40["libCache"][path5]
			pushCdr_21_1(searched1, path5)
			if (cached1 == nil) then
				local handle7 = open1(_2e2e_2(path5, ".lisp"), "r")
				if handle7 then
					state40["libCache"][path5] = true
					state40["libNames"][name36] = true
					local lib5 = readLibrary1(state40, simplifyPath1(path5, paths2), path5, handle7)
					state40["libCache"][path5] = lib5
					state40["libNames"][name36] = lib5
					return list1(lib5)
				else
					return searcher1((i12 + 1))
				end
			elseif (cached1 == true) then
				return list1(nil, _2e2e_2("Already loading ", name36))
			else
				return list1(cached1)
			end
		end
	end)
	return searcher1(1)
end)
loader1 = (function(state41, name37, shouldResolve1)
	if shouldResolve1 then
		local cached2 = state41["libNames"][name37]
		if (cached2 == nil) then
			return pathLocator1(state41, name37)
		elseif (cached2 == true) then
			return list1(nil, _2e2e_2("Already loading ", name37))
		else
			return list1(cached2)
		end
	else
		name37 = gsub1(name37, "%.lisp$", "")
		local r_13231 = state41["libCache"][name37]
		if eq_3f_1(r_13231, nil) then
			local handle8 = open1(_2e2e_2(name37, ".lisp"))
			if handle8 then
				state41["libCache"][name37] = true
				local lib6 = readLibrary1(state41, simplifyPath1(name37, state41["paths"]), name37, handle8)
				state41["libCache"][name37] = lib6
				return list1(lib6)
			else
				return list1(nil, _2e2e_2("Cannot find ", quoted1(name37)))
			end
		elseif eq_3f_1(r_13231, true) then
			return list1(nil, _2e2e_2("Already loading ", name37))
		else
			return list1(r_13231)
		end
	end
end)
printError_21_1 = (function(msg34)
	if string_3f_1(msg34) then
	else
		msg34 = pretty1(msg34)
	end
	local lines10 = split1(msg34, "\n", 1)
	print1(colored1(31, _2e2e_2("[ERROR] ", car1(lines10))))
	if car1(cdr1(lines10)) then
		return print1(car1(cdr1(lines10)))
	else
	end
end)
printWarning_21_1 = (function(msg35)
	local lines11 = split1(msg35, "\n", 1)
	print1(colored1(33, _2e2e_2("[WARN] ", car1(lines11))))
	if car1(cdr1(lines11)) then
		return print1(car1(cdr1(lines11)))
	else
	end
end)
printVerbose_21_1 = (function(verbosity1, msg36)
	if (verbosity1 > 0) then
		return print1(_2e2e_2("[VERBOSE] ", msg36))
	else
	end
end)
printDebug_21_1 = (function(verbosity2, msg37)
	if (verbosity2 > 1) then
		return print1(_2e2e_2("[DEBUG] ", msg37))
	else
	end
end)
printTime_21_1 = (function(maximum1, name38, time1, level5)
	if (level5 <= maximum1) then
		return print1(_2e2e_2("[TIME] ", name38, " took ", time1))
	else
	end
end)
printExplain_21_1 = (function(explain5, lines12)
	if explain5 then
		local r_13581 = split1(lines12, "\n")
		local r_13611 = r_13581["n"]
		local r_13591 = nil
		r_13591 = (function(r_13601)
			if (r_13601 <= r_13611) then
				print1(_2e2e_2("  ", (r_13581[r_13601])))
				return r_13591((r_13601 + 1))
			else
			end
		end)
		return r_13591(1)
	else
	end
end)
create4 = (function(verbosity3, explain6, time2)
	return ({["verbosity"]=(verbosity3 or 0),["explain"]=(explain6 == true),["time"]=(time2 or 0),["put-error!"]=putError_21_2,["put-warning!"]=putWarning_21_2,["put-verbose!"]=putVerbose_21_2,["put-debug!"]=putDebug_21_2,["put-time!"]=putTime_21_1,["put-node-error!"]=putNodeError_21_2,["put-node-warning!"]=putNodeWarning_21_2})
end)
putError_21_2 = (function(logger19, msg38)
	return printError_21_1(msg38)
end)
putWarning_21_2 = (function(logger20, msg39)
	return printWarning_21_1(msg39)
end)
putVerbose_21_2 = (function(logger21, msg40)
	return printVerbose_21_1(logger21["verbosity"], msg40)
end)
putDebug_21_2 = (function(logger22, msg41)
	return printDebug_21_1(logger22["verbosity"], msg41)
end)
putTime_21_1 = (function(logger23, name39, time3, level6)
	return printTime_21_1(logger23["time"], name39, time3, level6)
end)
putNodeError_21_2 = (function(logger24, msg42, node62, explain7, lines13)
	printError_21_1(msg42)
	putTrace_21_1(node62)
	if explain7 then
		printExplain_21_1(logger24["explain"], explain7)
	end
	return putLines_21_1(true, lines13)
end)
putNodeWarning_21_2 = (function(logger25, msg43, node63, explain8, lines14)
	printWarning_21_1(msg43)
	putTrace_21_1(node63)
	if explain8 then
		printExplain_21_1(logger25["explain"], explain8)
	end
	return putLines_21_1(true, lines14)
end)
putLines_21_1 = (function(range6, entries2)
	if empty_3f_1(entries2) then
		error1("Positions cannot be empty")
	end
	if ((entries2["n"] % 2) ~= 0) then
		error1(_2e2e_2("Positions must be a multiple of 2, is ", entries2["n"]))
	end
	local previous6 = -1
	local file4 = entries2[1]["name"]
	local maxLine1 = foldr1((function(max7, node64)
		if string_3f_1(node64) then
			return max7
		else
			return max2(max7, node64["start"]["line"])
		end
	end), 0, entries2)
	local code3 = _2e2e_2(colored1(92, _2e2e_2(" %", len1(tostring1(maxLine1)), "s │")), " %s")
	local r_13541 = entries2["n"]
	local r_13521 = nil
	r_13521 = (function(r_13531)
		if (r_13531 <= r_13541) then
			local position1 = entries2[r_13531]
			local message1 = entries2[(r_13531 + 1)]
			if (file4 ~= position1["name"]) then
				file4 = position1["name"]
				print1(colored1(95, _2e2e_2(" ", file4)))
			elseif ((previous6 ~= -1) and (abs1((position1["start"]["line"] - previous6)) > 2)) then
				print1(colored1(92, " ..."))
			end
			previous6 = position1["start"]["line"]
			print1(format1(code3, tostring1(position1["start"]["line"]), position1["lines"][position1["start"]["line"]]))
			local pointer1
			if not range6 then
				pointer1 = "^"
			elseif (position1["finish"] and (position1["start"]["line"] == position1["finish"]["line"])) then
				pointer1 = rep1("^", ((position1["finish"]["column"] - position1["start"]["column"]) + 1))
			else
				pointer1 = "^..."
			end
			print1(format1(code3, "", _2e2e_2(rep1(" ", (position1["start"]["column"] - 1)), pointer1, " ", message1)))
			return r_13521((r_13531 + 2))
		else
		end
	end)
	return r_13521(1)
end)
putTrace_21_1 = (function(node65)
	local previous7 = nil
	local r_13561 = nil
	r_13561 = (function()
		if node65 then
			local formatted1 = formatNode1(node65)
			if (previous7 == nil) then
				print1(colored1(96, _2e2e_2("  => ", formatted1)))
			elseif (previous7 ~= formatted1) then
				print1(_2e2e_2("  in ", formatted1))
			else
			end
			previous7 = formatted1
			node65 = node65["parent"]
			return r_13561()
		else
		end
	end)
	return r_13561()
end)
Scope4 = require1("tacky.analysis.scope")
createPluginState1 = (function(compiler13)
	local logger26 = compiler13["log"]
	local variables1 = compiler13["variables"]
	local states3 = compiler13["states"]
	local warnings1 = compiler13["warning"]
	local optimise3 = compiler13["optimise"]
	local activeScope1 = (function()
		return compiler13["active-scope"]
	end)
	local activeNode1 = (function()
		return compiler13["active-node"]
	end)
	return ({["add-categoriser!"]=(function()
		return error1("add-categoriser! is not yet implemented", 0)
	end),["categorise-node"]=visitNode2,["categorise-nodes"]=visitNodes1,["cat"]=cat3,["writer/append!"]=append_21_1,["writer/line!"]=line_21_1,["writer/indent!"]=indent_21_1,["writer/unindent!"]=unindent_21_1,["writer/begin-block!"]=beginBlock_21_1,["writer/next-block!"]=nextBlock_21_1,["writer/end-block!"]=endBlock_21_1,["add-emitter!"]=(function()
		return error1("add-emitter! is not yet implemented", 0)
	end),["emit-node"]=expression2,["emit-block"]=block2,["logger/put-error!"]=(function(r_13651)
		return self1(logger26, "put-error!", r_13651)
	end),["logger/put-warning!"]=(function(r_13661)
		return self1(logger26, "put-warning!", r_13661)
	end),["logger/put-verbose!"]=(function(r_13671)
		return self1(logger26, "put-verbose!", r_13671)
	end),["logger/put-debug!"]=(function(r_13681)
		return self1(logger26, "put-debug!", r_13681)
	end),["logger/put-node-error!"]=(function(msg44, node66, explain9, ...)
		local lines15 = _pack(...) lines15.tag = "list"
		return putNodeError_21_1(logger26, msg44, node66, explain9, unpack1(lines15, 1, lines15["n"]))
	end),["logger/put-node-warning!"]=(function(msg45, node67, explain10, ...)
		local lines16 = _pack(...) lines16.tag = "list"
		return putNodeWarning_21_1(logger26, msg45, node67, explain10, unpack1(lines16, 1, lines16["n"]))
	end),["logger/do-node-error!"]=(function(msg46, node68, explain11, ...)
		local lines17 = _pack(...) lines17.tag = "list"
		return doNodeError_21_1(logger26, msg46, node68, explain11, unpack1(lines17, 1, lines17["n"]))
	end),["range/get-source"]=getSource1,["visit-node"]=visitNode1,["visit-nodes"]=visitBlock1,["traverse-nodes"]=traverseNode1,["traverse-nodes"]=traverseList1,["symbol->var"]=(function(x60)
		local var39 = x60["var"]
		if string_3f_1(var39) then
			return variables1[var39]
		else
			return var39
		end
	end),["var->symbol"]=makeSymbol1,["builtin?"]=builtin_3f_1,["constant?"]=constant_3f_1,["node->val"]=urn_2d3e_val1,["val->node"]=val_2d3e_urn1,["add-pass!"]=(function(pass3)
		local r_13691 = type1(pass3)
		if (r_13691 ~= "table") then
			error1(format1("bad argument %s (expected %s, got %s)", "pass", "table", r_13691), 2)
		end
		if string_3f_1(pass3["name"]) then
		else
			error1(_2e2e_2("Expected string for name, got ", type1(pass3["name"])))
		end
		if invokable_3f_1(pass3["run"]) then
		else
			error1(_2e2e_2("Expected function for run, got ", type1(pass3["run"])))
		end
		if (type1((pass3["cat"])) == "list") then
		else
			error1(_2e2e_2("Expected list for cat, got ", type1(pass3["cat"])))
		end
		local cats1 = pass3["cat"]
		local group1
		if elem_3f_1("usage", cats1) then
			group1 = "usage"
		else
			group1 = "normal"
		end
		if elem_3f_1("opt", cats1) then
			pushCdr_21_1(optimise3[group1], pass3)
		elseif elem_3f_1("warn", cats1) then
			pushCdr_21_1(warnings1[group1], pass3)
		else
			error1(_2e2e_2("Cannot register ", pretty1(pass3["name"]), " (do not know how to process ", pretty1(cats1), ")"))
		end
		return nil
	end),["var-usage"]=getVar1,["active-scope"]=activeScope1,["active-node"]=activeNode1,["active-module"]=(function()
		local get1
		get1 = (function(scp1)
			if scp1["isRoot"] then
				return scp1
			else
				return get1(scp1["parent"])
			end
		end)
		return get1(compiler13["active-scope"])
	end),["scope-vars"]=(function(scp2)
		if not scp2 then
			return compiler13["active-scope"]["variables"]
		else
			return scp2["variables"]
		end
	end),["var-lookup"]=(function(symb1, scope10)
		local r_13701 = type1(symb1)
		if (r_13701 ~= "symbol") then
			error1(format1("bad argument %s (expected %s, got %s)", "symb", "symbol", r_13701), 2)
		end
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		if scope10 then
		else
			scope10 = compiler13["active-scope"]
		end
		return Scope4["getAlways"](scope10, symbol_2d3e_string1(symb1), compiler13["active-node"])
	end),["var-definition"]=(function(var40)
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		local state42 = states3[var40]
		if state42 then
			if (state42["stage"] == "parsed") then
				yield1(({["tag"]="build",["state"]=state42}))
			end
			return state42["node"]
		else
		end
	end),["var-value"]=(function(var41)
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		local state43 = states3[var41]
		if state43 then
			return self1(state43, "get")
		else
		end
	end),["var-docstring"]=(function(var42)
		return var42["doc"]
	end)})
end)
rootScope2 = require1("tacky.analysis.resolve")["rootScope"]
scope_2f_child3 = require1("tacky.analysis.scope")["child"]
scope_2f_import_21_1 = require1("tacky.analysis.scope")["import"]
local spec15 = create1()
local directory1
local dir1 = arg1[0]
dir1 = gsub1(dir1, "\\", "/")
dir1 = gsub1(dir1, "urn/cli%.lisp$", "")
dir1 = gsub1(dir1, "urn/cli$", "")
dir1 = gsub1(dir1, "tacky/cli%.lua$", "")
if ((dir1 ~= "") and (sub1(dir1, -1, -1) ~= "/")) then
	dir1 = _2e2e_2(dir1, "/")
end
local r_14301 = nil
r_14301 = (function()
	if (sub1(dir1, 1, 2) == "./") then
		dir1 = sub1(dir1, 3)
		return r_14301()
	else
	end
end)
r_14301()
directory1 = dir1
local paths3 = list1("?", "?/init", _2e2e_2(directory1, "lib/?"), _2e2e_2(directory1, "lib/?/init"))
local tasks1 = list1(warning1, optimise2, emitLisp1, emitLua1, task1, task4, task3, execTask1, replTask1)
addHelp_21_1(spec15)
addArgument_21_1(spec15, ({tag = "list", n = 2, "--explain", "-e"}), "help", "Explain error messages in more detail.")
addArgument_21_1(spec15, ({tag = "list", n = 2, "--time", "-t"}), "help", "Time how long each task takes to execute. Multiple usages will show more detailed timings.", "many", true, "default", 0, "action", (function(arg25, data8)
	data8[arg25["name"]] = ((data8[arg25["name"]] or 0) + 1)
	return nil
end))
addArgument_21_1(spec15, ({tag = "list", n = 2, "--verbose", "-v"}), "help", "Make the output more verbose. Can be used multiple times", "many", true, "default", 0, "action", (function(arg26, data9)
	data9[arg26["name"]] = ((data9[arg26["name"]] or 0) + 1)
	return nil
end))
addArgument_21_1(spec15, ({tag = "list", n = 2, "--include", "-i"}), "help", "Add an additional argument to the include path.", "many", true, "narg", 1, "default", ({tag = "list", n = 0}), "action", addAction1)
addArgument_21_1(spec15, ({tag = "list", n = 2, "--prelude", "-p"}), "help", "A custom prelude path to use.", "narg", 1, "default", _2e2e_2(directory1, "lib/prelude"))
addArgument_21_1(spec15, ({tag = "list", n = 3, "--output", "--out", "-o"}), "help", "The destination to output to.", "narg", 1, "default", "out")
addArgument_21_1(spec15, ({tag = "list", n = 2, "--wrapper", "-w"}), "help", "A wrapper script to launch Urn with", "narg", 1, "action", (function(a5, b5, value12)
	local args32 = map1(id1, arg1)
	local i13 = 1
	local len15 = args32["n"]
	local r_13731 = nil
	r_13731 = (function()
		if (i13 <= len15) then
			local item2 = args32[i13]
			if ((item2 == "--wrapper") or (item2 == "-w")) then
				removeNth_21_1(args32, i13)
				removeNth_21_1(args32, i13)
				i13 = (len15 + 1)
			elseif find1(item2, "^%-%-wrapper=.*$") then
				removeNth_21_1(args32, i13)
				i13 = (len15 + 1)
			elseif find1(item2, "^%-[^-]+w$") then
				args32[i13] = sub1(item2, 1, -2)
				removeNth_21_1(args32, (i13 + 1))
				i13 = (len15 + 1)
			end
			return r_13731()
		else
		end
	end)
	r_13731()
	local command2 = list1(value12)
	local interp1 = arg1[-1]
	if interp1 then
		pushCdr_21_1(command2, interp1)
	end
	pushCdr_21_1(command2, arg1[0])
	local r_13751 = list1(execute1(concat1(append1(command2, args32), " ")))
	if ((type1(r_13751) == "list") and ((r_13751["n"] >= 3) and ((r_13751["n"] <= 3) and true))) then
		return exit1((r_13751[3]))
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13751), ", but none matched.\n", "  Tried: `(_ _ ?code)`"))
	end
end))
addArgument_21_1(spec15, ({tag = "list", n = 1, "--plugin"}), "help", "Specify a compiler plugin to load.", "var", "FILE", "default", ({tag = "list", n = 0}), "narg", 1, "many", true, "action", addAction1)
addArgument_21_1(spec15, ({tag = "list", n = 1, "input"}), "help", "The file(s) to load.", "var", "FILE", "narg", "*")
local r_13861 = tasks1["n"]
local r_13841 = nil
r_13841 = (function(r_13851)
	if (r_13851 <= r_13861) then
		local task5 = tasks1[r_13851]
		task5["setup"](spec15)
		return r_13841((r_13851 + 1))
	else
	end
end)
r_13841(1)
local args33 = parse_21_1(spec15)
local logger27 = create4(args33["verbose"], args33["explain"], args33["time"])
local r_13891 = args33["include"]
local r_13921 = r_13891["n"]
local r_13901 = nil
r_13901 = (function(r_13911)
	if (r_13911 <= r_13921) then
		local path6 = r_13891[r_13911]
		path6 = gsub1(path6, "\\", "/")
		path6 = gsub1(path6, "^%./", "")
		if find1(path6, "%?") then
		else
			path6 = _2e2e_2(path6, (function()
				if (sub1(path6, -1, -1) == "/") then
					return "?"
				else
					return "/?"
				end
			end)()
			)
		end
		pushCdr_21_1(paths3, path6)
		return r_13901((r_13911 + 1))
	else
	end
end)
r_13901(1)
self1(logger27, "put-verbose!", (_2e2e_2("Using path: ", pretty1(paths3))))
if empty_3f_1(args33["input"]) then
	args33["repl"] = true
else
	args33["emit-lua"] = true
end
local compiler14 = ({["log"]=logger27,["timer"]=({["callback"]=(function(r_14261, r_14271, r_14281)
	return self1(logger27, "put-time!", r_14261, r_14271, r_14281)
end),["timers"]=({})}),["paths"]=paths3,["libEnv"]=({}),["libMeta"]=({}),["libs"]=({tag = "list", n = 0}),["libCache"]=({}),["libNames"]=({}),["warning"]=({["normal"]=list1(documentation1),["usage"]=list1(checkArity1, deprecated1)}),["optimise"]=default1(),["rootScope"]=rootScope2,["variables"]=({}),["states"]=({}),["out"]=({tag = "list", n = 0})})
compiler14["compileState"] = createState1(compiler14["libMeta"])
compiler14["loader"] = (function(name40)
	return loader1(compiler14, name40, true)
end)
compiler14["global"] = setmetatable1(({["_libs"]=compiler14["libEnv"],["_compiler"]=createPluginState1(compiler14)}), ({["__index"]=_5f_G1}))
iterPairs1(compiler14["rootScope"]["variables"], (function(_5f_3, var43)
	compiler14["variables"][tostring1(var43)] = var43
	return nil
end))
startTimer_21_1(compiler14["timer"], "loading")
local r_13941 = loader1(compiler14, args33["prelude"], false)
if ((type1(r_13941) == "list") and ((r_13941["n"] >= 2) and ((r_13941["n"] <= 2) and (eq_3f_1(r_13941[1], nil) and true)))) then
	local errorMessage1 = r_13941[2]
	self1(logger27, "put-error!", errorMessage1)
	exit_21_1(1)
elseif ((type1(r_13941) == "list") and ((r_13941["n"] >= 1) and ((r_13941["n"] <= 1) and true))) then
	local lib7 = r_13941[1]
	compiler14["rootScope"] = scope_2f_child3(compiler14["rootScope"])
	iterPairs1(lib7["scope"]["exported"], (function(name41, var44)
		return scope_2f_import_21_1(compiler14["rootScope"], name41, var44)
	end))
	local r_14051 = append1(args33["plugin"], args33["input"])
	local r_14081 = r_14051["n"]
	local r_14061 = nil
	r_14061 = (function(r_14071)
		if (r_14071 <= r_14081) then
			local input1 = r_14051[r_14071]
			local r_14101 = loader1(compiler14, input1, false)
			if ((type1(r_14101) == "list") and ((r_14101["n"] >= 2) and ((r_14101["n"] <= 2) and (eq_3f_1(r_14101[1], nil) and true)))) then
				local errorMessage2 = r_14101[2]
				self1(logger27, "put-error!", errorMessage2)
				exit_21_1(1)
			elseif ((type1(r_14101) == "list") and ((r_14101["n"] >= 1) and ((r_14101["n"] <= 1) and true))) then
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_14101), ", but none matched.\n", "  Tried: `(nil ?error-message)`\n  Tried: `(_)`"))
			end
			return r_14061((r_14071 + 1))
		else
		end
	end)
	r_14061(1)
else
	error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13941), ", but none matched.\n", "  Tried: `(nil ?error-message)`\n  Tried: `(?lib)`"))
end
stopTimer_21_1(compiler14["timer"], "loading")
local r_14241 = tasks1["n"]
local r_14221 = nil
r_14221 = (function(r_14231)
	if (r_14231 <= r_14241) then
		local task6 = tasks1[r_14231]
		if task6["pred"](args33) then
			startTimer_21_1(compiler14["timer"], task6["name"], 1)
			task6["run"](compiler14, args33)
			stopTimer_21_1(compiler14["timer"], task6["name"])
		end
		return r_14221((r_14231 + 1))
	else
	end
end)
return r_14221(1)
