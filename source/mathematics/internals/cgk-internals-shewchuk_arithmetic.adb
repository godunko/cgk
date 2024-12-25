--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

package body CGK.Internals.Shewchuk_Arithmetic is

   use type Interfaces.Unsigned_32;
   use type CGK.Reals.Real;

   Splitter : constant CGK.Reals.Real := 134_217_729.0;
   --  The value to split a IEEE 64bit value on during multiplication.

   procedure Two_Diff
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real);

   procedure Two_One_Diff
     (A1 : CGK.Reals.Real;
      A0 : CGK.Reals.Real;
      B  : CGK.Reals.Real;
      X2 : out CGK.Reals.Real;
      X1 : out CGK.Reals.Real;
      X0 : out CGK.Reals.Real);

   procedure Split
     (A   : CGK.Reals.Real;
      AHi : out CGK.Reals.Real;
      ALo : out CGK.Reals.Real);

   procedure Fast_Two_Sum
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real);

   procedure Fast_Two_Sum_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real);

   procedure Two_Product_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real);

   procedure Two_Sum_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real);

   --------------
   -- Estimate --
   --------------

   function Estimate (E : Real_Array) return CGK.Reals.Real is
      Q : CGK.Reals.Real := E (E'First);

   begin
      for J in E'First + 1 .. E'Last loop
         Q := @ + E (J);
      end loop;

      return Q;
   end Estimate;

   ----------------------------------
   -- Fast_Expansion_Sum_Zero_Elim --
   ----------------------------------

   procedure Fast_Expansion_Sum_Zero_Elim
     (E : Real_Array;
      F : Real_Array;
      H : out Real_Array;
      L : out Interfaces.Unsigned_32)
   is
      E_Index : Interfaces.Unsigned_32 := E'First;
      F_Index : Interfaces.Unsigned_32 := F'First;
      H_Index : Interfaces.Unsigned_32 := H'First;
      Q       : CGK.Reals.Real;
      Q_New   : CGK.Reals.Real;
      HH      : CGK.Reals.Real;

   begin
      if (F (F_Index) > E (E_Index)) = (F (F_Index) > -E (E_Index)) then
         Q       := E (E_Index);
         E_Index := @ + 1;

      else
         Q       := F (F_Index);
         F_Index := @ + 1;
      end if;

      if E_Index <= E'Last and F_Index <= F'Last then
         if (F (F_Index) > E (E_Index)) = (F (F_Index) > -E (E_Index)) then
            Fast_Two_Sum (E (E_Index), Q, Q_New, HH);
            E_Index := @ + 1;

         else
            Fast_Two_Sum (F (F_Index), Q, Q_New, HH);
            F_Index := @ + 1;
         end if;

         Q := Q_New;

         if HH /= 0.0 then
            H (H_Index) := HH;
            H_Index := @ + 1;
         end if;

         while E_Index <= E'Last and F_Index <= F'Last loop
            if (F (F_Index) > E (E_Index)) = (F (F_Index) > -E (E_Index)) then
               Two_Sum (Q, E (E_Index), Q_New, HH);
               E_Index := @ + 1;

            else
               Two_Sum (Q, F (F_Index), Q_New, HH);
               F_Index := @ + 1;
            end if;

            Q := Q_New;

            if HH /= 0.0 then
               H (H_Index) := HH;
               H_Index := @ + 1;
            end if;
         end loop;
      end if;

      while E_Index <= E'Last loop
         Two_Sum (Q, E (E_Index), Q_New, HH);
         E_Index := @ + 1;
         Q := Q_New;

         if HH /= 0.0 then
            H (H_Index) := HH;
            H_Index := @ + 1;
         end if;
      end loop;

      while F_Index <= F'Last loop
         Two_Sum (Q, F (F_Index), Q_New, HH);
         F_Index := @ + 1;
         Q := Q_New;

         if HH /= 0.0 then
            H (H_Index) := HH;
            H_Index := @ + 1;
         end if;
      end loop;

      if Q /= 0.0 or H_Index = H'First then
         H (H_Index) := Q;
         H_Index := @ + 1;
      end if;

      L := H_Index - 1;
   end Fast_Expansion_Sum_Zero_Elim;

   ------------------
   -- Fast_Two_Sum --
   ------------------

   procedure Fast_Two_Sum
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real) is
   begin
      X := A + B;
      Fast_Two_Sum_Tail (A, B, X, Y);
   end Fast_Two_Sum;

   -----------------------
   -- Fast_Two_Sum_Tail --
   -----------------------

   procedure Fast_Two_Sum_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real)
   is
      B_Virt : constant CGK.Reals.Real := X - A;

   begin
      Y := B - B_Virt;
   end Fast_Two_Sum_Tail;

   -----------
   -- Split --
   -----------

   procedure Split
     (A   : CGK.Reals.Real;
      AHi : out CGK.Reals.Real;
      ALo : out CGK.Reals.Real)
   is
      C : constant CGK.Reals.Real := Splitter * A;
      B : constant CGK.Reals.Real := C - A;

   begin
      AHi := C - B;
      ALo := A - AHi;
   end Split;

   --------------
   -- Two_Diff --
   --------------

   procedure Two_Diff
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real) is
   begin
      X := A - B;
      Two_Diff_Tail (A, B, X, Y);
   end Two_Diff;

   -------------------
   -- Two_Diff_Tail --
   -------------------

   procedure Two_Diff_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real)
   is
      B_Virt  : constant CGK.Reals.Real := A - X;
      A_Virt  : constant CGK.Reals.Real := X + B_Virt;
      B_Round : constant CGK.Reals.Real := B_Virt - B;
      A_Round : constant CGK.Reals.Real := A - A_Virt;

   begin
      Y := A_Round + B_Round;
   end Two_Diff_Tail;

   ------------------
   -- Two_One_Diff --
   ------------------

   procedure Two_One_Diff
     (A1 : CGK.Reals.Real;
      A0 : CGK.Reals.Real;
      B  : CGK.Reals.Real;
      X2 : out CGK.Reals.Real;
      X1 : out CGK.Reals.Real;
      X0 : out CGK.Reals.Real)
   is
      Aux : CGK.Reals.Real;

   begin
      Two_Diff (A0, B, Aux, X0);
      Two_Sum (A1, Aux, X2, X1);
   end Two_One_Diff;

   -----------------
   -- Two_Product --
   -----------------

   procedure Two_Product
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real) is
   begin
      X := A * B;
      Two_Product_Tail (A, B, X, Y);
   end Two_Product;

   ----------------------
   -- Two_Product_Tail --
   ----------------------

   procedure Two_Product_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real)
   is
      AHi : CGK.Reals.Real;
      ALo : CGK.Reals.Real;
      BHi : CGK.Reals.Real;
      BLo : CGK.Reals.Real;
      E1  : CGK.Reals.Real;
      E2  : CGK.Reals.Real;
      E3  : CGK.Reals.Real;

   begin
      Split (A, AHi, ALo);
      Split (B, BHi, BLo);

      E1 := X - AHi * BHi;
      E2 := E1 - ALo * BHi;
      E3 := E2 - AHi * BLo;
      Y  := ALo * BLo - E3;
   end Two_Product_Tail;

   -------------
   -- Two_Sum --
   -------------

   procedure Two_Sum
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : out CGK.Reals.Real;
      Y : out CGK.Reals.Real) is
   begin
      X := A + B;
      Two_Sum_Tail (A, B, X, Y);
   end Two_Sum;

   ------------------
   -- Two_Sum_Tail --
   ------------------

   procedure Two_Sum_Tail
     (A : CGK.Reals.Real;
      B : CGK.Reals.Real;
      X : CGK.Reals.Real;
      Y : out CGK.Reals.Real)
   is
      B_Virt  : constant CGK.Reals.Real := X - A;
      A_Virt  : constant CGK.Reals.Real := X - B_Virt;
      B_Round : constant CGK.Reals.Real := B - B_Virt;
      A_Round : constant CGK.Reals.Real := A - A_Virt;

   begin
      Y := A_Round + B_Round;
   end Two_Sum_Tail;

   ------------------
   -- Two_Two_Diff --
   ------------------

   procedure Two_Two_Diff
     (A1 : CGK.Reals.Real;
      A0 : CGK.Reals.Real;
      B1 : CGK.Reals.Real;
      B0 : CGK.Reals.Real;
      X3 : out CGK.Reals.Real;
      X2 : out CGK.Reals.Real;
      X1 : out CGK.Reals.Real;
      X0 : out CGK.Reals.Real)
   is
      Aux_2 : CGK.Reals.Real;
      Aux_1 : CGK.Reals.Real;

   begin
      Two_One_Diff (A1, A0, B0, Aux_2, Aux_1, X0);
      Two_One_Diff (Aux_2, Aux_1, B1, X3, X2, X1);
   end Two_Two_Diff;

end CGK.Internals.Shewchuk_Arithmetic;
