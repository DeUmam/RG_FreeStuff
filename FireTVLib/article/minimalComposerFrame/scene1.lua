local composer 		= require( "composer" )
local scene    		= composer.newScene()

require "RGEasyFTV"
local button 		= require "button" -- A super-minimal button builder


---------------------------------------------------------------------------------
-- Custom code for this scene
---------------------------------------------------------------------------------

local function openScene2( )
	local options =	{ effect = "fade", time = 200, }
	composer.gotoScene( "scene2", options  )	
end

local function openScene3( )
	local options =	{ effect = "fade", time = 200, }
	composer.gotoScene( "scene3", options  )	
end


local ignoreFTVInputs = true

local function onFTVKey( event )
	if(ignoreFTVInputs) then return false end

	local keyName = event.keyName
	local phase = event.phase
	if( phase ~= "ended" ) then return false end

	if( keyName == "up" ) then
		openScene2()
		return true

	elseif( keyName == "down" ) then
		openScene3()
		return true
	
	else
		print( "Detected key: ", keyName, " not currently mapped in this interface.")
	end

	return false
end
Runtime:addEventListener( "onFTVKey", onFTVKey )


---------------------------------------------------------------------------------
-- Composer Code
---------------------------------------------------------------------------------
function scene:create( event )
	local screenGroup = self.view


	local label = display.newText( screenGroup, "Scene 1" , 240, 40, system.nativeFont, 34)


	-- Add buttons to take us to the next scene
	button.new( screenGroup, 240, 130, 180, 40, "Scene 2 (up)", openScene2)
	button.new( screenGroup, 240, 190, 180, 40, "Scene 3 (down)", openScene3)

end

function scene:show( event )
	local screenGroup = self.view
	local willDid 	= event.phase

	if( willDid == "did" ) then
		ignoreFTVInputs = false
	end

end

function scene:hide( event )
	local screenGroup = self.view
	local willDid 	= event.phase
	
	if( willDid == "will" ) then
		ignoreFTVInputs = true
	end
end

function scene:destroy( event )
	local screenGroup = self.view
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
