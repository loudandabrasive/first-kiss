local mapString = [[
X#######################X
X        f              X
X                f      X
X    #    #   f    ff   X
X          XX#          X
X          ##   f       X
X                  f#   X
X          #            X
X                       X
X    f     X            X
X    f     #            X
X                       X
X          #            X
X                       X
X    f          #     X X
X      #   f        X # X
X       f        f  X   X
X           f    f  #   X
#########################
]]

local mapConfig = {	
	{' ',  0,  0 }, -- 1 = grass 
	{'#', 32,  0 }, -- 2 = box
	{'f',  0, 32 }, -- 3 = flowers
	{'X', 32, 32 }  -- 4 = boxTop
}

newMap(32, 'assets/countryside.png', mapString, mapConfig)