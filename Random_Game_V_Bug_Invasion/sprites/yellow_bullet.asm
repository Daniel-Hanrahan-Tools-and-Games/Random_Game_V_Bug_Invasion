print "INIT", pc
    LDA !sprite_num,x
    STA $7FAB9E,x
    RTL

print "MAIN", pc
    PHB : PHK : PLB
    
    ; Flying speed handler
    LDA $157C,x         
    BNE .FlyLeft
.FlyRight:
    LDA #$30 : STA $B6,x : BRA .ApplyPhysics
.FlyLeft:
    LDA #$D0 : STA $B6,x

.ApplyPhysics:
    JSL $018022         

    ; Drawing handler
    LDA $9D             
    BNE .Return         
    
    JSL $019138         
    LDA $E4,x : SEC : SBC $1A : STA $0200,y
    LDA $D8,x : SEC : SBC $1C : STA $0201,y
    LDA #$21            ; Hardcoded: Yellow Bullet Tile
    STA $0202,y 
    LDA !sprite_oam_properties,x            ; Shared Palette Row 1
    
    LDY #$02 : LDA #$00 : JSL $01B7B3 
.Return
    PLB
    RTL

