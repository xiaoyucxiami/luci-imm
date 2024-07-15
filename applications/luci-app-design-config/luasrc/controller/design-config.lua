module("luci.controller.design-config", package.seeall)

function index()
	if not nixio.fs.access('/www/luci-static/design/css/style.css') then
		return
	end

	local page = entry({"admin", "system", "design-config"}, form("design-config"), _("Design Config"), 115)
	page.acl_depends = { "luci-app-design-config" }
end
