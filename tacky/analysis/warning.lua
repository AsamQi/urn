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
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _2b_1, _2d_1, _25_1, slice1, error1, next1, getIdx1, setIdx_21_1, require1, tonumber1, type_23_1, _23_1, format1, match1, concat1, remove1, unpack1, emptyStruct1, iterPairs1, car1, cdr1, list1, cons1, _21_1, list_3f_1, nil_3f_1, symbol_3f_1, key_3f_1, exists_3f_1, type1, car2, cdr2, foldr1, map1, any1, nth1, pushCdr_21_1, removeNth_21_1, reverse1, caar1, cadr1, _2e2e_1, struct1, _23_keys1, succ1, pred1, symbol_2d3e_string1, fail_21_1, self1, builtins1, visitQuote1, visitNode1, visitBlock1, builtins2, builtinVars1, createState1, getVar1, getNode1, addUsage_21_1, addDefinition_21_1, definitionsVisitor1, definitionsVisit1, usagesVisit1, putError_21_1, putWarning_21_1, putVerbose_21_1, putDebug_21_1, putNodeError_21_1, putNodeWarning_21_1, doNodeError_21_1, formatPosition1, formatRange1, formatNode1, getSource1, builtins3, sideEffect_3f_1, warnArity1, analyse1
_3d_1 = function(v1, v2) return (v1 == v2) end
_2f3d_1 = function(v1, v2) return (v1 ~= v2) end
_3c_1 = function(v1, v2) return (v1 < v2) end
_3c3d_1 = function(v1, v2) return (v1 <= v2) end
_3e_1 = function(v1, v2) return (v1 > v2) end
_2b_1 = function(v1, v2) return (v1 + v2) end
_2d_1 = function(v1, v2) return (v1 - v2) end
_25_1 = function(v1, v2) return (v1 % v2) end
slice1 = _libs["lua/basic-0/slice"]
error1 = error
next1 = next
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
require1 = require
tonumber1 = tonumber
type_23_1 = type
_23_1 = (function(x1)
	return x1["n"]
end)
format1 = string.format
match1 = string.match
concat1 = table.concat
remove1 = table.remove
unpack1 = table.unpack
emptyStruct1 = function() return {} end
iterPairs1 = function(x, f) for k, v in pairs(x) do f(k, v) end end
car1 = (function(xs1)
	return xs1[1]
end)
cdr1 = (function(xs2)
	return slice1(xs2, 2)
end)
list1 = (function(...)
	local xs3 = _pack(...) xs3.tag = "list"
	return xs3
end)
cons1 = (function(x2, xs4)
	return (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_result[1 + _offset] = x2
		_temp = xs4
		for _c = 1, _temp.n do _result[1 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 1
		return _result
	end)()
end)
_21_1 = (function(expr1)
	if expr1 then
		return false
	else
		return true
	end
end)
list_3f_1 = (function(x3)
	return (type1(x3) == "list")
end)
nil_3f_1 = (function(x4)
	if x4 then
		local r_141 = list_3f_1(x4)
		if r_141 then
			return (_23_1(x4) == 0)
		else
			return r_141
		end
	else
		return x4
	end
end)
symbol_3f_1 = (function(x5)
	return (type1(x5) == "symbol")
end)
key_3f_1 = (function(x6)
	return (type1(x6) == "key")
end)
exists_3f_1 = (function(x7)
	return _21_1((type1(x7) == "nil"))
end)
type1 = (function(val1)
	local ty1 = type_23_1(val1)
	if (ty1 == "table") then
		local tag1 = val1["tag"]
		if tag1 then
			return tag1
		else
			return "table"
		end
	else
		return ty1
	end
end)
car2 = (function(x8)
	local r_341 = type1(x8)
	if (r_341 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "x", "list", r_341), 2)
	else
	end
	return car1(x8)
end)
cdr2 = (function(x9)
	local r_351 = type1(x9)
	if (r_351 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "x", "list", r_351), 2)
	else
	end
	if nil_3f_1(x9) then
		return {tag = "list", n = 0}
	else
		return cdr1(x9)
	end
