package 
{
   import com.greensock.TweenMax;
   import com.greensock.data.TweenLiteVars;
   import config.Config;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.getDefinitionByName;

   import flash.display.Sprite;

   public class Preloader extends MovieClip
   {
       private var bar:Sprite;

       public function Preloader()
       {
           if (stage) 
		   {
               stage.scaleMode = StageScaleMode.NO_SCALE;
               stage.align = StageAlign.TOP_LEFT;
           }
           addEventListener(Event.ENTER_FRAME, checkFrame);
           loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
           loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
           bar = new Sprite();
           bar.graphics.lineStyle(1, Config.C5, 1, true);
           bar.graphics.drawRoundRect(0, 0, 300, 10, 3, 3);
           bar.x = (Config.WIDTH - bar.width) / 2;
           bar.y = (Config.HEIGHT - bar.height) / 2 + 100;
           addChild(bar);		   
		   
       }
		
       private function ioError(e:IOErrorEvent):void
       {
           trace(e.text);
       }
		
       private function progress(e:ProgressEvent):void
       {
           bar.graphics.lineStyle(0, 0, 0);
           bar.graphics.beginFill(Config.C6);
           bar.graphics.drawRoundRect(1, 1, (e.bytesLoaded / e.bytesTotal) * 298 , 8, 2, 2);
           bar.graphics.endFill();
       }
		
       private function checkFrame(e:Event):void
       {
           if (currentFrame == totalFrames)
           {
               stop();
               loadingFinished();
           }
       }
		
       private function loadingFinished():void
       {
           removeEventListener(Event.ENTER_FRAME, checkFrame);
           loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
           loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
           removeChild(bar);
           bar = null;
			
           startup();
           stop();
       }
		
       private function startup():void
       {
           var mainClass:Class = getDefinitionByName("Main") as Class;
           addChild(new mainClass() as DisplayObject);
       }
   }
}