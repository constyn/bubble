package utils
{
    import com.greensock.TweenLite;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.filters.DropShadowFilter;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;

    //--------------------------------------
    // Events
    //--------------------------------------


    //--------------------------------------
    //  Class
    //--------------------------------------
    /**
     */
    public class Label extends TextField
    {
        //--------------------------------------
        //  Class constants
        //--------------------------------------


        //--------------------------------------
        //  Class variables
        //--------------------------------------

        private var _tooltip:String = "";
        private var _text:String = "";
        private var tooltipContainer:Sprite;
        private var tooltipTextField:TextField;
        private var tooltipActive:Boolean;

        private var defTextFormat:TextFormat;

        private var _maxWidth:Number;
        //--------------------------------------
        //  Constructor / class initialization
        //--------------------------------------
        /**
         * Constructor calls initialization function init().
         */
        public function Label()
        {
            super();
            init();
        }

        /**
         * Called on initialize process directly after construction but before createChildren is called.
         */
        private function init():void
        {
            this.selectable = false;
            this.multiline = false;
            this.autoSize = TextFieldAutoSize.LEFT;

            tooltipContainer = new Sprite();
            tooltipContainer.mouseChildren = false;
            tooltipContainer.mouseEnabled = false;
            tooltipContainer.filters = [new DropShadowFilter(3, 45, 0x000000, .5, 3, 3, 1, 3)];

            tooltipTextField = new TextField();
            tooltipContainer.addChild(tooltipTextField);
            tooltipTextField.defaultTextFormat = new TextFormat("Verdana", 10, 0x000000);

            defTextFormat = new TextFormat("Verdana", 10, 0xFFFFFF);
            this.defaultTextFormat = defTextFormat;
        }

        public function setSize(_width:Number, _height:Number):void
        {
            this.width = _width;
        }


        //--------------------------------------
        // getter / setter 
        //--------------------------------------


        //--------------------------------------
        // event handler
        //--------------------------------------


        //--------------------------------------
        // public methods
        //--------------------------------------

        public function set tooltip(value:String):void
        {
            if(value == "")
            {
                removeEventListener(MouseEvent.ROLL_OVER, showTooltip);
                          removeEventListener(MouseEvent.ROLL_OUT, fadeOutTooltip);
                removeEventListener(MouseEvent.MOUSE_MOVE, updateTooltip);
            }
            else
            {
                addEventListener(MouseEvent.ROLL_OVER, showTooltip);
                addEventListener(MouseEvent.ROLL_OUT, fadeOutTooltip);
                addEventListener(MouseEvent.MOUSE_MOVE, updateTooltip);
            }
            _tooltip = value;
            tooltipTextField.text = _tooltip;
            tooltipTextField.autoSize = TextFieldAutoSize.LEFT;
            tooltipTextField.selectable = false;
            drawContainer();
        }

        //--------------------------------------
        // private functions
        //--------------------------------------

        private function showTooltip(event:MouseEvent):void
        {
            if (!stage)
                return;

            stage.addChild(tooltipContainer);

            tooltipContainer.x =  event.stageX + tooltipContainer.width + 20 < stage.stageWidth? event.stageX + 20: event.stageX - tooltipContainer.width;
            tooltipContainer.y =  event.stageY + tooltipContainer.height + 20 < stage.stageHeight ? event.stageY + 20: event.stageY - tooltipContainer.height;
            tooltipContainer.alpha = 0;
            TweenLite.to(tooltipContainer, .3, {delay:.5, alpha:1});

            tooltipActive = true;
        }

        private function fadeOutTooltip(event:MouseEvent):void
        {
            if (!tooltipActive)
                return;

            var makeItSureTimer:Timer = new Timer(1000, 1);
            makeItSureTimer.addEventListener(TimerEvent.TIMER, removeTooltip);
            makeItSureTimer.start();

            TweenLite.to(tooltipContainer, .2, {delay:.1, alpha:0, onComplete:removeTooltip})
        }

        private function removeTooltip(event:TimerEvent = null):void
        {
            if (tooltipContainer.parent && tooltipContainer.parent == stage)
                stage.removeChild(tooltipContainer);
            tooltipActive = false;
        }

        private function drawContainer():void
        {
            tooltipContainer.graphics.lineStyle(1, 0x000000, 1.0, true);
            tooltipContainer.graphics.beginFill(0xFFFFE1, 1.0);
            tooltipContainer.graphics.drawRoundRect(-1, -1, tooltipTextField.width + 2, tooltipTextField.height + 2, 3, 3);
            tooltipContainer.graphics.endFill();
        }

        private function updateTooltip(event:MouseEvent):void
        {
            if(!tooltipActive)
                showTooltip(event);
        }

        public function updateView():void
        {
            if (_maxWidth < 16)
                _maxWidth = 16;

            if (this.textWidth > _maxWidth)
            {
                if(_tooltip == "")
                    this.tooltip = _text;

                _text = _text.substr(0, text.length - 1 - (_text.indexOf("...") == -1? 0:3));
                this.text = _text + "...";
            }
            }

        override public function set text(value:String):void
        {
            super.text = value;
            _text = value;
            updateView();
        }

        override public function set width(value:Number):void
        {
            super.width = value;
        }

        public function set maxWidth(value:Number):void
        {
            _maxWidth = value;
            if(_tooltip != "")
                this.text = _tooltip;
            }

        public function get maxWidth():Number
        {
            return _maxWidth;
        }
    }
}