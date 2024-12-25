--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

with CGK.Mathematics.Matrices_2x2;

package body CGK.Mathematics.Vectors_2 is

   use CGK.Reals;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left  : CGK.Mathematics.Matrices_2x2.Matrix_2x2;
      Right : Vector_2) return Vector_2 is
   begin
      return
        [0 => Left (0, 0) * Right (0) + Left (0, 1) * Right (1),
         1 => Left (1, 0) * Right (0) + Left (1, 1) * Right (1)];
   end "*";


   ---------
   -- "*" --
   ---------

   function "*" (Left : Vector_2; Right : CGK.Reals.Real) return Vector_2 is
   begin
      return [Left (0) * Right, Left (1) * Right];
   end "*";

   ---------
   -- "*" --
   ---------

   function "*" (Left : CGK.Reals.Real; Right : Vector_2) return Vector_2 is
   begin
      return [Left * Right (0), Left * Right (1)];
   end "*";

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Vector_2; Right : Vector_2) return Vector_2 is
   begin
      return [Left (0) * Right (0), Left (1) * Right (1)];
   end "*";

   ---------
   -- "+" --
   ---------

   function "+" (Left : Vector_2; Right : Vector_2) return Vector_2 is
   begin
      return [Left (0) + Right (0), Left (1) + Right (1)];
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Right : Vector_2) return Vector_2 is
   begin
      return [-Right (0), -Right (1)];
   end "-";

   ---------
   -- "-" --
   ---------

   function "-" (Left : Vector_2; Right : Vector_2) return Vector_2 is
   begin
      return [Left (0) - Right (0), Left (1) - Right (1)];
   end "-";

   ---------
   -- "/" --
   ---------

   function "/"
     (Left : Vector_2; Right : CGK.Reals.Real) return Vector_2 is
   begin
      return [Left (0) / Right, Left (1) / Right];
   end "/";

end CGK.Mathematics.Vectors_2;
