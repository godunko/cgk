--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

with CGK.Mathematics.Matrices_3x3;

package body CGK.Mathematics.Vectors_3 is

   use CGK.Reals;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left  : CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Right : Vector_3) return Vector_3 is
   begin
      return
        [0 =>
           Left (0, 0) * Right (0)
             + Left (0, 1) * Right (1)
             + Left (0, 2) * Right (2),
         1 =>
           Left (1, 0) * Right (0)
             + Left (1, 1) * Right (1)
             + Left (1, 2) * Right (2),
         2 =>
           Left (2, 0) * Right (0)
             + Left (2, 1) * Right (1)
             + Left (2, 2) * Right (2)];
   end "*";

   ---------
   -- "*" --
   ---------

   function "*" (Left : Vector_3; Right : CGK.Reals.Real) return Vector_3 is
   begin
      return [for J in Vector_3'Range => Left (J) * Right];
   end "*";

   ---------
   -- "*" --
   ---------

   function "*" (Left : CGK.Reals.Real; Right : Vector_3) return Vector_3 is
   begin
      return [for J in Vector_3'Range => Left * Right (J)];
   end "*";

   ---------
   -- "+" --
   ---------

   function "+" (Left : Vector_3; Right : Vector_3) return Vector_3 is
   begin
      return [for J in Vector_3'Range => Left (J) + Right (J)];
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Right : Vector_3) return Vector_3 is
   begin
      return [for J in Vector_3'Range => -Right (J)];
   end "-";

   ---------
   -- "-" --
   ---------

   function "-" (Left : Vector_3; Right : Vector_3) return Vector_3 is
   begin
      return [for J in Vector_3'Range => Left (J) - Right (J)];
   end "-";

   ---------
   -- "/" --
   ---------

   function "/"
     (Left : Vector_3; Right : CGK.Reals.Real) return Vector_3 is
   begin
      return [for J in Vector_3'Range => Left (J) / Right];
   end "/";

   -------------------
   -- Cross_Product --
   -------------------

   function Cross_Product
     (Left : Vector_3; Right : Vector_3) return Vector_3 is
   begin
      return
        [Left (1) * Right (2) - Left (2) * Right (1),
         Left (2) * Right (0) - Left (0) * Right (2),
         Left (0) * Right (1) - Left (1) * Right (0)];
   end Cross_Product;

end CGK.Mathematics.Vectors_3;
