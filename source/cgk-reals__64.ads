--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with Interfaces;

package CGK.Reals is

   pragma Pure;

   type Real is new Interfaces.IEEE_Float_64;

   function Resolution return Real is (Real'Model_Small);
   --  Tolerance criterion for geometric computations.

   function Epsilon (Value : Real) return Real;
   --  Returns absolute value of difference between given value and and other
   --  nearest value of real type. Nearest value is choosen in direction of
   --  infinity the same sign as given value.

   Real_Vector_2_Alignment : constant := 16;
   Real_Vector_3_Alignment : constant := 16;

end CGK.Reals;
