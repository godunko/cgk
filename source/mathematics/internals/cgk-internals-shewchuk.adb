--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

with Interfaces;

with CGK.Internals.Shewchuk_Arithmetic;

package body CGK.Internals.Shewchuk is

   use type CGK.Reals.Real;

   Epsilon            : constant CGK.Reals.Real :=
     CGK.Reals.Real'Model_Epsilon * 0.5;
   Result_Error_Bound : constant CGK.Reals.Real :=
     (3.0 + 8.0 * Epsilon) * Epsilon;
   CCW_Error_Bound_A  : constant CGK.Reals.Real :=
     (3.0 + 16.0 * Epsilon) * Epsilon;
   CCW_Error_Bound_B  : constant CGK.Reals.Real :=
     (2.0 + 12.0 * Epsilon) * Epsilon;
   CCW_Error_Bound_C  : constant CGK.Reals.Real :=
     (9.0 + 64.0 * Epsilon) * Epsilon * Epsilon;

   function Orientation_Adaptive
     (PA      : CGK.Mathematics.Vectors_2.Vector_2;
      PB      : CGK.Mathematics.Vectors_2.Vector_2;
      PC      : CGK.Mathematics.Vectors_2.Vector_2;
      Det_Sum : CGK.Reals.Real) return CGK.Reals.Real;

   -----------------
   -- Orientation --
   -----------------

   function Orientation
     (PA : CGK.Mathematics.Vectors_2.Vector_2;
      PB : CGK.Mathematics.Vectors_2.Vector_2;
      PC : CGK.Mathematics.Vectors_2.Vector_2) return CGK.Reals.Real
   is
      Det_Left    : constant CGK.Reals.Real :=
        (PA (0) - PC (0)) * (PB (1) - PC (1));
      Det_Right   : constant CGK.Reals.Real :=
        (PA (1) - PC (1)) * (PB (0) - PC (0));
      Det         : constant CGK.Reals.Real := Det_Left - Det_Right;
      Det_Sum     : CGK.Reals.Real;
      Error_Bound : CGK.Reals.Real;

   begin
      if Det_Left > 0.0 then
         if Det_Right <= 0.0 then
            return Det;

         else
            Det_Sum := Det_Left + Det_Right;
         end if;

      elsif Det_Left < 0.0 then
         if Det_Right >= 0.0 then
            return Det;

         else
            Det_Sum := -Det_Left - Det_Right;
         end if;

      else
         return Det;
      end if;

      Error_Bound := CCW_Error_Bound_A * Det_Sum;

      if abs Det >= Error_Bound then
         return Det;
      end if;

      return Orientation_Adaptive (PA, PB, PC, Det_Sum);
   end Orientation;

   --------------------------
   -- Orientation_Adaptive --
   --------------------------

   function Orientation_Adaptive
     (PA      : CGK.Mathematics.Vectors_2.Vector_2;
      PB      : CGK.Mathematics.Vectors_2.Vector_2;
      PC      : CGK.Mathematics.Vectors_2.Vector_2;
      Det_Sum : CGK.Reals.Real) return CGK.Reals.Real
   is
      ACX : constant CGK.Reals.Real := PA (0) - PC (0);
      BCX : constant CGK.Reals.Real := PB (0) - PC (0);
      ACY : constant CGK.Reals.Real := PA (1) - PC (1);
      BCY : constant CGK.Reals.Real := PB (1) - PC (1);

      ACX_Tail       : CGk.Reals.Real;
      BCX_Tail       : CGk.Reals.Real;
      ACY_Tail       : CGk.Reals.Real;
      BCY_Tail       : CGk.Reals.Real;

      Det_Left       : CGk.Reals.Real;
      Det_Left_Tail  : CGk.Reals.Real;
      Det_Right      : CGk.Reals.Real;
      Det_Right_Tail : CGk.Reals.Real;
      Det            : CGk.Reals.Real;
      Error_Bound    : CGk.Reals.Real;

      B  : CGK.Internals.Shewchuk_Arithmetic.Real_Array (0 .. 3);
      U  : CGK.Internals.Shewchuk_Arithmetic.Real_Array (0 .. 3);

      C1  : CGK.Internals.Shewchuk_Arithmetic.Real_Array (0 .. 7);
      C1L : Interfaces.Unsigned_32;
      C2  : CGK.Internals.Shewchuk_Arithmetic.Real_Array (0 .. 11);
      C2L : Interfaces.Unsigned_32;
      D   : CGK.Internals.Shewchuk_Arithmetic.Real_Array (0 .. 15);
      DL  : Interfaces.Unsigned_32;

      S0 : CGK.Reals.Real;
      S1 : CGK.Reals.Real;
      T0 : CGK.Reals.Real;
      T1 : CGK.Reals.Real;

   begin
      CGK.Internals.Shewchuk_Arithmetic.Two_Product
        (ACX, BCY, Det_Left, Det_Left_Tail);
      CGK.Internals.Shewchuk_Arithmetic.Two_Product
        (ACY, BCX, Det_Right, Det_Right_Tail);

      CGK.Internals.Shewchuk_Arithmetic.Two_Two_Diff
        (Det_Left, Det_Left_Tail, Det_Right, Det_Right_Tail,
         B (3), B(2), B (1), B (0));

      Det := CGK.Internals.Shewchuk_Arithmetic.Estimate (B);
      Error_Bound := CCW_Error_Bound_B * Det_Sum;

      if abs Det >= Error_Bound then
         return Det;
      end if;

      CGK.Internals.Shewchuk_Arithmetic.Two_Diff_Tail
        (PA (0), PC (0), ACX, ACX_Tail);
      CGK.Internals.Shewchuk_Arithmetic.Two_Diff_Tail
        (PB (0), PC (0), BCX, BCX_Tail);
      CGK.Internals.Shewchuk_Arithmetic.Two_Diff_Tail
        (PA (1), PC (1), ACY, ACY_Tail);
      CGK.Internals.Shewchuk_Arithmetic.Two_Diff_Tail
        (PB (1), PC (1), BCY, BCY_Tail);

      if ACX_Tail = 0.0 and ACY_Tail = 0.0
        and BCX_Tail = 0.0 and BCY_Tail = 0.0
      then
         return Det;
      end if;

      Error_Bound :=
        CCW_Error_Bound_C * Det_Sum + Result_Error_Bound * abs Det;
      Det :=
        @ + (ACX * BCY_Tail + BCY * ACX_Tail)
          - (ACY * BCX_Tail + BCX * ACY_Tail);

      if abs Det >= Error_Bound then
         return Det;
      end if;

      CGK.Internals.Shewchuk_Arithmetic.Two_Product (ACX_Tail, BCY, S1, S0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Product (ACY_Tail, BCX, T1, T0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Two_Diff
        (S1, S0, T1, T0, U (3), U (2), U (1), U (0));
      CGK.Internals.Shewchuk_Arithmetic.Fast_Expansion_Sum_Zero_Elim
        (B, U, C1, C1L);

      CGK.Internals.Shewchuk_Arithmetic.Two_Product (ACX, BCY_Tail, S1, S0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Product (ACY, BCX_Tail, T1, T0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Two_Diff
        (S1, S0, T1, T0, U (3), U (2), U (1), U (0));
      CGK.Internals.Shewchuk_Arithmetic.Fast_Expansion_Sum_Zero_Elim
        (C1 (C1'First .. C1L), U, C2, C2L);

      CGK.Internals.Shewchuk_Arithmetic.Two_Product
        (ACX_Tail, BCY_Tail, S1, S0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Product
        (ACY_Tail, BCX_Tail, T1, T0);
      CGK.Internals.Shewchuk_Arithmetic.Two_Two_Diff
        (S1, S0, T1, T0, U (3), U (2), U (1), U (0));
      CGK.Internals.Shewchuk_Arithmetic.Fast_Expansion_Sum_Zero_Elim
        (C2 (C2'First .. C2L), U, D, DL);

      return D (DL);
   end Orientation_Adaptive;

end CGK.Internals.Shewchuk;
