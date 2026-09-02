print "INIT", pc
    LDA !sprite_num,x
    STA $7FAB9E,x
    RTL

print "MAIN", pc
    PHB : PHK : PLB
    JSR HandleMovement
    JSR Graphics
    JSR SpriteCollision
    PLB
    RTL

HandleMovement:
    LDA $157C,x         
    BNE .MoveLeft       
.MoveRight:
    LDA #$10 : STA $B6,x : BRA .ApplyPhysics
.MoveLeft:
    LDA #$F0 : STA $B6,x           
.ApplyPhysics:
    JSL $018022         
    RTS

SpriteCollision:
    LDA !14C8,x         
    CMP #$08            
    BNE .EndRoutine     

    LDY #$0B            
.Loop
    CPY $15E9           
    BEQ .NextSlot

    LDA !14C8,y         
    CMP #$08            
    BNE .NextSlot       

    ; --- TARGET BULLET ID MATCH CHECK ---
    LDA !sprite_num,y   
    CMP #$01            
    BNE .NextSlot       

    ; --- POSITION DISTANCE MATHEMATICS ---
    LDA $E4,x           
    SEC : SBC $E4,y     
    BPL .AbsoluteX
    EOR #$FF : INC      
.AbsoluteX
    CMP #$0C            
    BCS .NextSlot       

    LDA $D8,x           
    SEC : SBC $D8,y     
    BPL .AbsoluteY
    EOR #$FF : INC      
.AbsoluteY
    CMP #$0C            
    BCS .NextSlot       

    ; --- PROCESS CLEAN DEATH ---
    LDA #$02 : STA !14C8,x
    LDA #$D0 : STA $AA,x
    LDA #$03 : STA $1DF9           
    LDA #$00 : STA !14C8,y         
    CLC : RTS                 

.NextSlot
    DEY
    BPL .Loop
.EndRoutine
    RTS                 

Graphics:
    LDA $9D             
    BNE .EarlyExit      
    
    JSL $019138         
    LDA $E4,x : SEC : SBC $1A : STA $0200,y         
    LDA $D8,x : SEC : SBC $1C : STA $0201,y         
    LDA #$24            
    STA $0202,y         
    
    LDA !sprite_oam_properties,x            ; Hardcoded to read Sprite Palette Row 8 (1st Row)
    STA $0203,y         
    LDY #$02 : LDA #$00 : JSL $01B7B3         
.EarlyExit
    RTS