end)
foldr1 = (function(f1, z1, xs5)
	local r_361 = type1(f1)
	if (r_361 ~= "function") then
		error1(format1("bad argment %s (expected %s, got %s)", "f", "function", r_361), 2)
	else
	end
	local r_491 = type1(xs5)
	if (r_491 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "xs", "list", r_491), 2)
	else
	end
	if nil_3f_1(xs5) then
		return z1
	else
		local head1 = car2(xs5)
		local tail1 = cdr2(xs5)
		return f1(head1, foldr1(f1, z1, tail1))
	end
end)
map1 = (function(f2, xs6, acc1)
	local r_371 = type1(f2)
	if (r_371 ~= "function") then
		error1(format1("bad argment %s (expected %s, got %s)", "f", "function", r_371), 2)
	else
	end
	local r_501 = type1(xs6)
	if (r_501 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "xs", "list", r_501), 2)
	else
	end
	if _21_1(exists_3f_1(acc1)) then
		return map1(f2, xs6, {tag = "list", n = 0})
	elseif nil_3f_1(xs6) then
		return reverse1(acc1)
	else
		return map1(f2, cdr2(xs6), cons1(f2(car2(xs6)), acc1))
	end
end)
any1 = (function(p1, xs7)
	local r_391 = type1(p1)
	if (r_391 ~= "function") then
		error1(format1("bad argment %s (expected %s, got %s)", "p", "function", r_391), 2)
	else
	end
	local r_521 = type1(xs7)
	if (r_521 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "xs", "list", r_521), 2)
	else
	end
	return foldr1((function(x10, y1)
		if x10 then
			return x10
		else
			return y1
		end
	end), false, map1(p1, xs7))
end)
nth1 = (function(xs8, idx1)
	return xs8[idx1]
end)
pushCdr_21_1 = (function(xs9, val2)
	local r_441 = type1(xs9)
	if (r_441 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "xs", "list", r_441), 2)
	else
	end
	local len1 = (_23_1(xs9) + 1)
	xs9["n"] = len1
	xs9[len1] = val2
	return xs9
end)
removeNth_21_1 = (function(li1, idx2)
	local r_461 = type1(li1)
	if (r_461 ~= "list") then
		error1(format1("bad argment %s (expected %s, got %s)", "li", "list", r_461), 2)
	else
	end
	li1["n"] = (li1["n"] - 1)
	return remove1(li1, idx2)
end)
reverse1 = (function(xs10, acc2)
	if _21_1(exists_3f_1(acc2)) then
		return reverse1(xs10, {tag = "list", n = 0})
	elseif nil_3f_1(xs10) then
		return acc2
	else
		return reverse1(cdr2(xs10), cons1(car2(xs10), acc2))
	end
end)
caar1 = (function(x11)
	return car2(car2(x11))
end)
cadr1 = (function(x12)
	return car2(cdr2(x12))
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
			local val3 = keys1[(1 + r_711)]
			out1[(function()
				if key_3f_1(key2) then
					return contents1(key2)
				else
					return key2
				end
			end)()
			] = val3
			return r_701((r_711 + 2))
		else
		end
	end)
	r_701(1)
	return out1
