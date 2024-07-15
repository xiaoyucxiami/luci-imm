-- Copyright (C) 2021-2022  sirpdboy  <herboy2008@gmail.com> https://github.com/sirpdboy/luci-app-ddns-go
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.ddns-go", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ddns-go") then
		return
	end

	entry({"admin",  "network", "ddns-go"}, alias("admin", "network", "ddns-go", "setting"),_("DDNS-GO"), 58).dependent = true
	entry({"admin", "network", "ddns-go", "setting"}, cbi("ddns-go"), _("Base Setting"), 20).leaf=true
	entry({"admin",  "network", "ddns-go", "ddns-go"}, template("ddns-go"), _("DDNS-GO"), 30).leaf = true
	entry({"admin", "network", "ddnsgo_status"}, call("act_status"))
end

function act_status()
	local sys  = require "luci.sys"
	local e = { }
	e.running = sys.call("pidof ddns-go >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
