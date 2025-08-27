package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.geom.Point;
import openfl.events.MouseEvent;

class TwistedBrainDemoMain extends Sprite {
    
    private var welcomeTextField:TextField;
    private var logoSprite:Sprite;
    private var currentLogoIndex:Int = 0;
    private var logoAssets:Array<String>;
    
    public function new() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
    
    private function onAddedToStage(event:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        
        setupLogoAssets();
        createWelcomeText();
        createLogoDisplay();
        setupInteraction();
    }
    
    private function setupLogoAssets():Void {
        logoAssets = [
            "assets/tb.png",
            "assets/tb_2.png",
            "assets/tb_3.png",
            "assets/tb_4.png",
            "assets/tb_5.png"
        ];
    }
    
    private function createWelcomeText():Void {
        welcomeTextField = new TextField();
        var textFormat = new TextFormat();
        textFormat.font = "Arial";
        textFormat.size = 24;
        textFormat.color = 0xFFFFFF;
        textFormat.bold = true;
        
        welcomeTextField.defaultTextFormat = textFormat;
        welcomeTextField.text = "Welcome to TwistedBrain Demo!";
        welcomeTextField.autoSize = TextFieldAutoSize.CENTER;
        welcomeTextField.x = (stage.stageWidth - welcomeTextField.width) / 2;
        welcomeTextField.y = 50;
        
        addChild(welcomeTextField);
    }
    
    private function createLogoDisplay():Void {
        logoSprite = new Sprite();
        logoSprite.x = stage.stageWidth / 2;
        logoSprite.y = stage.stageHeight / 2;
        addChild(logoSprite);
        
        displayCurrentLogo();
    }
    
    private function displayCurrentLogo():Void {
        // Clear previous logo
        while (logoSprite.numChildren > 0) {
            logoSprite.removeChildAt(0);
        }
        
        var logoAsset = logoAssets[currentLogoIndex];
        var bitmapData = Assets.getBitmapData(logoAsset);
        
        if (bitmapData != null) {
            var bitmap = new Bitmap(bitmapData);
            bitmap.x = -bitmap.width / 2;
            bitmap.y = -bitmap.height / 2;
            logoSprite.addChild(bitmap);
        }
    }
    
    private function setupInteraction():Void {
        stage.addEventListener(MouseEvent.CLICK, onStageClick);
        
        var instructionText = new TextField();
        var textFormat = new TextFormat();
        textFormat.font = "Arial";
        textFormat.size = 16;
        textFormat.color = 0xCCCCCC;
        
        instructionText.defaultTextFormat = textFormat;
        instructionText.text = "Click anywhere to cycle through logos";
        instructionText.autoSize = TextFieldAutoSize.CENTER;
        instructionText.x = (stage.stageWidth - instructionText.width) / 2;
        instructionText.y = stage.stageHeight - 100;
        
        addChild(instructionText);
    }
    
    private function onStageClick(event:MouseEvent):Void {
        currentLogoIndex = (currentLogoIndex + 1) % logoAssets.length;
        displayCurrentLogo();
    }
}