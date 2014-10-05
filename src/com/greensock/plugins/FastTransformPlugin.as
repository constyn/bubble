/**
 * VERSION: 3.0
 * DATE: 2010-09-21
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
package com.greensock.plugins {
	import com.greensock.*;
	
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Transform;
/**
 * @private
 * Slightly faster way to change a DisplayObject's x, y, scaleX, scaleY, and rotation value(s). You'd likely
 * only see a difference if/when tweening very large quantities of objects, but this just demonstrates
 * how you can use a TweenPlugin to optimize a particular kind of tween. The trade offs of using this 
 * plugin are: 
 * <ul>
 * 		<li>It affects x, y, scaleX, scaleY, and rotation (all of them)</li>
 * 		<li>It doesn't accommodate overwriting individual properties. But again, this is an example
 * 	   of using a plugin for a particular scenario where you know ahead of time what requirements
 * 	   you're working with. </li>
 * </ul><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import com.greensock.TweenLite; <br />
 * 		import com.greensock.plugins.~~; <br />
 * 		TweenPlugin.activate([FastTransformPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {fastTransform:{x:50, y:300, scaleX:2, scaleY:2, rotation:30}}); <br /><br />
 * </code>
 * 
 * <b>Copyright 2011, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class FastTransformPlugin extends TweenPlugin {
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		/** @private **/
		private static const _DEG2RAD:Number = Math.PI / 180;
		
		/** @private **/
		protected var _transform:Transform;
		/** @private **/
		protected var _matrix:Matrix;
		/** @private **/
		protected var _txStart:Number;
		/** @private **/
		protected var _txChange:Number;
		/** @private **/
		protected var _tyStart:Number;
		/** @private **/
		protected var _tyChange:Number;
		/** @private **/
		protected var _aStart:Number;
		/** @private **/
		protected var _aChange:Number;
		/** @private **/
		protected var _bStart:Number;
		/** @private **/
		protected var _bChange:Number;
		/** @private **/
		protected var _cStart:Number;
		/** @private **/
		protected var _cChange:Number;
		/** @private **/
		protected var _dStart:Number;
		/** @private **/
		protected var _dChange:Number;
		/** @private **/
		protected var _angleChange:Number = 0;
		
		/** @private **/
		public function FastTransformPlugin() {
			super();
			this.propName = "fastTransform";
			this.overwriteProps = ["x", "y", "scaleX", "scaleY", "rotation"];
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			_transform = target.transform as Transform;
			_matrix = _transform.matrix;
			var matrix:Matrix = _matrix.clone();
			_txStart = matrix.tx;
			_tyStart = matrix.ty;
			_aStart = matrix.a;
			_bStart = matrix.b;
			_cStart = matrix.c;
			_dStart = matrix.d;
			
			if ("x" in value) {
				_txChange = (typeof(value.x) == "number") ? value.x - _txStart : Number(value.x);
			} else {
				_txChange = 0;
			}
			if ("y" in value) {
				_tyChange = (typeof(value.y) == "number") ? value.y - _tyStart : Number(value.y);
			} else {
				_tyChange = 0;
			}
			
			if ("rotation" in value) {
				var angle:Number = Math.atan2(matrix.b, matrix.a); //Bugs in the Flex framework prevent DisplayObject.rotation from working consistently, so we must determine it using the matrix
				var finalAngle:Number = ("rotation" in value) ? (typeof(value.rotation) == "number") ? value.rotation * _DEG2RAD : Number(value.rotation) * _DEG2RAD + angle : angle;
				_angleChange = finalAngle - angle;
			}
			
			if ("scaleX" in value) {
				var ratioX:Number = Number(value.scaleX) / Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b);
				if (typeof(value.scaleX) != "number") { //relative value
					ratioX += 1;
				}
				matrix.a *= ratioX;
				matrix.b *= ratioX;
			}
			if ("scaleY" in value) {
				var ratioY:Number = Number(value.scaleY) / Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d);
				if (typeof(value.scaleY) != "number") { //relative value
					ratioY += 1;
				}
				matrix.c *= ratioY;
				matrix.d *= ratioY;
			}
			_aChange = matrix.a - _aStart;
			_bChange = matrix.b - _bStart;
			_cChange = matrix.c - _cStart;
			_dChange = matrix.d - _dStart;
			
			return true;
		}
		
		override public function set changeFactor(n:Number):void {
			_matrix.a = _aStart + (n * _aChange);
			_matrix.b = _bStart + (n * _bChange);
			_matrix.c = _cStart + (n * _cChange);
			_matrix.d = _dStart + (n * _dChange);
			if (_angleChange) {
				//about 3-4 times faster than _matrix.rotate(_angleChange * n);
				var cos:Number = Math.cos(_angleChange * n);
				var sin:Number = Math.sin(_angleChange * n);
				var a:Number = _matrix.a;
				var c:Number = _matrix.c;
				_matrix.a = a * cos - _matrix.b * sin;
				_matrix.b = a * sin + _matrix.b * cos;
				_matrix.c = c * cos - _matrix.d * sin;
				_matrix.d = c * sin + _matrix.d * cos;
			}
			_matrix.tx = _txStart + (n * _txChange);
			_matrix.ty = _tyStart + (n * _tyChange);
			_transform.matrix = _matrix;
		}

	}
}