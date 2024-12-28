--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  This is portable version of the package.

limited with CGK.Mathematics.Matrices_3x3;
with CGK.Reals;

package CGK.Mathematics.Vectors_3
  with Pure
is

   type Vector_3 is array (0 .. 2) of CGK.Reals.Real
     with Alignment => CGK.Reals.Real_Vector_3_Alignment;

   function "-" (Right : Vector_3) return Vector_3 with Inline;

   function "+"
     (Left : Vector_3; Right : Vector_3) return Vector_3 with Inline;

   function "-"
     (Left : Vector_3; Right : Vector_3) return Vector_3 with Inline;

   function "*"
     (Left : Vector_3; Right : CGK.Reals.Real) return Vector_3 with Inline;

   function "*"
     (Left : CGK.Reals.Real; Right : Vector_3) return Vector_3 with Inline;

   function "/"
     (Left : Vector_3; Right : CGK.Reals.Real) return Vector_3 with Inline;

   function "*"
     (Left  : CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Right : Vector_3) return Vector_3 with Inline;

end CGK.Mathematics.Vectors_3;
