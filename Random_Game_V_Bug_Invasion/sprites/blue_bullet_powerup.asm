; custom_powerup.asm - Animating collectible item
print "INIT", pc
    LDA !sprite_num,x
    STA $7FAB9E,x
    RTL

print "MAIN", pc
    PHB : PHK : PLB
    JSR GraphicRoutine     
    JSR InteractionRoutine 
    PLB
    RTL

InteractionRoutine:
    JSL $01A7DC            
    BCC .NoContact         

    ; --- UNLOCK BLUE GUN STATE ---
    LDA #$04               
    STA $1DF0              ; Stores unique weapon ID #$04 for blue
    
    LDA #$0B               
    STA $1DF9              
    
    LDA #$00               
    STA !14C8,x            
.NoContact
    JSL $018022            
    RTS

GraphicRoutine:
    LDA $9D                
    BNE .EarlyExit         
    
    JSL $019138            

    LDA $E4,x : SEC : SBC $1A : STA $0200,y 
    LDA $D8,x : SEC : SBC $1C : STA $0201,y 

    LDA $14                
    LSR #3                 
    AND #$01               
    BEQ .FirstFrame        

.SecondFrame:
    LDA #$0E               ; Hardcoded: Blue Frame 2
    BRA .Draw

.FirstFrame:
    LDA #$06               ; Hardcoded: Blue Frame 1

.Draw:
    STA $0202,y            
    LDA !sprite_oam_properties,x               
    STA $0203,y         
    LDY #$02 : LDA #$00 : JSL $01B7B3         
.EarlyExit
    RTS

