--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  This is portable version of the package.

with CGK.Reals;

package CGK.Mathematics.Matrices_3x3
  with Pure
is

   type Matrix_3x3 is array (0 .. 2, 0 .. 2) of CGK.Reals.Real
     with Alignment => CGK.Reals.Real_Vector_3_Alignment;

   procedure Set_Identity (Self : out Matrix_3x3) with Inline;
   --  Initialize matrix to identity.

   function "*"
     (Left : Matrix_3x3; Right : Matrix_3x3) return Matrix_3x3 with Inline;

end CGK.Mathematics.Matrices_3x3;
