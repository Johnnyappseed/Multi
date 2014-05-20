package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.Lib;

import openfl.Assets;
import motion.Actuate;

import box2D.dynamics.contacts.B2ContactEdge;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.dynamics.joints.B2RevoluteJointDef;

import flash.net.URLLoader;
import flash.net.URLRequest;

/**
 * ...
 * @author John
 */

class Main extends Sprite 
{
	var inited:Bool;
	/* ENTRY POINT */
	public static var game;
	public static var PHYSICS_SCALE:Float = 1.0 / 30;
	private var PhysicsDebug:Sprite;
	public static var World:B2World;
	
	
	function init() 
	{
		//vars
		if (inited) return;
		inited = true;
		
		game = this;
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);
		World = new B2World(new B2Vec2 (0, 10.0), true);
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit + B2DebugDraw.e_centerOfMassBit + B2DebugDraw.e_aabbBit);// + B2DebugDraw.e_aabbBit);
		
		//shows fancy physics objects (remove before game is finished)
		World.setDebugDraw(debugDraw);
		
		//event listeners
		addEventListener (Event.ENTER_FRAME, enterFrame);
		
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	function enterFrame(e:Event)
	{
		//World stuff
		World.step (1 / Lib.current.stage.frameRate, 10, 10);
		World.clearForces ();
		World.drawDebugData ();
		
		
	}
	

	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
