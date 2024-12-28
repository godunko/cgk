--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  This is portable version of the package.

pragma Ada_2022;

with CGK.Reals;

package CGK.Mathematics.Matrices_3x3
  with Pure
is

   type Matrix_3x3 is array (0 .. 2, 0 .. 2) of CGK.Reals.Real
     with Alignment => CGK.Reals.Real_Vector_3_Alignment;

   Identity : constant Matrix_3x3;

   procedure Set_Identity (Self : out Matrix_3x3) with Inline;
   --  Initialize matrix to identity.

   function "*"
     (Left : Matrix_3x3; Right : Matrix_3x3) return Matrix_3x3 with Inline;

private

   Identity : constant Matrix_3x3 :=
     [[1.0, 0.0, 0.0],
      [0.0, 1.0, 0.0],
      [0.0, 0.0, 1.0]];

end CGK.Mathematics.Matrices_3x3;