end)
_23_keys1 = (function(st1)
	local cnt1 = 0
	iterPairs1(st1, (function()
		cnt1 = (cnt1 + 1)
		return nil
	end))
	return cnt1
end)
succ1 = (function(x13)
	return (x13 + 1)
end)
pred1 = (function(x14)
	return (x14 - 1)
end)
symbol_2d3e_string1 = (function(x15)
	if symbol_3f_1(x15) then
		return x15["contents"]
	else
		return nil
	end
end)
fail_21_1 = (function(x16)
	return error1(x16, 0)
end)
self1 = (function(x17, key3, ...)
	local args2 = _pack(...) args2.tag = "list"
	return x17[key3](x17, unpack1(args2))
end)
builtins1 = require1("tacky.analysis.resolve")["builtins"]
visitQuote1 = (function(node1, visitor1, level1)
	if (level1 == 0) then
		return visitNode1(node1, visitor1)
	else
		local tag2 = node1["tag"]
		local temp1
		local r_1641 = (tag2 == "string")
		if r_1641 then
			temp1 = r_1641
		else
			local r_1651 = (tag2 == "number")
			if r_1651 then
				temp1 = r_1651
			else
				local r_1661 = (tag2 == "key")
				if r_1661 then
					temp1 = r_1661
				else
					temp1 = (tag2 == "symbol")
				end
			end
		end
		if temp1 then
			return nil
		elseif (tag2 == "list") then
			local first1 = nth1(node1, 1)
			local temp2
			if first1 then
				temp2 = (first1["tag"] == "symbol")
			else
				temp2 = first1
			end
			if temp2 then
				local temp3
				local r_1681 = (first1["contents"] == "unquote")
				if r_1681 then
					temp3 = r_1681
				else
					temp3 = (first1["contents"] == "unquote-splice")
				end
				if temp3 then
					return visitQuote1(nth1(node1, 2), visitor1, pred1(level1))
				elseif (first1["contents"] == "syntax-quote") then
					return visitQuote1(nth1(node1, 2), visitor1, succ1(level1))
				else
					local r_1731 = _23_1(node1)
					local r_1711 = nil
					r_1711 = (function(r_1721)
						if (r_1721 <= r_1731) then
							local sub1 = node1[r_1721]
							visitQuote1(sub1, visitor1, level1)
							return r_1711((r_1721 + 1))
						else
						end
					end)
					return r_1711(1)
				end
			else
				local r_1791 = _23_1(node1)
				local r_1771 = nil
				r_1771 = (function(r_1781)
					if (r_1781 <= r_1791) then
						local sub2 = node1[r_1781]
						visitQuote1(sub2, visitor1, level1)
						return r_1771((r_1781 + 1))
					else
					end
				end)
				return r_1771(1)
			end
		elseif error1 then
			return _2e2e_1("Unknown tag ", tag2)
		else
			_error("unmatched item")
		end
	end
end)
visitNode1 = (function(node2, visitor2)
	if (visitor2(node2, visitor2) == false) then
	else
		local tag3 = node2["tag"]
		local temp4
		local r_1571 = (tag3 == "string")
		if r_1571 then
			temp4 = r_1571
		else
			local r_1581 = (tag3 == "number")
			if r_1581 then
				temp4 = r_1581
			else
				local r_1591 = (tag3 == "key")
				if r_1591 then
					temp4 = r_1591
				else
					temp4 = (tag3 == "symbol")
				end
			end
		end
		if temp4 then
			return nil
		elseif (tag3 == "list") then
			local first2 = nth1(node2, 1)
			if (first2["tag"] == "symbol") then
				local func1 = first2["var"]
				local funct1 = func1["tag"]
				if (func1 == builtins1["lambda"]) then
					return visitBlock1(node2, 3, visitor2)
				elseif (func1 == builtins1["cond"]) then
					local r_1831 = _23_1(node2)
					local r_1811 = nil
					r_1811 = (function(r_1821)
						if (r_1821 <= r_1831) then
							local case1 = nth1(node2, r_1821)
							visitNode1(nth1(case1, 1), visitor2)
							visitBlock1(case1, 2, visitor2)
							return r_1811((r_1821 + 1))
						else
						end
					end)
					return r_1811(2)
				elseif (func1 == builtins1["set!"]) then
					return visitNode1(nth1(node2, 3), visitor2)
				elseif (func1 == builtins1["quote"]) then
				elseif (func1 == builtins1["syntax-quote"]) then
					return visitQuote1(nth1(node2, 2), visitor2, 1)
				else
					local temp5
					local r_1851 = (func1 == builtins1["unquote"])
					if r_1851 then
						temp5 = r_1851
					else
						temp5 = (func1 == builtins1["unquote-splice"])
					end
					if temp5 then
						return fail_21_1("unquote/unquote-splice should never appear head")
					else
						local temp6
						local r_1861 = (func1 == builtins1["define"])
						if r_1861 then
							temp6 = r_1861
						else
							temp6 = (func1 == builtins1["define-macro"])
						end
						if temp6 then
							return visitNode1(nth1(node2, _23_1(node2)), visitor2)
						elseif (func1 == builtins1["define-native"]) then
						elseif (func1 == builtins1["import"]) then
						else
							local temp7
							local r_1871 = (funct1 == "defined")
							if r_1871 then
								temp7 = r_1871
							else
								local r_1881 = (funct1 == "arg")
								if r_1881 then
									temp7 = r_1881
								else
									local r_1891 = (funct1 == "native")
									if r_1891 then
										temp7 = r_1891
									else
										temp7 = (funct1 == "macro")
									end
								end
							end
							if temp7 then
								return visitBlock1(node2, 1, visitor2)
							else
								return fail_21_1(_2e2e_1("Unknown kind ", funct1, " for variable ", func1["name"]))
							end
						end
					end
				end
			else
				return visitBlock1(node2, 1, visitor2)
			end
		else
			return error1(_2e2e_1("Unknown tag ", tag3))
		end
	end
end)
visitBlock1 = (function(node3, start1, visitor3)
	local r_1621 = _23_1(node3)
	local r_1601 = nil
	r_1601 = (function(r_1611)
		if (r_1611 <= r_1621) then
			visitNode1(nth1(node3, r_1611), visitor3)
			return r_1601((r_1611 + 1))
		else
		end
	end)
	return r_1601(start1)
end)
builtins2 = require1("tacky.analysis.resolve")["builtins"]
builtinVars1 = require1("tacky.analysis.resolve")["declaredVars"]
createState1 = (function()
	return struct1("vars", {}, "nodes", {})
end)
getVar1 = (function(state1, var1)
	local entry1 = state1["vars"][var1]
	if entry1 then
	else
		entry1 = struct1("var", var1, "usages", struct1(), "defs", struct1(), "active", false)
		state1["vars"][var1] = entry1
	end
	return entry1
end)
getNode1 = (function(state2, node4)
	local entry2 = state2["nodes"][node4]
	if entry2 then
	else
		entry2 = struct1("uses", {tag = "list", n = 0})
		state2["nodes"][node4] = entry2
	end
	return entry2
end)
addUsage_21_1 = (function(state3, var2, node5)
	local varMeta1 = getVar1(state3, var2)
	local nodeMeta1 = getNode1(state3, node5)
	varMeta1["usages"][node5] = true
	varMeta1["active"] = true
	nodeMeta1["uses"][var2] = true
	return nil
end)
addDefinition_21_1 = (function(state4, var3, node6, kind1, value1)
	local varMeta2 = getVar1(state4, var3)
	varMeta2["defs"][node6] = struct1("tag", kind1, "value", value1)
	return nil
end)
definitionsVisitor1 = (function(state5, node7, visitor4)
	local temp8
	local r_1461 = list_3f_1(node7)
	if r_1461 then
		temp8 = symbol_3f_1(car2(node7))
	else
		temp8 = r_1461
	end
	if temp8 then
		local func2 = car2(node7)["var"]
		if (func2 == builtins2["lambda"]) then
			local r_1481 = nth1(node7, 2)
			local r_1511 = _23_1(r_1481)
			local r_1491 = nil
			r_1491 = (function(r_1501)
				if (r_1501 <= r_1511) then
					local arg1 = r_1481[r_1501]
					addDefinition_21_1(state5, arg1["var"], arg1, "arg", arg1)
					return r_1491((r_1501 + 1))
				else
				end
			end)
			return r_1491(1)
		elseif (func2 == builtins2["set!"]) then
			return addDefinition_21_1(state5, node7[2]["var"], node7, "set", nth1(node7, 3))
		else
			local temp9
			local r_1531 = (func2 == builtins2["define"])
			if r_1531 then
				temp9 = r_1531
			else
				temp9 = (func2 == builtins2["define-macro"])
			end
			if temp9 then
				return addDefinition_21_1(state5, node7["defVar"], node7, "define", nth1(node7, _23_1(node7)))
			elseif (func2 == builtins2["define-native"]) then
				return addDefinition_21_1(state5, node7["defVar"], node7, "native")
			else
			end
		end
	else
		local temp10
		local r_1541 = list_3f_1(node7)
		if r_1541 then
			local r_1551 = list_3f_1(car2(node7))
			if r_1551 then
				local r_1561 = symbol_3f_1(caar1(node7))
				if r_1561 then
					temp10 = (caar1(node7)["var"] == builtins2["lambda"])
				else
					temp10 = r_1561
				end
			else
				temp10 = r_1551
			end
		else
			temp10 = r_1541
		end
		if temp10 then
			local lam1 = car2(node7)
			local args3 = nth1(lam1, 2)
			local offset1 = 1
			local r_1921 = _23_1(args3)
			local r_1901 = nil
			r_1901 = (function(r_1911)
				if (r_1911 <= r_1921) then
					local arg2 = nth1(args3, r_1911)
					local val4 = nth1(node7, (r_1911 + offset1))
					if arg2["var"]["isVariadic"] then
						local count1 = (_23_1(node7) - _23_1(args3))
						if (count1 < 0) then
							count1 = 0
						else
						end
						offset1 = count1
						addDefinition_21_1(state5, arg2["var"], arg2, "arg", arg2)
					else
						addDefinition_21_1(state5, arg2["var"], arg2, "let", (function()
							if val4 then
								return val4
							else
								return struct1("tag", "symbol", "contents", "nil", "var", builtinVars1["nil"])
							end
						end)())
					end
					return r_1901((r_1911 + 1))
				else
				end
			end)
			r_1901(1)
			visitBlock1(node7, 2, visitor4)
			visitBlock1(lam1, 3, visitor4)
			return false
		else
		end
	end
end)
definitionsVisit1 = (function(state6, nodes1)
	return visitBlock1(nodes1, 1, (function(r_2021, r_2031)
		return definitionsVisitor1(state6, r_2021, r_2031)
	end))
end)
usagesVisit1 = (function(state7, nodes2, pred2)
	if pred2 then
	else
		pred2 = (function()
			return true
		end)
	end
	local queue1 = {tag = "list", n = 0}
	local visited1 = {}
	local addUsage1 = (function(var4, user1)
		addUsage_21_1(state7, var4, user1)
		local varMeta3 = getVar1(state7, var4)
		if varMeta3["active"] then
			return iterPairs1(varMeta3["defs"], (function(_5f_1, def1)
				local val5 = def1["value"]
				local temp11
				if val5 then
					temp11 = _21_1(visited1[val5])
				else
					temp11 = val5
				end
				if temp11 then
					return pushCdr_21_1(queue1, val5)
				else
				end
			end))
		else
		end
	end)
	local visit1 = (function(node8)
		if visited1[node8] then
			return false
		else
			visited1[node8] = true
			if symbol_3f_1(node8) then
				addUsage1(node8["var"], node8)
				return true
			else
				local temp12
				local r_2041 = list_3f_1(node8)
				if r_2041 then
					local r_2051 = (_23_1(node8) > 0)
					if r_2051 then
						temp12 = symbol_3f_1(car2(node8))
					else
						temp12 = r_2051
					end
				else
					temp12 = r_2041
				end
				if temp12 then
					local func3 = car2(node8)["var"]
					local temp13
					local r_2061 = (func3 == builtins2["set!"])
					if r_2061 then
						temp13 = r_2061
					else
						local r_2071 = (func3 == builtins2["define"])
						if r_2071 then
							temp13 = r_2071
						else
							temp13 = (func3 == builtins2["define-macro"])
						end
					end
					if temp13 then
						if pred2(nth1(node8, 3)) then
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
		end
	end)
	local r_1991 = _23_1(nodes2)
	local r_1971 = nil
	r_1971 = (function(r_1981)
		if (r_1981 <= r_1991) then
			local node9 = nodes2[r_1981]
			pushCdr_21_1(queue1, node9)
			return r_1971((r_1981 + 1))
		else
		end
	end)
	r_1971(1)
	local r_2011 = nil
	r_2011 = (function()
		if (_23_1(queue1) > 0) then
			visitNode1(removeNth_21_1(queue1, 1), visit1)
			return r_2011()
		else
		end
	end)
	return r_2011()
end)
putError_21_1 = (function(logger1, msg1)
	return self1(logger1, "put-error!", msg1)
end)
putWarning_21_1 = (function(logger2, msg2)
	return self1(logger2, "put-warning!", msg2)
end)
putVerbose_21_1 = (function(logger3, msg3)
	return self1(logger3, "put-verbose!", msg3)
end)
putDebug_21_1 = (function(logger4, msg4)
	return self1(logger4, "put-debug!", msg4)
end)
putNodeError_21_1 = (function(logger5, msg5, node10, explain1, ...)
	local lines1 = _pack(...) lines1.tag = "list"
	return self1(logger5, "put-node-error!", msg5, node10, explain1, lines1)
end)
putNodeWarning_21_1 = (function(logger6, msg6, node11, explain2, ...)
	local lines2 = _pack(...) lines2.tag = "list"
	return self1(logger6, "put-node-warning!", msg6, node11, explain2, lines2)
end)
doNodeError_21_1 = (function(logger7, msg7, node12, explain3, ...)
	local lines3 = _pack(...) lines3.tag = "list"
	self1(logger7, "put-node-error!", msg7, node12, explain3, lines3)
	return fail_21_1((function(r_2091)
		if r_2091 then
			return r_2091
		else
			return msg7
		end
	end)(match1(msg7, "^([^\n]+)\n")))
end)
struct1("putError", putError_21_1, "putWarning", putWarning_21_1, "putVerbose", putVerbose_21_1, "putDebug", putDebug_21_1, "putNodeError", putNodeError_21_1, "putNodeWarning", putNodeWarning_21_1, "doNodeError", doNodeError_21_1)
formatPosition1 = (function(pos1)
	return _2e2e_1(pos1["line"], ":", pos1["column"])
end)
formatRange1 = (function(range1)
	if range1["finish"] then
		return format1("%s:[%s .. %s]", range1["name"], formatPosition1(range1["start"]), formatPosition1(range1["finish"]))
	else
		return format1("%s:[%s]", range1["name"], formatPosition1(range1["start"]))
	end
end)
formatNode1 = (function(node13)
	local temp14
	local r_2101 = node13["range"]
	if r_2101 then
		temp14 = node13["contents"]
	else
		temp14 = r_2101
	end
	if temp14 then
		return format1("%s (%q)", formatRange1(node13["range"]), node13["contents"])
	elseif node13["range"] then
		return formatRange1(node13["range"])
	elseif node13["macro"] then
		local macro1 = node13["macro"]
		return format1("macro expansion of %s (%s)", macro1["var"]["name"], formatNode1(macro1["node"]))
	else
		local temp15
		local r_2131 = node13["start"]
		if r_2131 then
			temp15 = node13["finish"]
		else
			temp15 = r_2131
		end
		if temp15 then
			return formatRange1(node13)
		else
			return "?"
		end
	end
end)
getSource1 = (function(node14)
	local result1 = nil
	local r_2111 = nil
	r_2111 = (function()
		local temp16
		local r_2121 = node14
		if r_2121 then
			temp16 = _21_1(result1)
		else
			temp16 = r_2121
		end
		if temp16 then
			result1 = node14["range"]
			node14 = node14["parent"]
			return r_2111()
		else
		end
	end)
	r_2111()
	return result1
end)
struct1("formatPosition", formatPosition1, "formatRange", formatRange1, "formatNode", formatNode1, "getSource", getSource1)
builtins3 = require1("tacky.analysis.resolve")["builtins"]
sideEffect_3f_1 = (function(node15)
	local tag4 = type1(node15)
	local temp17
	local r_1421 = (tag4 == "number")
	if r_1421 then
		temp17 = r_1421
	else
		local r_1431 = (tag4 == "string")
		if r_1431 then
			temp17 = r_1431
		else
			local r_1441 = (tag4 == "key")
			if r_1441 then
				temp17 = r_1441
			else
				temp17 = (tag4 == "symbol")
			end
		end
	end
	if temp17 then
		return false
	elseif (tag4 == "list") then
		local fst1 = car2(node15)
		if (type1(fst1) == "symbol") then
			local var5 = fst1["var"]
			local r_1451 = (var5 ~= builtins3["lambda"])
			if r_1451 then
				return (var5 ~= builtins3["quote"])
			else
				return r_1451
			end
		else
			return true
		end
	else
		_error("unmatched item")
	end
end)
warnArity1 = (function(lookup1, nodes3, state8)
	local arity1
	local getArity1
	arity1 = {}
	getArity1 = (function(symbol1)
		local var6 = getVar1(lookup1, symbol1["var"])
		local ari1 = arity1[var6]
		if (ari1 ~= nil) then
			return ari1
		elseif (_23_keys1(var6["defs"]) ~= 1) then
			return false
		else
			arity1[var6] = false
			local defData1 = cadr1(list1(next1(var6["defs"])))
			local def2 = defData1["value"]
			if (defData1["tag"] == "arg") then
				ari1 = false
			else
				if symbol_3f_1(def2) then
					ari1 = getArity1(def2)
				else
					local temp18
					local r_2141 = list_3f_1(def2)
					if r_2141 then
						local r_2151 = symbol_3f_1(car2(def2))
						if r_2151 then
							temp18 = (car2(def2)["var"] == builtins3["lambda"])
						else
							temp18 = r_2151
						end
					else
						temp18 = r_2141
					end
					if temp18 then
						local args4 = nth1(def2, 2)
						if any1((function(x18)
							return x18["var"]["isVariadic"]
						end), args4) then
							ari1 = false
						else
							ari1 = _23_1(args4)
						end
					else
						ari1 = false
					end
				end
			end
			arity1[var6] = ari1
			return ari1
		end
	end)
	return visitBlock1(nodes3, 1, (function(node16)
		local temp19
		local r_2161 = list_3f_1(node16)
		if r_2161 then
			temp19 = symbol_3f_1(car2(node16))
		else
			temp19 = r_2161
		end
		if temp19 then
			local arity2 = getArity1(car2(node16))
			local temp20
			if arity2 then
				temp20 = (arity2 < pred1(_23_1(node16)))
			else
				temp20 = arity2
			end
			if temp20 then
				return putNodeWarning_21_1(state8["logger"], _2e2e_1("Calling ", symbol_2d3e_string1(car2(node16)), " with ", tonumber1(pred1(_23_1(node16))), " arguments, expected ", tonumber1(arity2)), node16, nil, getSource1(node16), "Called here")
			else
			end
		else
		end
	end))
end)
analyse1 = (function(nodes4, state9)
	local lookup2 = createState1()
	definitionsVisit1(lookup2, nodes4)
	usagesVisit1(lookup2, nodes4, sideEffect_3f_1)
	warnArity1(lookup2, nodes4, state9)
	return nodes4
end)
return struct1("analyse", analyse1)