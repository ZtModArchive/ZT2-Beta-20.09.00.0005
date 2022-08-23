
-- testxmlcreation.lua

function testxmlcreation(st)
    factory = getXMLFactory();
	foo = factory:createXMLElement("thesolution")
	attr = factory:createXMLAttribute("magicnumber")
	attr:setInt(42)
	foo:addAttribute(attr.this)
	xmlroot = factory:createXMLElement("root")
	goo = factory:createXMLText("sometext goes here")
	xmlroot:addChild(foo.this)
	xmlroot:addChild(goo.this)
	st.returnedXML = xmlroot.this
end
