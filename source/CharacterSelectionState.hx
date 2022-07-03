package;

import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.effects.chainable.FlxGlitchEffect;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flash.system.System;
import flixel.FlxGame;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxGlitchEffect;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.addons.effects.chainable.FlxRainbowEffect;
import flixel.addons.effects.chainable.FlxShakeEffect;
import flixel.addons.effects.chainable.FlxTrailEffect;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.chainable.IFlxEffect;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxState;
import openfl.filters.BitmapFilter;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import flixel.FlxObject;
import openfl.Lib;
import openfl.system.Capabilities;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.util.FlxSave;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import Achievements;
import Shaders.PulseEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import openfl.filters.ShaderFilter;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;

class CharacterSelectionState extends MusicBeatState //This is not from the D&B source code, it's completely made by me (Delta). This also means I can use this code for other mods.
{
    var characters:Array<String> = ['Boyfriend', 'Opposition Bambi'];
    var charactersFile:Array<String> = ['bf', 'oppobf'];
    var charactersImage:Array<String> = ['BOYFRIEND', 'BF_Oppo'];

	var nightColor:FlxColor = 0xFF878787;
    var curSelected:Int = 0;
    var curText:FlxText;
    var characterText:FlxText;
    var formText:FlxText;
    var entering:Bool = false;

    var characterThere:FlxSprite = new FlxSprite(0, 0);

    override function create() 
    {
        FlxG.mouse.visible = true;
        FlxG.mouse.enabled = true;
        FlxG.sound.music.stop();
        FlxG.sound.playMusic(Paths.music('breakfast'), 1);
       var theBGNight:BGSprite = new BGSprite('sky_night', -680, -90, 0, 0);
       add(theBGNight);
       var hillsNight:BGSprite = new BGSprite('orangey hills', -380, 120, 0.3, 0.3);
       add(hillsNight);
       hillsNight.color = nightColor;
       var farmNight:BGSprite = new BGSprite('funfarmhouse', 80, 160, 0.6, 0.6);
       add(farmNight);
       farmNight.color = nightColor;
       var groundNight:BGSprite = new BGSprite('grass lands', -480, 560, 1, 1);
       add(groundNight);
       groundNight.color = nightColor;
       var corn1night:BGSprite = new BGSprite('Cornys', -360, 285, 1, 1);
       add(corn1night);
       corn1night.color = nightColor;
       var corn2night:BGSprite = new BGSprite('Cornys', 1060, 285, 1, 1);
       add(corn2night);
       corn2night.color = nightColor;
       var fenceNight:BGSprite = new BGSprite('crazy fences', -310, 450, 1, 1);
       add(fenceNight);
       fenceNight.color = nightColor;
       var signNight:BGSprite = new BGSprite('Sign', 10, 455, 1, 1);
       add(signNight);
       signNight.color = nightColor;
       signNight.y -= 50;
       fenceNight.y -= 50;
       corn2night.y -= 50;
       corn1night.y -= 50;
       groundNight.y -= 50;
       farmNight.y -= 50;
       hillsNight.y -= 50;
       theBGNight.y -= 50;

       curText = new FlxText(0, 20, 0, characters[curSelected], 20);
       curText.setFormat(Paths.font("comicsanslol.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
       curText.size = 50;
       
       characterText = new FlxText(10, 0, 0, 'Character', 20);
       characterText.setFormat(Paths.font("comicsanslol.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
       characterText.size = 50;

        var acceptButton:FlxButton = new FlxButton(0, 100, 'Play', function() 
        {
            trace('alright now FUCKING PLAY');
            acceptCharacter();
        });

        var rightButton:FlxButton = new FlxButton(characterText.x + 50, characterText.y + 50, '>', function() 
        {
            trace('right');
            changeCharacter(1);
        });

        var leftButton:FlxButton = new FlxButton(characterText.x - 25, characterText.y + 50, '<', function() 
        {
            trace('left');
            changeCharacter(-1);
        });
        add(leftButton);
        add(rightButton);
        add(acceptButton);
        add(curText);
        add(formText);
        add(characterText);

        acceptButton.screenCenter(X);
        curText.screenCenter(X);
        characterThere.frames = Paths.getSparrowAtlas('characters/' + charactersImage[curSelected]);
        characterThere.animation.addByPrefix('BF idle dance', 'BF idle dance', 24, false, false, false);
        characterThere.animation.play('BF idle dance');
        add(characterThere);
        characterThere.screenCenter(XY);
        super.create();
    }

    override function update(elapsed)
    {

        super.update(elapsed);
    }

    function changeCharacter(change:Int) 
    {
        curSelected += change;

        if (curSelected < 0)
        {
			curSelected = characters.length - 1;
        }
		if (curSelected >= characters.length)
        {
			curSelected = 0;
        }
        curText.text = characters[curSelected];
        switch(characters[curSelected])
        {
        case 'Boyfriend':
            characterThere.animation.addByPrefix('BF idle dance', 'BF idle dance', 24, false, false, false);
            characterThere.animation.play('BF idle dance');
        case 'Opposition Bambi':
            characterThere.animation.addByPrefix('BF idle dance', 'BF idle dance', 24, false, false, false); 
            characterThere.animation.play('BF idle dance');
        }
        characterThere.frames = Paths.getSparrowAtlas('characters/' + charactersImage[curSelected]);
        curText.screenCenter(X);
        characterThere.screenCenter(XY);
    }

    function acceptCharacter() 
    {
        if(!entering)
        {
        entering = true;
        FlxG.sound.playMusic(Paths.music('gameOverEnd'), 1);
        new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
                FlxG.sound.music.stop();
                PlayState.SONG.player1 = charactersFile[curSelected];
                MusicBeatState.switchState(new PlayState());
			});
        }
    }
}