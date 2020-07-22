; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; Test that blez/ bgez are selected.
; RUN: llc -mtriple=mipsel-mti-linux-gnu < %s | FileCheck %s --check-prefix=MIPS32
; RUN: llc -mtriple=mips64el-mti-linux-gnu < %s | FileCheck %s --check-prefix=MIPS64
; RUN: llc -mtriple=mipsel-mti-linux-gnu -mattr=+micromips < %s | FileCheck %s --check-prefix=MM

define void @test_blez(i32 %a) {
; MIPS32-LABEL: test_blez:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    blez $4, $BB0_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %if.then
; MIPS32-NEXT:    addiu $sp, $sp, -24
; MIPS32-NEXT:    .cfi_def_cfa_offset 24
; MIPS32-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    .cfi_offset 31, -4
; MIPS32-NEXT:    jal foo1
; MIPS32-NEXT:    nop
; MIPS32-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 24
; MIPS32-NEXT:  $BB0_2: # %if.end
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
;
; MIPS64-LABEL: test_blez:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    sll $1, $4, 0
; MIPS64-NEXT:    blez $1, .LBB0_2
; MIPS64-NEXT:    nop
; MIPS64-NEXT:  # %bb.1: # %if.then
; MIPS64-NEXT:    daddiu $sp, $sp, -16
; MIPS64-NEXT:    .cfi_def_cfa_offset 16
; MIPS64-NEXT:    sd $ra, 8($sp) # 8-byte Folded Spill
; MIPS64-NEXT:    .cfi_offset 31, -8
; MIPS64-NEXT:    jal foo1
; MIPS64-NEXT:    nop
; MIPS64-NEXT:    ld $ra, 8($sp) # 8-byte Folded Reload
; MIPS64-NEXT:    daddiu $sp, $sp, 16
; MIPS64-NEXT:  .LBB0_2: # %if.end
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    nop
;
; MM-LABEL: test_blez:
; MM:       # %bb.0: # %entry
; MM-NEXT:    blez $4, $BB0_3
; MM-NEXT:    nop
; MM-NEXT:  # %bb.1: # %entry
; MM-NEXT:    j $BB0_2
; MM-NEXT:    nop
; MM-NEXT:  $BB0_2: # %if.then
; MM-NEXT:    addiu $sp, $sp, -24
; MM-NEXT:    .cfi_def_cfa_offset 24
; MM-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MM-NEXT:    .cfi_offset 31, -4
; MM-NEXT:    jal foo1
; MM-NEXT:    nop
; MM-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MM-NEXT:    addiu $sp, $sp, 24
; MM-NEXT:  $BB0_3: # %if.end
; MM-NEXT:    jrc $ra
entry:
  %cmp = icmp sgt i32 %a, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo1()
  br label %if.end

if.end:
  ret void
}

declare void @foo1()

define void @test_bgez(i32 %a) {
; MIPS32-LABEL: test_bgez:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    bltz $4, $BB1_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %if.end
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_2: # %if.then
; MIPS32-NEXT:    addiu $sp, $sp, -24
; MIPS32-NEXT:    .cfi_def_cfa_offset 24
; MIPS32-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    .cfi_offset 31, -4
; MIPS32-NEXT:    jal foo1
; MIPS32-NEXT:    nop
; MIPS32-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    addiu $sp, $sp, 24
;
; MIPS64-LABEL: test_bgez:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    sll $1, $4, 0
; MIPS64-NEXT:    bltz $1, .LBB1_2
; MIPS64-NEXT:    nop
; MIPS64-NEXT:  # %bb.1: # %if.end
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    nop
; MIPS64-NEXT:  .LBB1_2: # %if.then
; MIPS64-NEXT:    daddiu $sp, $sp, -16
; MIPS64-NEXT:    .cfi_def_cfa_offset 16
; MIPS64-NEXT:    sd $ra, 8($sp) # 8-byte Folded Spill
; MIPS64-NEXT:    .cfi_offset 31, -8
; MIPS64-NEXT:    jal foo1
; MIPS64-NEXT:    nop
; MIPS64-NEXT:    ld $ra, 8($sp) # 8-byte Folded Reload
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    daddiu $sp, $sp, 16
;
; MM-LABEL: test_bgez:
; MM:       # %bb.0: # %entry
; MM-NEXT:    bgez $4, $BB1_2
; MM-NEXT:    nop
; MM-NEXT:  # %bb.1: # %entry
; MM-NEXT:    j $BB1_3
; MM-NEXT:    nop
; MM-NEXT:  $BB1_2: # %if.end
; MM-NEXT:    jrc $ra
; MM-NEXT:  $BB1_3: # %if.then
; MM-NEXT:    addiu $sp, $sp, -24
; MM-NEXT:    .cfi_def_cfa_offset 24
; MM-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MM-NEXT:    .cfi_offset 31, -4
; MM-NEXT:    jal foo1
; MM-NEXT:    nop
; MM-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MM-NEXT:    jr $ra
; MM-NEXT:    addiu $sp, $sp, 24
entry:
  %cmp = icmp slt i32 %a, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo1()
  br label %if.end

if.end:
  ret void
}
