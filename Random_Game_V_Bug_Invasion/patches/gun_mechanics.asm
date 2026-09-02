; gun_mechanics.asm - Core Weapon Engine updated for your custom list.txt
print "MAIN", pc
    ; --- STEP 1: VALIDATE THE POWER-UP STATE ---
    LDA $19             ; Check Mario's power-up status flag
    CMP #$04            ; Is it below our first custom gun ID?
    BCC .Exit           ; If Mario is 0, 1, 2, or 3, exit.
    CMP #$08            ; Is it 8 or higher?
    BCS .Exit           ; If outside our 4-weapon system (4, 5, 6, 7), exit.

    ; --- STEP 2: WAIT FOR USER CONTROLLER INPUT ---
    LDA $16             ; Read newly pressed controller input buttons
    AND #$40            ; Check for X or Y button presses
    BEQ .Exit           ; Exit if the button isn't pressed this frame

    ; --- STEP 3: CALCULATE MATCHING BULLET ID ---
    LDA $19             ; Reload current power-up state (4, 5, 6, or 7)
    SEC
    SBC #$04            ; Subtract 4 to normalize to an offset (0, 1, 2, or 3)
    TAX                 ; Transfer this offset into Index Register X
    
    LDA BulletTable,x   ; Look up the matching Pixi Sprite ID from our array below
    SEC                 ; Flag to signal Pixi custom sprite allocation
    %spawn_sprite()     ; Call Pixi's internal object spawning routine
    BCS .SpawnFailed    ; Cancel bullet logic if sprite slots are full

    ; --- STEP 4: ASSIGN MOTION PHYSICS VECTOR ---
    LDA $94 : STA $E4,x ; Anchor bullet spawn coordinate to Mario's X Low
    LDA $95 : STA $14E0,x ; Anchor bullet spawn coordinate to Mario's X High
    LDA $96 : STA $D8,x ; Anchor bullet spawn coordinate to Mario's Y

    LDA $76             ; Check Player facing direction vector (00=Left, 01=Right)
    BNE .FaceRight
    
    LDA #$D0            ; Move Bullet Left (Hex negative speed)
    STA $B6,x
    BRA .SpawnFailed
    
.FaceRight
    LDA #$30            ; Move Bullet Right (Hex positive speed)
    STA $B6,x

.SpawnFailed
.Exit
    RTL

; --- THE COMPATIBILITY DATA LOOKUP TABLE ---
BulletTable:
    db #$01             ; Power-up #$04 (Red Gun)    shoots Sprite ID #$01 (red_bullet.asm)
    db #$02             ; Power-up #$05 (Yellow Gun) shoots Sprite ID #$02 (yellow_bullet.asm)
    db #$03             ; Power-up #$06 (Green Gun)  shoots Sprite ID #$03 (green_bullet.asm)
    db #$04             ; Power-up #$07 (Blue Gun)   shoots Sprite ID #$04 (blue_bullet.asm)

