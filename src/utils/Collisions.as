package utils{    import flash.display.BitmapData;    import flash.display.Sprite;    import flash.display.Bitmap;    import flash.geom.*;    import config.Config;    public class Collisions    {        static protected var bitmap:Bitmap;        	    static public function checkCollision(obj1:Sprite,obj2:Sprite,alphaTol:Number = 255):Boolean	    {		    		    if (!obj1 || ! obj2 || !obj1.hitTestObject(obj2)) 		        return false;			        		    var img:BitmapData = new BitmapData(Config.WIDTH, Config.HEIGHT, false);				    var point:Point = obj2.parent.localToGlobal(new Point(obj2.x, obj2.y))		    		    var mat:Matrix = new Matrix()		    mat.rotate(obj1.rotation * Math.PI/180)		    mat.translate(obj1.x, obj1.y)		    img.draw(obj1, mat, new ColorTransform(1,1,1,1,255,-255,-255,alphaTol));				    mat = new Matrix()		    		    mat.rotate(obj2.rotation * Math.PI/180)		    mat.translate(point.x, point.y)		    img.draw(obj2, mat, new ColorTransform(1,1,1,1,255,255,255,alphaTol),"difference");				    var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);		    		    		    if (intersection.width == 0) 		    {		         return false; 		    }   		    else		    {		        //debug info		        /*if(bitmap && obj1.parent.contains(bitmap))		            obj1.parent.removeChild(bitmap)		            		        bitmap = new Bitmap(img)		        bitmap.alpha = .3		        obj1.parent.addChild(bitmap) */		        return true;   		    }		    	    }	}}