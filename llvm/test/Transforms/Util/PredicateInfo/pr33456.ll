; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -print-predicateinfo -analyze  < %s 2>&1 | FileCheck %s
; Don't insert predicate info for conditions with a single target.
@a = global i32 1, align 4
@d = common global i32 0, align 4
@c = common global i32 0, align 4
@b = common global i32 0, align 4
@e = common global i32 0, align 4

define i32 @main() {
; CHECK-LABEL: @main(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* @d, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP13:%.*]]
; CHECK:         [[TMP4:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* @c, align 4
; CHECK-NEXT:    [[TMP6:%.*]] = icmp slt i32 [[TMP5]], 1
; CHECK-NEXT:    br i1 [[TMP6]], label [[TMP7:%.*]], label [[TMP9:%.*]]
; CHECK:         [[TMP8:%.*]] = icmp eq i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[TMP9]], label [[TMP9]]
; CHECK:         [[DOT0:%.*]] = phi i32 [ [[TMP4]], [[TMP7]] ], [ [[TMP4]], [[TMP7]] ], [ [[DOT1:%.*]], [[TMP13]] ], [ [[TMP4]], [[TMP3]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, i32* @b, align 4
; CHECK-NEXT:    [[TMP11:%.*]] = sdiv i32 [[TMP10]], [[DOT0]]
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i32 [[TMP11]], 0
; CHECK-NEXT:    br i1 [[TMP12]], label [[TMP13]], label [[TMP13]]
; CHECK:         [[DOT1]] = phi i32 [ [[DOT0]], [[TMP9]] ], [ [[DOT0]], [[TMP9]] ], [ undef, [[TMP0:%.*]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, i32* @e, align 4
; CHECK-NEXT:    [[TMP15:%.*]] = icmp eq i32 [[TMP14]], 0
; CHECK-NEXT:    br i1 [[TMP15]], label [[TMP16:%.*]], label [[TMP9]]
; CHECK:         ret i32 0
;
  %1 = load i32, i32* @d, align 4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %13

; <label>:3:                                      ; preds = %0
  %4 = load i32, i32* @a, align 4
  %5 = load i32, i32* @c, align 4
  %6 = icmp slt i32 %5, 1
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %3
  %8 = icmp eq i32 %4, 0
  br i1 %8, label %9, label %9

; <label>:9:                                      ; preds = %13, %7, %7, %3
  %.0 = phi i32 [ %4, %7 ], [ %4, %7 ], [ %.1, %13 ], [ %4, %3 ]
  %10 = load i32, i32* @b, align 4
  %11 = sdiv i32 %10, %.0
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %13

; <label>:13:                                     ; preds = %9, %9, %0
  %.1 = phi i32 [ %.0, %9 ], [ %.0, %9 ], [ undef, %0 ]
  %14 = load i32, i32* @e, align 4
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %9

; <label>:16:                                     ; preds = %13
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

