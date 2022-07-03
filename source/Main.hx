package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var zoom:Float = 1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end

		Paths.getModFolders();
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end
	}
}

//THE FUCK HOW'D HE GET IN HERE

/*
                                                                                                                                                          
                                                                                                                                                     
                                                                                                                                                     
                                                                                                                                                     
                                                ....                         .° .                                                                    
                                              ......                       .°*° °°                                                                   
                                             ........                   .°°°°°° .O.                                                                  
                                            ........        ..       .°°°°°°°°. .Oo                                                                  
                                           .........  °..   .*°. ..°°°°°°°°°°°. °oo*                                                                 
                                          ..........  °°°°°°°°°°°°°°°°°°°°°°°°  oooo.                                                                
                                         .............°°°°°°°°°°°°°°°°°°°°°°°. .°*oO*   *o                                                           
                                         .........°°°°°°°°°°°°°°°°°°°°°°°°°°°    °O°.    O@.                                                         
                                         .......°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°  .  °ooo° #°  *oooo°                                                 
                                        ..   .°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°.  *OOoooo   .Oooooo. *                                               
                                      .....    .°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°   *Ooooooo   oooooo° oOo                                              
                                       .....°°.   ..°°°°°°°°°°°°°°°°°..  °°°°    °Ooooooo   oooooo °ooo                                              
                                       ....°°°°*.      °°°°°°...      ..°°°°   O* oooooooo.°oooooo.ooo°                                              
                                         .°°°°°°.      .°°           .*°°°°.  .@o *oooooooOooooooooooo                                               
                                     ..°°°°°°°°°.       °°°°         .°°°°°.  *# .ooooooooooooooooooo°                                               
                                    *°°°°°°°°°°°°      .***°°        .°°°°°.  °* oooooooooooooooooooo°                                               
                                    .°°°°°*oooooo*     °°*oo*°       °°°°°°°  .  oooooooooooooooooooo*                                               
                                     .°°°°ooooooooo°  °***oooo*.   .*o*****°.    ooooooooooooooooooooo                                               
                                       °°°*ooooooooOo°*ooooooooooooOo*ooooo*°°.  .oooooooooooooooooooo.                                              
                                        .°*ooooooooooOooooooooOOOo*°  *oooo°°°**. .ooooooooooooooooooO°                                              
                                        °*oooooooooooooooooo**°.   .*oooOOo*°..    .oooo***oooooo***oo*                                              
                                       .°°*oOooOOooo*.....    ..°ooOOoo*°.     ..°° .oo*°°°°*ooo*°°°°**                                              
                                           ..  .°*ooOOooooooOOOOOo*°.    .**oOOOOOO° °*°°°°°°°°°°°°°°°°                                              
                                                 .  ..°°°°°°...     .°*ooooOo*°°..°.  °°°°°°°°°°°°°°°°°.                                             
                                               *OOo**°°°°°  °°***oooooooooo°    °ooo  .°°°°°°°°°°°°°°°°.                                             
                                               ..*ooooOOOO° *Ooooooooooooo. .°°°#@@@o  .°°°°°°°°°°°°°°°°                                             
                                                  Oooooooo*.*oooooooooooOo .*°°°*O@@@  ..°°°°°°°°°°°°°°°                                             
                                              ..  .oOooooOOOooooooooooOo**  °°°°°°*oO*  .°°°°°°°°°°°°°°°                                             
                                             ...    .oOOo°.*oOoooooOOo°      °°°°°°°°°  ...°°°°°°°°°°°°°                                             
                                           .....  °°  °°     °oOoo*°.  °oo**  °°°°°°°°°  ...°°°°°°°°°°°.                                             
                                          .°....  °oo*°.°oOo°  .   .°ooOooooo.  °°°°°°°  .....°°°°°°°°*                                              
                                         .°°....  *oooOOOoooOo***ooOoooooooooO*   .°°°°°  .......°°°°°°                                              
                                        .°°°....  *ooooooooooooooooooooooooooo*°.    .°°°  .........°°                                               
                                       .°°°°....  *oooooooooooooooooooooooooo°°°°°.          .......                                                 
                                      .°°°°°°... .ooooooooooooooooooooooooooo°°°°°°                                                                  
                                     .°°°°°°°..  *ooooooooooooooooooooooooooo°°°°°°                                                                  
                                    .°°°°°°°°°  °oooooooooooooooooooooooooooo*°°°°°°                                                                 
                                   °°°°°°°°°°. .*oooooooooooooooooooooooooooo*°°°°°°                                                                 
                                  °°°°°°°°°°°  *ooooooooooooooooooooooooooooo°°°°°°°.                                                                
                                 °°°°°°°°°°°  °*ooooooooooooooooooooooooooooo°°°°°°°°                                                                
                               .°°°°°°°°°°°  °°*oooooooooooooooooooooooooooo*°°°°°°°°                                                                
                              °°°°°°°°°°°°  .°°ooooooooooooooooooooooooooooo*°°°°°°°°                                                                
                             o*°°°°°°°°°°  .°°*ooooooooooooooooooooooooooooo°°°°°°°°°                                                                
                           .oo*°°**o*°°°  °°°°*oooooooooooooooooooooooooooo*°°°°°°°°°°                                                               
                          °oooo*ooooo°°  .°°°°°ooooooooooooooooooooooooooo*°°°°°°°°°°°                                                               
                         ooooooooooo**°  °°°°°°*ooooooooooooooooooooooooo*°°°°°°°°°°°°.                                                              
                       .Oooooooooooooo  ...°°°°°oooooooooooooooooooooooo*°°°°°°°°°°°°°°                                                              
                       oooooooooooooO°  ......°°°ooooooooooOoooooooooo*°°°°°°°°°°°°°°°°                                                              
                      oooooooOoo***oo. ...........°*ooo*...°oooooooo*°°°°°°°°°°°°°°°°°°.                                                             
        .*******     ooooooOo°. ..°..  ..............°°°*°°  oooo*°°°°°°°°°°°°°°°°o##O*°                                                             
       ..      * *** .OOoOOo°  °*oooo*  ...................°° .*°°°°°°°°°°°°°°°°°*#@@@@@o                                                             
        . °  .        °°°. .*oo****o°  .....................  °°°°°°°°°°°°°°°°°*#@@@@@@@°                                                            
         *°.        °  ..°oOoo*****o°  .....................  .°°°°°°°°°°°°°°°°*@@@@@@@@o  °°...                                                     
          °°   .     . Oooooooooo**o.  ......................  °°°°°°°°°°°°°°°°*@@@@@@@@O   °°°°°..                                                  
                       °oooOOOoooooo°  ......................  °°°°°°°°°°°°°°°°°*#@@@@@#*.  °°°°                                                     
                         ..°°°**ooOO.  ......................  °°°°°°°°°°°°°°°°°°°oOOOo°°°  .°°°°°°°°..                                              
                                  .*   ......................  .°°°°°°°°°°°°°°°°°°°°°*oo*°.  °°°°°°°°°°°°°..                                         
                                       ......................  .°°°°°°°°°°°°°°°°°°°°O@@@@o°  .°°°°°°°°°°°°°°°°°.                                     
                                       ......................   °°°°°°°°°°°°°°°°°°°°O@@@@O°.  °°°°°°°°°°°°°°°°°°°°.                                  
                                       .......................  °°°°°°°°°°°°°°°°°°°°°O@@#*°.  °°°°°°°°°°°°°°°°°°°°°°.                                
                                       .......................  °°°°°°°°°°°°°°°°°°°°°°**°°°°  .°°°°°°°°°°°°°°°°°°°°°°°°                              
                                       .......................  .°°°°°°°°°°°°°°°°°°°°°°°O#*°°  *°°°°°°°°°°°°°°°°°°°°°°°°°.                           
                                       ........................  °°°°°°°°°°°°°°°°°°°°°°°*o*°°. .o*°°°°°°°°°°°°°°°°°°°°°°°°°                          
                                       ........................  ..........°°°°°°°°°°°°°°°°°°°  °Oo**°°°°°°°°°°°°°°°°°°°°°°°°                        
                                        .......................  .........°°°°°°°°°°°°°°°°°°°°°  °oooo**°°°°°°°°°°°°°°°°°°°°°°.                      
                                        .......................   .....°°°°°°°°°°°°°°°°°°°°°°°°°  *ooo**°°°°°°°°°°°°°°°°°°°°°°°.                     
                                        ........................  °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°.  oo*°°°°°°°°°°°°°°°°°°°.°*.                        
                                        ........................  °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°.  oooo**°°°°°°°°°°°°°°.   .  .                     
                                        ........................   °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°.  oooooo*°°°°°°°°°°°°°°.   ...                    
                                        .........................  °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°  .Ooooooo**°°°°°°°°°°°°°°°°°...                  
                                        °...................°°...  .°°°°°°°°°°°°°°°°°°°°°°°**°°°°°°°  °Ooooooooo*°°°°°°°°°°°°°°°°°...                
                                        °°.................°***°..  °°°°°°°°°°°°°°°°°°°°°°*oooo*°°°°°  ooooooooooo*°°°°°°°°°°°°°°°°°°°.              
                                        °*°..............°******°.  °**°°°°°°°°°°°°°°°°°°oooooooo°°°°. .oooooooooooo*°°°°°°°°°°°°°°°°°°°°°.          
                                        .**°......°°.....°******°*°  oooo*°°°°°*oo*°°°°°*ooooooooo*°°*  °ooooooooooooo*°°°°°°°°°°°°°°°°°.            
                                        .***°...°°**°...°**********  °ooooo**°°ooooo*°°*oooooooooooooO*  ooooooooooooooo*°°°°°°°°°°°°.               
                                        .****°°°***°*°.°*********°*°  ooooooo**oooooo**oooooooooooooooO° .ooooooooooooooo°..°°°°.                    
                                        .************°°***********°*  *ooooooooooooooooooooooooooooooooo  *ooooooooooooooo°.....                     
                                        .*************************°*°  ooooooooooooooooooooooooooooooooo*  oOOoooooooooooooo*°.....                  
                                         **************************°*  *ooooooooooooooooooooooooooooooooO.   °*ooOOooooooooooo*.                     
                                         °***************************° .ooooooooooooooooooooooooooooooooo*       .°*oOo                              
                                        .***************************°*  oooooooooooooooooooooooooooooooooo            .                              
                                        ** .*°************************° °ooooooooooooooooooooooooooooooooo                                           
                                       **°  *°°°°°**  *°*°°°°°°°°°°*°*. *oooo°*ooooooooooooooooooooooooooo                                           
                                        °*. °*******. °**************° .oooo° *ooooooo° oooooooooooooooooo                                           
                                          .  ......°°  °°°°°°°°°°°°°°. °OooO° oOoOOOoO° *OoOOOOOOOOOOOOoo°                                           
                                                                         ..°°  *°°°°°°°  °*°°°°°°°°°...                                              
                                                                                                                                                     
                                                                                                                                                                                                   
                                                                    
*/