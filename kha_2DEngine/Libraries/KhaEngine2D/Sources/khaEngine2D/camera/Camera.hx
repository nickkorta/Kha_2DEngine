package khaEngine2D.camera;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.FastVector4;
import kha.math.FastVector2;

class Camera
{
	public static var i:Camera;

	public var bounds:FastVector4 = new FastVector4(0,0,0,0);
	public var view:FastVector4 = new FastVector4(0,0,0,0);
	public var position:FastVector2 = new FastVector2(0,0);

	private var transformation:FastMatrix3;

	public static function GetCamera():Camera
	{
		return i;
	}

	public function new() 
	{
		i = this;
		transformation = FastMatrix3.identity();
	}

	public function set(graphics:Graphics):Void 
	{
		view.z = 800;
		view.w = 600;

		 //Clamp X position to fit in bounds
		 if (bounds.z > bounds.x)
		 {
        	if (position.x < view.x) position.x = view.x;
        	if (position.x > bounds.z - view.x) position.x =  bounds.z - view.x;
		 }

        //Clamp Y position to fit in bounds
		 if (bounds.w > bounds.y)
		 {
        	if (position.y < view.y) position.y = view.y;
        	if (position.y > bounds.w - view.y) position.y =  bounds.w - view.y;
		 }

		graphics.pushTransformation(transformation);
		graphics.translate(-position.x + view.x,-position.y + view.y);
	}

	public function GetViewWidth():Float 
	{
		return view.z;
	}

	public function GetViewHeight():Float
	{		
		return view.w;
	}

	public function unset(graphics:Graphics):Void 
	{
  		graphics.popTransformation();
	}
}
