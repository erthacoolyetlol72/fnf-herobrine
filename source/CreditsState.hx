package;

//if you want to add the vpad to a state
#if mobile
addVirtualPad(LEFT_FULL, A_B);
#end

//if you want it to have a camera
#if mobile
addVirtualPadCamera(); // add false into () if isn't the default draw camera...
#end

//if you want to remove it at some moment use
#if mobile
removeVirtualPad();
#end

//if you want to add the hitbox to a state
#if mobile
addHitbox();
#end

//if you want it to have a camera
#if mobile
addHitboxCamera(); // add false into () if isn't the default draw camera...
#end

//if you want to remove it at some moment use
#if mobile
removeHitbox();
#end
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['Untitled Funkers'],
		['SmokeCannon',			'smoke',			'Musician',											'https://youtu.be/dQw4w9WgXcQ',			0xFFFFFFFF],
		['Slimemoreno17',		'slime',			'Musician',											'',										0xFFFF0094],
		['Z11Gaming',			'z',				'Musician',											'',										0xFFFF0094],
		['indigo',				'uan',				'Programmer',										'https://twitter.com/indigoUan',        0xFF4B0082],
		['Dylan',				'dylan',			'Artist',											'https://twitter.com/Select3222',		0xFFFF0094],
		['Select',				'select',			'Artist',											'https://twitter.com/Select3222',		0xFFFF0094],
		['TiagoFuzionPoco',		'tiago',			'Artist',											'https://twitter.com/Select3222',		0xFFFF0094],
		['OJogadorAnimador',	'tiago',			'Animator',											'https://twitter.com/Select3222',		0xFFFF0094],
		["MrFlamin'",			'flamin',			'Ideas and suggestions',	'https://www.youtube.com/channel/UC5z6qGZzkifFXFoA8Gqq1wA', 	0xFFF21811],
		["CanonDev",			'flamin',			'Ideas and suggestions',	'https://www.youtube.com/channel/UC5z6qGZzkifFXFoA8Gqq1wA', 	0xFFF21811],
		["MagiciansWRLD",		'flamin',			'Ideas and suggestions',	'https://www.youtube.com/channel/UC5z6qGZzkifFXFoA8Gqq1wA', 	0xFFF21811],
		[''],
		['Special Thanks'],
		['Cape',				'blank',		'Charter',											'https://twitter.com/TheMaskedChris',		0xFFAAAAFF],
		['TheMaskedChris',		'blank',		'Original Herobrine Sketch',						'https://gamebanana.com/members/1919621',	0xFF8888FF],
		[''],
		['Psych Engine Team'],
		['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		[''],
		['Engine Contributors'],
		['shubs',				'shubs',			'New Input System Programmer',						'https://twitter.com/yoshubs',			0xFF4494E6],
		['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		['gedehari',			'gedehari',			'Chart Editor\'s Sound Waveform base',				'https://twitter.com/gedehari',			0xFFFF9300],
		['Keoiki',				'keoiki',			'Note Splash Animations',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['SandPlanet',			'sandplanet',		'Mascot\'s Owner\nMain Supporter of the Engine',		'https://twitter.com/SandPlanetNG',		0xFFD10616],
		['bubba',				'bubba',		'Guest Composer for "Hot Dilf"',	'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw',	0xFF61536A],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite;
				if(Assets.exists(Paths.image('credits/' + creditsStuff[i][1])))
					icon = new AttachedSprite('credits/' + creditsStuff[i][1]);
				else
					icon = new AttachedSprite('credits/blank');
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP || FlxG.mouse.wheel >= 1)
		{
			changeSelection(-1);
		}
		if (downP || FlxG.mouse.wheel <= -1)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		/*if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}*/
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
