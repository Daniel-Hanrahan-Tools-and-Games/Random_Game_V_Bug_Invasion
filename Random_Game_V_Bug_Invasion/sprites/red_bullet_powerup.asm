; custom_powerup.asm - Animating collectible item
print "INIT", pc
    LDA !sprite_num,x
    STA $7FAB9E,x
    RTL

print "MAIN", pc
    PHB : PHK : PLB
    JSR GraphicRoutine     ; Animate and draw item on screen
    JSR InteractionRoutine ; Check if Mario touches it
    PLB
    RTL

InteractionRoutine:
    JSL $01A7DC            ; Call built-in Mario/Sprite contact routine
    BCC .NoContact         ; Skip if no contact

    ; --- SAFE CUSTOM ITEM INTERACTION ---
    ; Storing here tracks your custom weapon state without crashing the game
    LDA #$01               
    STA $1DF0              ; $1DF0 tracks custom gun state cleanly
    
    LDA #$0B               ; Play "Power-up" sound effect
    STA $1DF9              
    
    LDA #$00               ; Safely erase item from map
    STA !14C8,x            
.NoContact
    JSL $018022            ; Apply standard gravity processing to the item
    RTS

GraphicRoutine:
    LDA $9D                ; Check if graphics are locked down or loading
    BNE .EarlyExit         ; Skip drawing this frame to protect VRAM
    
    JSL $019138            ; Setup OAM allocation safely via PIXI

    ; --- CALCULATE SCREEN POSITION ---
    ; This fixes the jumbled look by snapping the tile directly onto the object
    LDA $E4,x : SEC : SBC $1A : STA $0200,y ; X Position relative to camera
    LDA $D8,x : SEC : SBC $1C : STA $0201,y ; Y Position relative to camera

    ; --- THE CUSTOM 2-FRAME ANIMATION ENGINE ---
    LDA $14                ; Read SNES global frame counter timer
    LSR #3                 ; Speed control
    AND #$01               ; 2 frames toggle
    BEQ .FirstFrame        

.SecondFrame:
    LDA #$08               ; Perfectly matches the top-left corner of your 2nd frame!
    BRA .Draw

.FirstFrame:
    LDA #$00               ; First frame icon tile (#$00)

.Draw:
    STA $0202,y            

    LDA !sprite_oam_properties,x               ; Set Palette Row A / Keep sprite in front layer
    STA $0203,y         

    LDY #$02               ; Force 16x16 pixel size boundary
    LDA #$00               ; Standard single tile allocation index
    JSL $01B7B3            ; Render to screen registers
.EarlyExit
    RTS

